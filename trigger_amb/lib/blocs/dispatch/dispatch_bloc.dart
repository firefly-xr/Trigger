import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dispatch_event.dart';
import 'dispatch_state.dart';
import '../../services/firestore_service.dart';
import '../../models/dispatch_alert.dart';
class DispatchBloc extends Bloc<DispatchEvent, DispatchState> {
  final FirestoreService _firestoreService;
  final String _driverId;
  StreamSubscription? _subscription;

  DispatchBloc({
    required FirestoreService firestoreService,
    String driverId = 'driver_1',
  })  : _firestoreService = firestoreService,
        _driverId = driverId,
        super(const DispatchState.idle()) {
          
    on<DispatchEvent>((event, emit) async {
      await event.map(
        receiveAlert: (e) async {
          // If we are simulating an alert not from Firestore
          emit(DispatchState.active(e.alert));
        },
        updateStatus: (e) async {
          await state.mapOrNull(
            active: (activeState) async {
              if (activeState.alert.id != null) {
                // Update Firestore and let the real-time stream update the UI
                await _firestoreService.updateDispatchStatus(activeState.alert.id!, e.status);
              } else {
                // Mock simulation update local only
                final updatedAlert = activeState.alert.copyWith(status: e.status);
                emit(DispatchState.active(updatedAlert));
              }
            },
          );
        },
        firestoreUpdate: (e) async {
          if (e.alert == null) {
            emit(const DispatchState.idle());
          } else {
            emit(DispatchState.active(e.alert!));
          }
        },
      );
    });

    // Start listening to live dispatches from Firestore
    _subscription = _firestoreService.listenToDriverDispatches(_driverId).listen((alert) {
      add(DispatchEvent.firestoreUpdate(alert));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
