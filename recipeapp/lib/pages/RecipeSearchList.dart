import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'RecipeDetails.dart';

class RecipeSearchList extends StatefulWidget {
  final String query;

  const RecipeSearchList({super.key, required this.query});

  @override
  _RecipeSearchListState createState() => _RecipeSearchListState();
}

class _RecipeSearchListState extends State<RecipeSearchList> {
  late Future<List<Map<String, dynamic>>> _recipesFuture;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.query;
    _recipesFuture = fetchRecipes(widget.query);  // Initial fetch with provided query
  }

  Future<List<Map<String, dynamic>>> fetchRecipes(String searchQuery) async {
    const appId = '630a63de';
    const appKey = '2ebdde9075b8b570315e2734bd35f0ce';
    final url = Uri.parse(
        'https://api.edamam.com/search?q=$searchQuery&app_id=$appId&app_key=$appKey');

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

  // Handle search submission
  void _handleSearch(String query) {
    setState(() {
      _recipesFuture = fetchRecipes(query);  // Fetch recipes when enter is pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _controller,
            onSubmitted: _handleSearch, // Trigger the search when the user hits enter
            decoration: InputDecoration(
              hintText: 'Search for recipes...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.search, // Display the search action on the keyboard
          ),
        ),
        backgroundColor: const Color(0xFF7EA16B),
      ),
      body: Container(
        color: Color(0xFFF9DEC9), 
        child: FutureBuilder<List<Map<String, dynamic>>>( 
          future: _recipesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No recipes found.'));
            } else {
              final recipes = snapshot.data!;

              return ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  var recipe = recipes[index];
                  var label = recipe['label'];
                  var imageUrl = recipe['image'];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                       tileColor: Color(0xFFC4A69D), 
                      leading: Image.network(imageUrl,
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(
                        label,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(recipe: recipe),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}






