import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> recipes = [];

  Future<void> fetchRecipes(String query) async {
    final url = Uri.parse(
        'https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$appKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(json.encode(data)); // For debugging

      setState(() {
        recipes = (data['hits'] as List)
            .map((hit) => hit['recipe'] as Map<String, dynamic>)
            .toList();
      });
    } else {
      print('Failed to fetch recipes: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: fetchRecipes,
              decoration: const InputDecoration(
                labelText: 'Enter a recipe name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  child: ListTile(
                    title: Text(recipe['label']),
                    subtitle: Text('Calories: ${recipe['calories'].toStringAsFixed(2)}'),
                    leading: recipe['image'] != null
                        ? Image.network(recipe['image'], width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.fastfood),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
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

  void launchURL(String url) {
    // Logic to open URL, you can use url_launcher package
  }
}