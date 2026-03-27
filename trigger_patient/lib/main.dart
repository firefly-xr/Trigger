import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'bloc/patient_bloc.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  // 1. This must always be first
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Local Storage (Hive) first because it's instant and offline-safe
  await Hive.initFlutter();
  await Hive.openBox('patientBox');

  // 3. Initialize Firebase inside a try/catch so a Wi-Fi drop doesn't crash the app
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(
      "🚨 Firebase failed to initialize. Check emulator internet! Error: $e",
    );
  }

  // 5. Run the app immediately!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trigger',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(color: Colors.redAccent),
              ),
            );
          }
          if (snapshot.hasData) {
            return BlocProvider(
              create: (_) => PatientBloc()..add(const PatientEvent.started()),
              child: const HomeScreen(),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
