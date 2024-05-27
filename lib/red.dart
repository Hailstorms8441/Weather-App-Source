import 'package:flutter/material.dart';

class Red extends StatelessWidget {
  const Red({super.key});

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
          'red'
          )
        ),
    );
  }
}