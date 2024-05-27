import 'package:flutter/material.dart';

class Blue extends StatelessWidget {
  const Blue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 87, 123, 141),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: const Center(
        child: Text(
          style: TextStyle(
            fontSize: 50.0
          ),
          'blue'
          )
        ),
    );
  }
}