import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pages/home.dart';  

const appId = '630a63de';
const appKey = '2ebdde9075b8b570315e2734bd35f0ce';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Recipe Finder'),  
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['label']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe['image'] != null)
              Center(
                child: Image.network(recipe['image']),
              ),
            const SizedBox(height: 16),
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ...List.generate(
              (recipe['ingredientLines'] as List).length,
              (index) => Text('- ${recipe['ingredientLines'][index]}'),
            ),
            const SizedBox(height: 16),
            Text(
              'Nutritional Information:',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text('Calories: ${recipe['calories'].toStringAsFixed(2)}'),
            // Add more nutritional details as needed
            const SizedBox(height: 16),
            Text(
              'Source: ${recipe['source']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              onPressed: () {
                launchURL(recipe['url']);
              },
              child: const Text('View Full Recipe'),
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
  
  }
}
