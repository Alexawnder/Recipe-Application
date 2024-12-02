import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black87,
      backgroundColor: const Color(0xFF7EA16B),
      selectedLabelStyle: const TextStyle(fontSize: 15.0),
      unselectedLabelStyle: const TextStyle(fontSize: 0.0), // Hide unselected labels
      type: BottomNavigationBarType.fixed, // Ensure consistent behavior
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/HomeIcon.png',
            width: 25.0,
            height: 25.0,
          ),
          label: selectedIndex == 0 ? 'Home' : '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/search.png',
            width: 25.0,
            height: 25.0,
          ),
          label: selectedIndex == 1 ? 'Search' : '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/fridge.png',
            width: 25.0,
            height: 25.0,
          ),
          label: selectedIndex == 2 ? 'Fridge' : '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/list.png',
            width: 25.0,
            height: 25.0,
          ),
          label: selectedIndex == 3 ? 'List' : '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/SavedRecipes.png',
            width: 25.0,
            height: 25.0,
          ),
          label: selectedIndex == 4 ? 'Saved' : '',
        ),
      ],
    );
  }
}
