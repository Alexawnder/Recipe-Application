import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pages/home.dart';
import 'pages/RecipeDetails.dart';
import 'package:provider/provider.dart';
import 'providers/FridgeContentsProvider.dart';
import 'pages/RecipeSearchList.dart';
import 'pages/Fridge.dart';
import 'pages/GroceryList.dart';
import 'pages/SavedRecipes.dart';
import 'components/NavBar.dart';
import '../providers/GroceryListProvider.dart'; // Import the provider

const appId = '630a63de';
const appKey = '2ebdde9075b8b570315e2734bd35f0ce';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FridgeContentsProvider()),
        ChangeNotifierProvider(create: (_) => GroceryListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savorly',
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
  final List<Map<String, dynamic>> _savedRecipes = []; // Shared saved recipes list

  // Callback for BottomNavBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          MyHomePage(
            title: 'Recipe Finder',
            savedRecipes: _savedRecipes,
            onItemTapped: _onItemTapped,
          ),
          RecipeSearchList(
            query: '',
            savedRecipes: _savedRecipes,
            onSave: (recipe) {
              setState(() {
                if (_savedRecipes.any((saved) => saved['label'] == recipe['label'])) {
                  _savedRecipes.removeWhere((saved) => saved['label'] == recipe['label']);
                } else {
                  _savedRecipes.add(recipe);
                }
              });
            },
          ),
          Fridge(), // Fridge doesn't need `savedRecipes` or `onSave`
          GroceryList(
          ),
          SavedRecipes(
            savedRecipes: _savedRecipes,
            onSave: (recipe) {
              setState(() {
                if (_savedRecipes.any((saved) => saved['label'] == recipe['label'])) {
                  _savedRecipes.removeWhere((saved) => saved['label'] == recipe['label']);
                } else {
                  _savedRecipes.add(recipe);
                }
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // Pass callback to BottomNavBar
      ),
    );
  }
}
