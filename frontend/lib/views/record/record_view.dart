import 'package:flutter/material.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/widgets/under_bar.dart';

class RecordView extends StatelessWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Center(
        child: Text('Record Page'),
      ),
    );
  }
}
