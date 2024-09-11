import 'package:flutter/material.dart';
import 'widgets/button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Hey soyeon',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'welcome!!',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
              ),
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              const Text(
                'money',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                      text: 'active',
                      bgColor: Color(0xFF1C1516),
                      textColor: Colors.white),
                  Button(
                      text: 'inActive',
                      bgColor: Color(0xFFE8E8E8),
                      textColor: Colors.white),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  Button(
                    text: 'run',
                    bgColor: Color(0xFFEC0F0F),
                    textColor: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
