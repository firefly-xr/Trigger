import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/dispatch/dispatch_bloc.dart';
import 'blocs/dispatch/dispatch_event.dart';
import 'blocs/dispatch/dispatch_state.dart';
import 'models/dispatch_alert.dart';
import 'ui/dispatch_alert_screen.dart';
import 'ui/live_navigation_screen.dart';
import 'services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LifeRouteApp());
}

class LifeRouteApp extends StatelessWidget {
  const LifeRouteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => FirestoreService()),
      ],
      child: BlocProvider(
        create: (context) => DispatchBloc(
          firestoreService: context.read<FirestoreService>(),
        ),
        child: MaterialApp(
          title: 'LifeRoute Sync',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            colorScheme: const ColorScheme.dark(
              primary: Colors.blueAccent,
              secondary: Colors.redAccent,
            ),
          ),
          home: const DriverDashboard(),
        ),
      ),
    );
  }
}

class DriverDashboard extends StatelessWidget {
  const DriverDashboard({Key? key}) : super(key: key);

  void _simulateDispatch(BuildContext context) {
    // Generate mock critical alert
    final mockAlert = const DispatchAlert(
      patientId: 'PT-98012',
      patientName: 'Ain Shamsudheen',
      latitude: 9.9667,
      longitude: 76.2667,
      aiSeverityScore: 1, // Critical
      aiSummary: 'Pedestrian struck by vehicle on MG Road, Kochi. Patient is unresponsive with suspected head trauma. Immediate transport to nearest Level 1 Trauma Center required.',
      status: DispatchStatus.dispatched,
    );
    
    context.read<DispatchBloc>().add(DispatchEvent.receiveAlert(mockAlert));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DispatchBloc, DispatchState>(
      listenWhen: (previous, current) {
        // Trigger modal only when entering 'dispatched' status
        final currentIsDispatched = current.maybeMap(
          active: (state) => state.alert.status == DispatchStatus.dispatched,
          orElse: () => false,
        );
        final previousIsDispatched = previous.maybeMap(
          active: (state) => state.alert.status == DispatchStatus.dispatched,
          orElse: () => false,
        );
        return currentIsDispatched && !previousIsDispatched;
      },
      listener: (context, state) {
        state.mapOrNull(
          active: (activeState) {
            if (activeState.alert.status == DispatchStatus.dispatched) {
              // Show Loud Dispatch Alert Modal
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => DispatchAlertScreen(
                    alert: activeState.alert,
                    onAccept: () {
                      // Update Status to En Route
                      context.read<DispatchBloc>().add(
                        const DispatchEvent.updateStatus(DispatchStatus.enRoute)
                      );
                      Navigator.pop(context); // Close the modal
                    },
                  ),
                ),
              );
            }
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LifeRoute: Driver Center'),
          backgroundColor: Colors.grey.shade900,
        ),
        body: Center(
          child: BlocBuilder<DispatchBloc, DispatchState>(
            builder: (context, state) {
              return state.map(
                idle: (_) {
                  return _buildIdleSim(context);
                },
                active: (activeState) {
                  // If we transitioned to idle from the button, the bloc might still hold active state with status idle.
                  // We handle it gracefully.
                  if (activeState.alert.status == DispatchStatus.idle || 
                      activeState.alert.status == DispatchStatus.dispatched) {
                    // Start showing the idle background while the loud dispatch modal overlaps it
                    return _buildIdleSim(context); 
                  }
                  
                  return LiveNavigationScreen(alert: activeState.alert);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIdleSim(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.local_hospital_outlined, size: 80, color: Colors.grey),
        const SizedBox(height: 20),
        const Text(
          'Status: IDLE',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          icon: const Icon(Icons.warning_amber_rounded),
          label: const Text('SIMULATE CRITICAL DISPATCH'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          onPressed: () => _simulateDispatch(context),
        ),
      ],
    );
  }
}
