import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedRecipes extends StatelessWidget {
  final List<Map<String, dynamic>> savedRecipes;

  const SavedRecipes({super.key, required this.savedRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Recipes'),
      ),
      body: savedRecipes.isEmpty
          ? const Center(
              child: Text(
                'No saved recipes yet.',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: savedRecipes.length,
              itemBuilder: (context, index) {
                final recipe = savedRecipes[index];
                final label = recipe['label'];
                final imageUrl = recipe['image'];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      label,
                      style: GoogleFonts.dancingScript(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7EA16B),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
