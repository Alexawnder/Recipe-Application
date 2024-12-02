import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped; //  to switch tabs

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped, // Use the callback for tab switching
      selectedItemColor: Colors.black, // Highlighted item color
      unselectedItemColor: Colors.black87, // Dimmed item color
      backgroundColor: const Color(0xFF7EA16B),
      selectedLabelStyle: const TextStyle(fontSize: 15.0),
      unselectedLabelStyle: const TextStyle(fontSize: 15.0),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/HomeIcon.png',
            width: 25.0,
            height: 25.0,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/search.png',
            width: 25.0,
            height: 25.0,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/fridge.png',
            width: 25.0,
            height: 25.0,
          ),
          label: 'Fridge',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/list.png',
            width: 25.0,
            height: 25.0,
          ),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/SavedRecipes.png',
            width: 25.0,
            height: 25.0,
          ),
          label: 'Saved',
        ),
      ],
    );
  }
}
