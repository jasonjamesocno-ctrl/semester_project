
import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'login_screen.dart';
import 'report_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.account_balance, size: 20),
            SizedBox(width: 10),
            Text('LCO Home', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9F1EF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Color(0xFF119E94),
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to LCO!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF193F58),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your campus organizations, united in service.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: 'Create Report',
                  icon: const Icon(Icons.description_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ReportFormScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                AppButton(
                  text: 'Back to Login',
                  outlined: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
