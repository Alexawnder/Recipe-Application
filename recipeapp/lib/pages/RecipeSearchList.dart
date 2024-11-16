import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'RecipeDetails.dart';

class RecipeSearchList extends StatelessWidget {
  final String query;

  const RecipeSearchList({super.key, required this.query});

  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    const appId = '630a63de';
    const appKey = '2ebdde9075b8b570315e2734bd35f0ce';
    final url = Uri.parse(
        'https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$appKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hits'] as List)
          .map((hit) => hit['recipe'] as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recipes found.'));
        } else {
          final recipes = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text('Search Results'),
            ),
            body: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                var recipe = recipes[index];
                var label = recipe['label'];
                var imageUrl = recipe['image'];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(imageUrl,
                        width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(
                      label,
                      style: GoogleFonts.dancingScript(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7EA16B),
                      ),
                    ),
                    onTap: () {
                      // Navigate to the RecipeDetails screen when a recipe is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetails(
                              recipe: recipe), // Passing the recipe to RecipeDetails
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
