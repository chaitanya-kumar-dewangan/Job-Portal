import 'package:flutter/material.dart';

class IndicatorBar extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  const IndicatorBar({required this.currentIndex, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        bool isActive = index == currentIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 25 : 25,
          height: 5,
          decoration: BoxDecoration(
            color: isActive ? Colors.red.shade900 : Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
