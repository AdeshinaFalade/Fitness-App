import 'package:flutter/material.dart';

BottomNavigationBar menuBottom(int currentIndex, void Function(int) onTap) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.monitor_weight),
        label: 'BMI',
      ),
    ],
  );
}
