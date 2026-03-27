import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../data/patient_repository.dart';
import '../data/models.dart';

part 'patient_event.dart';
part 'patient_state.dart';
part 'patient_bloc.freezed.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  Timer? _vitalsTimer;
  final Random _random = Random();
  final PatientRepository _repository;

  PatientBloc({PatientRepository? repository}) 
      : _repository = repository ?? PatientRepository(),
        super(const PatientState()) {
    on<Started>(_onStarted);
    on<VitalsUpdated>(_onVitalsUpdated);
    on<EmergencyTypeSelected>(_onEmergencyTypeSelected);
    on<SosTriggered>(_onSosTriggered);
    on<TriageAnswered>(_onTriageAnswered);
    on<SearchWearables>(_onSearchWearables);
    on<ConnectToDevice>(_onConnectToDevice);
    on<DisconnectWearable>(_onDisconnectWearable);
    on<AddEmergencyContact>(_onAddEmergencyContact);
    on<RemoveEmergencyContact>(_onRemoveEmergencyContact);
    on<UpdateMedicalHistory>(_onUpdateMedicalHistory);
    on<ReportForAnotherTriggered>(_onReportForAnotherTriggered);
  }

  Future<void> _onStarted(Started event, Emitter<PatientState> emit) async {
    final box = Hive.box('patientBox');

    // Default from Hive initially
    final contactsData = box.get('emergencyContacts') as List<dynamic>? ?? [];
    var contacts = contactsData.map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return EmergencyContact(name: map['name'] as String, number: map['number'] as String);
    }).toList();

    final deviceName = box.get('connectedDeviceName') as String?;

    final historyMap = box.get('medicalHistory') as Map<dynamic, dynamic>?;
    MedicalHistory? history;
    if (historyMap != null) {
      history = MedicalHistory(
        bloodType: historyMap['bloodType'] as String? ?? '',
        allergies: historyMap['allergies'] as String? ?? '',
        medicalConditions: historyMap['medicalConditions'] as String? ?? '',
        medications: historyMap['medications'] as String? ?? '',
      );
    }

    emit(state.copyWith(
      emergencyContacts: contacts,
      medicalHistory: history,
    ));

    // Try fetching from Firebase directly
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final profile = await _repository.getUserProfile(uid);
      if (profile != null) {
        // Map contacts
        contacts = profile.emergencyContacts.map((map) {
          return EmergencyContact(
            name: map['name'] as String? ?? '',
            number: map['number'] as String? ?? '',
          );
        }).toList();
        box.put('emergencyContacts', profile.emergencyContacts);

        // Map medical history
        if (profile.medicalHistoryDetails != null) {
          final mhd = profile.medicalHistoryDetails!;
          history = MedicalHistory(
            bloodType: mhd['bloodType'] as String? ?? profile.bloodGroup,
            allergies: mhd['allergies'] as String? ?? '',
            medicalConditions: mhd['medicalConditions'] as String? ?? '',
            medications: mhd['medications'] as String? ?? '',
          );
          
          box.put('medicalHistory', {
            'bloodType': history.bloodType,
            'allergies': history.allergies,
            'medicalConditions': history.medicalConditions,
            'medications': history.medications,
          });
        }
        
        emit(state.copyWith(emergencyContacts: contacts, medicalHistory: history));
      }
    }

    if (deviceName != null) {
      add(ConnectToDevice(deviceName: deviceName));
    }
  }

  void _onVitalsUpdated(VitalsUpdated event, Emitter<PatientState> emit) {
    emit(state.copyWith(heartRate: event.heartRate, spO2: event.spO2));
  }

  void _onEmergencyTypeSelected(
    EmergencyTypeSelected event,
    Emitter<PatientState> emit,
  ) {
    emit(state.copyWith(selectedEmergencyType: event.type));
  }

  void _onSosTriggered(SosTriggered event, Emitter<PatientState> emit) {
    emit(state.copyWith(showTriageQuestions: true));
  }

  Future<void> _onTriageAnswered(TriageAnswered event, Emitter<PatientState> emit) async {
    emit(
      state.copyWith(
        isConscious: event.isConscious,
        hasSevereBleeding: event.hasSevereBleeding,
        showTriageQuestions: false,
        sosStatus: SosStatus.active,
      ),
    );

    final payload = EmergencyEvent(
      id: '',
      patientId: '', 
      status: 'pending_triage',
      vitalsSnapshot: {
        'heartRate': state.heartRate,
        'spO2': state.spO2,
      },
      aiSeverityScore: event.hasSevereBleeding ? 9 : 5, 
      aiSummary: 'Patient reports: Conscious=${event.isConscious}, Severe Bleeding=${event.hasSevereBleeding}',
    );

    // 1. App's internal emergency state
    await _repository.triggerSOS(payload);

    // 2. Web Dispatch Dashboard Integration
    final type = state.selectedEmergencyType;
    final condition = type == EmergencyType.heart ? 'Heart Attack' :
                      type == EmergencyType.accident ? 'Car Accident' :
                      type == EmergencyType.fire ? 'Fire Emergency' : 
                      'General Emergency';
    
    // AI Severity Metric mapping:
    // If unconscious or bleeding severely -> 1 (Critical)
    // Otherwise -> 2 (Urgent)
    final severity = (!event.isConscious || event.hasSevereBleeding) ? 1 : 2;

    // Hardcoding dummy Kochi coordinates (near Marine Drive) so it shows up beautifully on your map for the demo
    await _repository.triggerEmergencySOS(
      9.9760, 
      76.2750, 
      condition, 
      severity,
    );
  }

  Future<void> _onReportForAnotherTriggered(ReportForAnotherTriggered event, Emitter<PatientState> emit) async {
    int parsedAge = 30;
    try {
      parsedAge = int.parse(event.age);
    } catch (_) {}

    await _repository.triggerEmergencySOSForAnother(
      9.9760, 
      76.2750, 
      event.condition, 
      2, // Default to Urgent for another person lacking vitals
      event.name,
      parsedAge,
    );
  }

  void _onSearchWearables(SearchWearables event, Emitter<PatientState> emit) {
    emit(
      state.copyWith(
        availableDevices: [
          'Apple Watch Series 9',
          'Garmin Fenix 7',
          'Galaxy Watch 6',
        ],
      ),
    );
  }

  Future<void> _onConnectToDevice(
    ConnectToDevice event,
    Emitter<PatientState> emit,
  ) async {
    emit(state.copyWith(isConnecting: true));
    await Future.delayed(const Duration(seconds: 2));
    
    Hive.box('patientBox').put('connectedDeviceName', event.deviceName);

    emit(
      state.copyWith(
        isConnecting: false,
        isWearableConnected: true,
        connectedDeviceName: event.deviceName,
      ),
    );
    // Start streaming vitals after connection
    _startMockVitalsStream();
  }

  void _onDisconnectWearable(
    DisconnectWearable event,
    Emitter<PatientState> emit,
  ) {
    _vitalsTimer?.cancel();
    Hive.box('patientBox').delete('connectedDeviceName');
    
    emit(
      state.copyWith(
        isWearableConnected: false,
        connectedDeviceName: null,
        heartRate: 0,
        spO2: 0,
      ),
    );
  }

  Future<void> _onAddEmergencyContact(
    AddEmergencyContact event,
    Emitter<PatientState> emit,
  ) async {
    if (state.emergencyContacts.length < 3 &&
        !state.emergencyContacts.any((c) => c.number == event.number)) {
      final newContact = EmergencyContact(
        name: event.name,
        number: event.number,
      );
      final updatedList = List<EmergencyContact>.from(state.emergencyContacts)
        ..add(newContact);
        
      final serializedList = updatedList.map((c) => {'name': c.name, 'number': c.number}).toList();
      Hive.box('patientBox').put('emergencyContacts', serializedList);

      await _repository.updateEmergencyContacts(serializedList);

      emit(state.copyWith(emergencyContacts: updatedList));
    }
  }

  Future<void> _onRemoveEmergencyContact(
    RemoveEmergencyContact event,
    Emitter<PatientState> emit,
  ) async {
    final updatedList = List<EmergencyContact>.from(state.emergencyContacts)
      ..remove(event.contact);
      
    final serializedList = updatedList.map((c) => {'name': c.name, 'number': c.number}).toList();
    Hive.box('patientBox').put('emergencyContacts', serializedList);

    await _repository.updateEmergencyContacts(serializedList);

    emit(state.copyWith(emergencyContacts: updatedList));
  }

  Future<void> _onUpdateMedicalHistory(
    UpdateMedicalHistory event,
    Emitter<PatientState> emit,
  ) async {
    Hive.box('patientBox').put('medicalHistory', {
      'bloodType': event.history.bloodType,
      'allergies': event.history.allergies,
      'medicalConditions': event.history.medicalConditions,
      'medications': event.history.medications,
    });

    await _repository.updateMedicalHistoryFields(
      bloodType: event.history.bloodType,
      allergies: event.history.allergies,
      medicalConditions: event.history.medicalConditions,
      medications: event.history.medications,
    );

    emit(state.copyWith(medicalHistory: event.history));
  }

  void _startMockVitalsStream() {
    _vitalsTimer?.cancel();
    _vitalsTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // Mock emergency vitals: high heart rate, low-ish SpO2
      final hr = 120 + _random.nextInt(16); // 120 - 135 BPM
      final spo2 = 90 + _random.nextInt(6); // 90 - 95%
      add(PatientEvent.vitalsUpdated(heartRate: hr, spO2: spo2));
    });
  }

  @override
  Future<void> close() {
    _vitalsTimer?.cancel();
    return super.close();
  }
}
