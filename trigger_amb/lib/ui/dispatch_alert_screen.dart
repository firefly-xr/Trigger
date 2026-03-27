import 'package:flutter/material.dart';
import '../../models/dispatch_alert.dart';

class DispatchAlertScreen extends StatelessWidget {
  final DispatchAlert alert;
  final VoidCallback onAccept;

  const DispatchAlertScreen({
    super.key,
    required this.alert,
    required this.onAccept,
  });

  Color _getSeverityColor(int score) {
    if (score == 1) return const Color.fromARGB(255, 202, 38, 38);
    if (score == 2) return const Color.fromARGB(255, 228, 97, 58);
    if (score == 3) return Colors.orange;
    if (score == 4) return Colors.amber.shade700;
    return Colors.green.shade700; // 5
  }

  String _getSeverityLabel(int score) {
    if (score == 1) return "CRITICAL";
    if (score == 2) return "HIGH";
    if (score == 3) return "MODERATE";
    if (score == 4) return "LOW";
    return "ROUTINE";
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getSeverityColor(alert.aiSeverityScore);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.warning_rounded, size: 80, color: Colors.white),
              const SizedBox(height: 24),
              const Text(
                "NEW DISPATCH",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Severity: ${_getSeverityLabel(alert.aiSeverityScore)} (${alert.aiSeverityScore}/5)",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "AI PATIENT SUMMARY",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Patient: ${alert.patientName ?? 'Unknown'}\n\n${alert.aiSummary}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: onAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: bgColor,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                ),
                child: const Text(
                  "ACCEPT & ROUTE",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
