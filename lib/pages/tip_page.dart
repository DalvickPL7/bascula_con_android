import 'package:flutter/material.dart';

class TipPage extends StatelessWidget {
  const TipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("Consejo"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
