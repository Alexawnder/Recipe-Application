import 'package:flutter/material.dart';
import '../pages/RecipeSearchList.dart';

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
      onTap: (index) {
        if (index == 1) {
          // Navigate to RecipeSearchList when Search is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeSearchList(
                query: '', // Default query or current search query
              ),
            ),
          );
        } else {
          onItemTapped(index); 
        }
      },
      selectedItemColor: Colors.black, // Highlighted item color
      unselectedItemColor: Colors.black87, // Dimmed item color
      backgroundColor: const Color(0xFF7EA16B),
      selectedLabelStyle: TextStyle(fontSize: 15.0), 
      unselectedLabelStyle: TextStyle(fontSize: 15.0),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
         icon: Image.asset(
            'assets/images/HomeIcon.png',
            width: 35.0, 
            height: 35.0, 
          ),
          label: 'Home',
          
        ),
        BottomNavigationBarItem(
         icon: Image.asset(
            'assets/images/search.png',
            width: 35.0, 
            height: 35.0, 
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
         icon: Image.asset(
            'assets/images/SavedRecipes.png',
            width: 35.0, 
            height: 35.0, 
          ),
          label: 'Saved',
        ),
      ],
    );
  }
}

