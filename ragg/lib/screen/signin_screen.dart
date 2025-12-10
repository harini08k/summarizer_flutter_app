import 'package:ragg/auth.dart';
import 'package:ragg/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget { 
  const SigninScreen({super.key}); 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Document Summariser",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "AI-powered summaries in seconds ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: 260,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final user = await signInWithGoogle(); 
                  if (user != null && context.mounted) { 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // pure rectangle
                    side: const BorderSide(color: Colors.black),
                  ),
                  elevation: 1,
                ),
                child: const Text("Sign In with Google"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
