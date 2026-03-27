import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/patient_bloc.dart';
import '../data/patient_repository.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true; // Toggle between Login and Sign Up
  bool _needsProfileCompletion = false;

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => PatientBloc()..add(const PatientEvent.started()),
          child: const HomeScreen(),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_needsProfileCompletion) {
      final name = _nameController.text.trim();
      final ageText = _ageController.text.trim();
      if (name.isEmpty || ageText.isEmpty) {
        _showError('Please enter your name and age');
        return;
      }
      final age = int.tryParse(ageText) ?? 30;
      setState(() => _isLoading = true);
      try {
        final uid = FirebaseAuth.instance.currentUser!.uid;
        await PatientRepository().updateUserProfileNameAndAge(uid, name, age);
        _navigateToHome();
      } catch (e) {
        _showError(e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter an email and password');
      return;
    }

    if (!_isLogin && (name.isEmpty || _ageController.text.trim().isEmpty)) {
      _showError('Please enter your full name and age to sign up');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isLogin) {
        // --- LOGIN FLOW ---
        final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final profile = await PatientRepository().getUserProfile(cred.user!.uid);
        if (profile == null || profile.fullName.isEmpty || profile.age == null) {
          if (profile != null) {
            _nameController.text = profile.fullName;
            if (profile.age != null) _ageController.text = profile.age.toString();
          }
          setState(() {
            _needsProfileCompletion = true;
          });
          return; // Stay on login screen to complete profile
        }
        _navigateToHome();
      } else {
        // --- SIGN UP FLOW ---
        final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final age = int.tryParse(_ageController.text.trim()) ?? 30;
        await PatientRepository().createUserProfile(
          cred.user!.uid,
          fullName: name,
          age: age,
        );
        _navigateToHome();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'invalid-credential' ||
          e.code == 'wrong-password') {
        _showError(
          _isLogin
              ? 'Incorrect email or password.'
              : 'Email might already be in use or invalid.',
        );
      } else if (e.code == 'email-already-in-use') {
        _showError('This email is already registered. Please login instead.');
      } else if (e.code == 'weak-password') {
        _showError('The password is too weak. (Min 6 characters)');
      } else {
        _showError(e.message ?? e.toString());
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(icon, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.health_and_safety,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 24),
              const Text(
                'Trigger',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Patient Emergency Portal',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 48),

              if (_needsProfileCompletion)
                Column(
                  children: [
                    const Text(
                      'Please complete your profile details.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration('Full Name', Icons.person),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _ageController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('Age', Icons.calendar_today),
                    ),
                    const SizedBox(height: 32),
                  ],
                )
              else
                Column(
                  children: [
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: _isLogin
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: const SizedBox(
                        width: double.infinity,
                      ), // Empty space for Login
                      secondChild: Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            textCapitalization: TextCapitalization.words,
                            decoration: _inputDecoration('Full Name', Icons.person),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _ageController,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration('Age', Icons.calendar_today),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
      
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration('Email Address', Icons.email),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: _inputDecoration('Password', Icons.lock),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),

              if (_isLoading)
                const CircularProgressIndicator(color: Colors.redAccent)
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                        _needsProfileCompletion ? 'Save Profile' : _isLogin ? 'Login' : 'Create Account',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (!_needsProfileCompletion)
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                                _emailController.clear();
                                _passwordController.clear();
                                _nameController.clear();
                                _ageController.clear();
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? "Don't have an account? Sign Up"
                                  : "Already have an account? Login",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) =>
                                      PatientBloc()
                                        ..add(const PatientEvent.started()),
                                  child: const HomeScreen(),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Skip Login (Hackathon Demo)',
                              style: TextStyle(color: Colors.white38, fontSize: 14),
                            ),
                          ),
                        ]
                      )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
