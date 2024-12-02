import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RecipeDetails.dart';

class SavedRecipes extends StatelessWidget {
  final List<Map<String, dynamic>> savedRecipes;
  final Function(Map<String, dynamic>)
      onSave; // callback to remove/unsave a recipe
  const SavedRecipes({
    super.key,
    required this.savedRecipes,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Recipes',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000000),
          ),
        ),
        backgroundColor: const Color(0xFF7EA16B),
      ),
      backgroundColor: Color(0xFFF9DEC9),
      body: savedRecipes.isEmpty
          ? const Center(
              child: Text(
                'No saved recipes yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
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
                      tileColor: Color(0xFFC4A69D),
                      leading: Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        label,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          onSave(
                              recipe); // triggers callback to remove the recipe
                        },
                      ),
                      onTap: () {
                        // navigates to the recipe page of the corresp. recipe
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(recipe: recipe),
                          ),
                        );
                      },
                    ));
              },
            ),
    );
  }
}
