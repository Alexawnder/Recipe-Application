import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/FridgeContentsProvider.dart';
import '../types/ingredient.dart';
import 'package:provider/provider.dart';
import '../providers/GroceryListProvider.dart'; 
import 'package:google_fonts/google_fonts.dart';

class RecipeDetails extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final cleanedRecipe = recipe.cast<String, dynamic>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cleanedRecipe['label'] ?? 'Recipe',
          style: GoogleFonts.playfairDisplay(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000000),
          ),
        ),
        backgroundColor: const Color(0xFF7EA16B),
      ),
      body: SingleChildScrollView( // Makes the entire page scrollable
        child: Container(
          color: const Color(0xFFF9DEC9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Recipe Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  cleanedRecipe['label'] ?? 'Recipe',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              if (cleanedRecipe['image'] != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      cleanedRecipe['image'],
                      height: MediaQuery.of(context).size.height * 0.4, // Adjust height dynamically
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Tab Layout for Ingredients and Nutrition
              DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TabBar(
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: const [
                        Tab(text: 'Ingredients'),
                        Tab(text: 'Nutrition'),
                      ],
                    ),
                    SizedBox(
                      height: 500, // Fixed height for TabBarView
                      child: TabBarView(
                        children: [
                          // Ingredients Tab
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
                            itemCount: (cleanedRecipe['ingredientLines'] as List<dynamic>?)?.length ?? 0,
                            itemBuilder: (context, index) {
                              final ingredientData = {
                                "original": (cleanedRecipe['ingredientLines'] as List<dynamic>)[index],
                                "name": (cleanedRecipe['ingredientLines'] as List<dynamic>)[index],
                              };
                              final ingredient = Ingredient(ingredientData);

                              return Card(
                                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                color: const Color(0xFFC4A69D),
                                child: ListTile(
                                  title: Text(
                                    ingredient.name,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                  subtitle: Text(
                                    ingredient.original,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 14,
                                      color: const Color(0xFF807471),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.add, color: Colors.green),
                                    onPressed: () {
                                      final fridgeContentsProvider =
                                          Provider.of<FridgeContentsProvider>(context, listen: false);

                                      fridgeContentsProvider.addIngredient(ingredient);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${ingredient.name} added to the fridge!'),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          // Nutrition Tab
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Calories: ${cleanedRecipe['calories']?.toStringAsFixed(2) ?? 'N/A'}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                if (cleanedRecipe.containsKey('totalNutrients'))
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (cleanedRecipe['totalNutrients']['FAT'] != null)
                                        Text(
                                          'Fat: ${cleanedRecipe['totalNutrients']['FAT']['quantity'].toStringAsFixed(2)} ${cleanedRecipe['totalNutrients']['FAT']['unit']}',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      if (cleanedRecipe['totalNutrients']['CHOCDF'] != null)
                                        Text(
                                          'Carbs: ${cleanedRecipe['totalNutrients']['CHOCDF']['quantity'].toStringAsFixed(2)} ${cleanedRecipe['totalNutrients']['CHOCDF']['unit']}',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      if (cleanedRecipe['totalNutrients']['PROCNT'] != null)
                                        Text(
                                          'Protein: ${cleanedRecipe['totalNutrients']['PROCNT']['quantity'].toStringAsFixed(2)} ${cleanedRecipe['totalNutrients']['PROCNT']['unit']}',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                    ],
                                  ),
                                const SizedBox(height: 16),
                                Text(
                                  'Source: ${cleanedRecipe['source'] ?? 'Unknown'}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // "Go to Full Recipe" Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (cleanedRecipe['url'] != null) {
                      _launchURL(cleanedRecipe['url']);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No recipe URL available!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Go to Full Recipe'),
                ),
              ),

              // Add Ingredients to Grocery List Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final groceryListProvider =
                        Provider.of<GroceryListProvider>(context, listen: false);

                    final ingredients = (cleanedRecipe['ingredientLines'] as List<dynamic>?)
                            ?.map((line) => Ingredient({"original": line, "name": line}))
                            .toList() ??
                        [];

                    groceryListProvider.clearList();

                    for (var ingredient in ingredients) {
                      groceryListProvider.addIngredient(ingredient);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All ingredients added to the grocery list!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add All Ingredients to Grocery List'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
