import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.onItemTapped});
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(0),
      child: Container(
        width: 60,
        height: 36,
        decoration: BoxDecoration(
          color: Color(0xFF1C1516),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '등록',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
