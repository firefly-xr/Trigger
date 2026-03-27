import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker_plus/flutter_native_contact_picker_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/patient_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Trigger',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? const _HomeTab()
          : _selectedIndex == 1
          ? const _ReportTab()
          : const _SettingsTab(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientBloc, PatientState>(
      listenWhen: (previous, current) =>
          !previous.showTriageQuestions && current.showTriageQuestions,
      listener: (context, state) {
        _showTriageDialog(context);
      },
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<PatientBloc, PatientState>(
                        builder: (context, state) {
                          return state.isWearableConnected
                              ? const _LiveVitalsCard()
                              : const _ConnectWearableSection();
                        },
                      ),
                      const SizedBox(height: 32),
                      const _SosButton(),
                      const SizedBox(height: 32),
                      const _EmergencyCategories(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showTriageDialog(BuildContext context) {
    bool isConscious = true;
    bool hasSevereBleeding = false;
    final patientBloc = context.read<PatientBloc>();

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (stateContext, setState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orangeAccent,
                        size: 32,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Emergency Triage',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Question 1
                  const Text(
                    'Are you conscious / able to respond?',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: true,
                          groupValue: isConscious,
                          activeColor: Colors.redAccent,
                          onChanged: (val) =>
                              setState(() => isConscious = val!),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text(
                            'No',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: false,
                          groupValue: isConscious,
                          activeColor: Colors.redAccent,
                          onChanged: (val) =>
                              setState(() => isConscious = val!),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12, height: 32),

                  // Question 2
                  const Text(
                    'Do you have severe or uncontrollable bleeding?',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: true,
                          groupValue: hasSevereBleeding,
                          activeColor: Colors.redAccent,
                          onChanged: (val) =>
                              setState(() => hasSevereBleeding = val!),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text(
                            'No',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: false,
                          groupValue: hasSevereBleeding,
                          activeColor: Colors.redAccent,
                          onChanged: (val) =>
                              setState(() => hasSevereBleeding = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      // Dispatch the results back to BLoC!
                      patientBloc.add(
                        TriageAnswered(
                          isConscious: isConscious,
                          hasSevereBleeding: hasSevereBleeding,
                        ),
                      );
                    },
                    child: const Text(
                      'DISPATCH AMBULANCE NOW',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ReportTab extends StatefulWidget {
  const _ReportTab();

  @override
  State<_ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<_ReportTab> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _conditionController = TextEditingController();

  void _dispatchReportSos() {
    if (_nameController.text.isEmpty || _conditionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name and condition')),
      );
      return;
    }

    context.read<PatientBloc>().add(
      PatientEvent.reportForAnotherTriggered(
        name: _nameController.text,
        age: _ageController.text.isEmpty ? '30' : _ageController.text,
        condition: _conditionController.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('SOS Dispatched for Another Person')),
    );

    // clear the form
    _nameController.clear();
    _ageController.clear();
    _conditionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.person_add_alt_1,
                  color: Colors.blueAccent,
                  size: 32,
                ),
                SizedBox(width: 12),
                Text(
                  'Report For Another',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter details for the person experiencing the emergency.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Patient Name',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _ageController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Approximate Age',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _conditionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Condition/Symptoms',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onTap: _dispatchReportSos,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.6),
                      blurRadius: 50,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Wearable Device',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (state.isWearableConnected)
                ListTile(
                  tileColor: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: const Icon(Icons.watch, color: Colors.blueAccent),
                  title: Text(
                    state.connectedDeviceName ?? 'Connected Device',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Connected',
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.bluetooth_disabled,
                      color: Colors.grey,
                    ),
                    tooltip: 'Disconnect',
                    onPressed: () => context.read<PatientBloc>().add(
                      const DisconnectWearable(),
                    ),
                  ),
                )
              else
                ListTile(
                  tileColor: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: const Icon(Icons.watch, color: Colors.blueAccent),
                  title: const Text(
                    'Pair Smartwatch',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Tap to scan for devices',
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.add, color: Colors.blueAccent),
                  onTap: () {
                    context.read<PatientBloc>().add(const SearchWearables());
                    showDeviceListBottomSheet(context);
                  },
                ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Emergency Contacts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (state.emergencyContacts.length < 3)
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () => _showAddContactDialog(context),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (state.emergencyContacts.isEmpty)
                const Text(
                  'No contacts added. Add up to 3 numbers to alert during SOS.',
                  style: TextStyle(color: Colors.grey),
                ),
              for (final contact in state.emergencyContacts)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.contact_phone, color: Colors.grey),
                  title: Text(
                    contact.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    contact.number,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.redAccent),
                    onPressed: () => context.read<PatientBloc>().add(
                      RemoveEmergencyContact(contact),
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              _buildMedicalHistorySection(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMedicalHistorySection(BuildContext context, PatientState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Medical Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.medical_information,
              color: Colors.redAccent,
            ),
            title: const Text(
              'Medical History',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              state.medicalHistory?.bloodType.isNotEmpty == true
                  ? 'Blood Type: ${state.medicalHistory!.bloodType}'
                  : 'Tap to configure',
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: const Icon(Icons.edit, color: Colors.grey),
            onTap: () => _showEditMedicalHistoryDialog(context, state),
          ),
        ),
      ],
    );
  }

  void _showEditMedicalHistoryDialog(BuildContext context, PatientState state) {
    final bloodController = TextEditingController(
      text: state.medicalHistory?.bloodType ?? '',
    );
    final allergyController = TextEditingController(
      text: state.medicalHistory?.allergies ?? '',
    );
    final conditionsController = TextEditingController(
      text: state.medicalHistory?.medicalConditions ?? '',
    );
    final medsController = TextEditingController(
      text: state.medicalHistory?.medications ?? '',
    );

    final patientBloc = context.read<PatientBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'Medical Profile',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildModernTextField(bloodController, 'Blood Type (e.g. O+)'),
              const SizedBox(height: 12),
              _buildModernTextField(allergyController, 'Allergies'),
              const SizedBox(height: 12),
              _buildModernTextField(conditionsController, 'Chronic Conditions'),
              const SizedBox(height: 12),
              _buildModernTextField(medsController, 'Current Medications'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              patientBloc.add(
                UpdateMedicalHistory(
                  MedicalHistory(
                    bloodType: bloodController.text.trim(),
                    allergies: allergyController.text.trim(),
                    medicalConditions: conditionsController.text.trim(),
                    medications: medsController.text.trim(),
                  ),
                ),
              );
              Navigator.pop(dialogContext);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _ConnectWearableSection extends StatelessWidget {
  const _ConnectWearableSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        if (state.isConnecting) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.blueAccent.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Column(
              children: const [
                CircularProgressIndicator(color: Colors.blueAccent),
                SizedBox(height: 16),
                Text(
                  'Pairing with wearable...',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            context.read<PatientBloc>().add(const SearchWearables());
            showDeviceListBottomSheet(context);
          },
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.watch, color: Colors.blueAccent, size: 40),
                SizedBox(width: 16),
                Text(
                  'Connect Wearable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _showAddContactDialog(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final patientBloc = context.read<PatientBloc>();
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text('Add Contact', style: TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Name',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: numberController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.contacts, color: Colors.blueAccent),
                tooltip: 'Pick from Contacts',
                onPressed: () async {
                  try {
                    final picker = FlutterContactPickerPlus();
                    final contact = await picker.selectContact();
                    if (contact != null &&
                        contact.phoneNumbers != null &&
                        contact.phoneNumbers!.isNotEmpty) {
                      nameController.text = contact.fullName ?? '';
                      numberController.text = contact.phoneNumbers!.first;
                    }
                  } catch (e) {
                    // User cancelled or no permission
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                numberController.text.isNotEmpty) {
              patientBloc.add(
                AddEmergencyContact(nameController.text, numberController.text),
              );
              Navigator.pop(dialogContext);
            }
          },
          child: const Text('Add', style: TextStyle(color: Colors.blueAccent)),
        ),
      ],
    ),
  );
}

void showDeviceListBottomSheet(BuildContext context) {
  final patientBloc = context.read<PatientBloc>();
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1E1E1E),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return BlocBuilder<PatientBloc, PatientState>(
        bloc: patientBloc,
        builder: (builderContext, state) {
          if (state.availableDevices.isEmpty) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Available Devices',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...state.availableDevices.map(
                  (device) => ListTile(
                    leading: const Icon(
                      Icons.bluetooth,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      device,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      patientBloc.add(ConnectToDevice(deviceName: device));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _LiveVitalsCard extends StatefulWidget {
  const _LiveVitalsCard();

  @override
  State<_LiveVitalsCard> createState() => _LiveVitalsCardState();
}

class _LiveVitalsCardState extends State<_LiveVitalsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        return ScaleTransition(
          scale: _pulseAnimation,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.redAccent.withValues(alpha: 0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _VitalItem(
                  icon: Icons.favorite,
                  iconColor: Colors.redAccent,
                  label: 'Heart Rate',
                  value: '${state.heartRate} BPM',
                ),
                Container(
                  width: 2,
                  height: 60,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                _VitalItem(
                  icon: Icons.water_drop,
                  iconColor: Colors.blueAccent,
                  label: 'SpO2',
                  value: '${state.spO2}%',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VitalItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _VitalItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 40),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 18, color: Colors.grey[400])),
      ],
    );
  }
}

class _SosButton extends StatelessWidget {
  const _SosButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PatientBloc>().add(const PatientEvent.sosTriggered());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SOS Triggered - Triage Initiated')),
        );
      },
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.6),
              blurRadius: 50,
              spreadRadius: 10,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'SOS',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 4,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmergencyCategories extends StatelessWidget {
  const _EmergencyCategories();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _CategoryButton(
              icon: Icons.monitor_heart,
              iconColor: Colors.pinkAccent,
              label: 'Heart',
              isSelected: state.selectedEmergencyType == EmergencyType.heart,
              onTap: () => context.read<PatientBloc>().add(
                const PatientEvent.emergencyTypeSelected(EmergencyType.heart),
              ),
            ),
            _CategoryButton(
              icon: Icons.car_crash,
              iconColor: Colors.orangeAccent,
              label: 'Accident',
              isSelected: state.selectedEmergencyType == EmergencyType.accident,
              onTap: () => context.read<PatientBloc>().add(
                const PatientEvent.emergencyTypeSelected(
                  EmergencyType.accident,
                ),
              ),
            ),
            _CategoryButton(
              icon: Icons.local_fire_department,
              iconColor: Colors.redAccent,
              label: 'Fire',
              isSelected: state.selectedEmergencyType == EmergencyType.fire,
              onTap: () => context.read<PatientBloc>().add(
                const PatientEvent.emergencyTypeSelected(EmergencyType.fire),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.icon,
    this.iconColor = Colors.white,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.redAccent.withValues(alpha: 0.2)
              : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.redAccent : iconColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.redAccent : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
