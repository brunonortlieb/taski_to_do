import 'package:flutter/material.dart';

BottomNavigationBarItem customNavBarItem({
  required String iconPath,
  required String label,
}) {
  return BottomNavigationBarItem(
    key: Key(label),
    icon: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ImageIcon(AssetImage(iconPath)),
    ),
    label: label,
  );
}
