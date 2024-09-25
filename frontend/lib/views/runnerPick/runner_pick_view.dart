import 'package:flutter/material.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/widgets/search/search_read_only.dart';

import '../search/widget/search_bar.dart';

class RunnerPickView extends StatelessWidget {
  const RunnerPickView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SearchReadOnly(),
          ],
        ),
      ),
    );
  }
}
