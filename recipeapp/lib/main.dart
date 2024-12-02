import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pages/home.dart';  
import 'pages/RecipeDetails.dart';
import 'package:provider/provider.dart';
import 'providers/FridgeContentsProvider.dart';
import 'package:recipeapp/pages/RecipeSearchList.dart';
import 'pages/home.dart'; 
import 'pages/RecipeDetails.dart'; 
import 'components/NavBar.dart'; 

const appId = '630a63de';
const appKey = '2ebdde9075b8b570315e2734bd35f0ce';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FridgeContentsProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define the pages for each navigation item
  final List<Widget> _pages = [
    const MyHomePage(title: 'Recipe Finder'), // Home page
    const RecipeSearchList(query: ''), // Placeholder for Search
    Center(child: Text('Saved Recipes Page in Progress', style: TextStyle(fontSize: 24))), // Placeholder for Saved Recipes Page
  ];

  // Handle navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the current page
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

