import 'package:flutter/material.dart';
import 'package:frontend/widgets/under_bar.dart';

class RunnerPickView extends StatelessWidget {
  const RunnerPickView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Runner Pick Page'),
      ),
      bottomNavigationBar: UnderBar(),
    );
  }
}
