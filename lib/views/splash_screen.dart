import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_etaum4bz.json', // Replace with your Lottie animation file path
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tic Tac',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
