import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'GroceryList.dart';
import '../providers/GroceryListProvider.dart'; 
import 'package:provider/provider.dart';



class RecipeDetails extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // Explicitly cast the recipe map to Map<String, dynamic>
    final cleanedRecipe = recipe.cast<String, dynamic>();

    return Scaffold(
      appBar: AppBar(
        title: Text(cleanedRecipe['label'] ?? 'Recipe', style: const TextStyle(fontSize: 18)),
        backgroundColor: const Color(0xFF7EA16B),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Recipe Name
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
            // Recipe Image
            if (cleanedRecipe['image'] != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    cleanedRecipe['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // Tab Layout for Ingredients and Nutrition
            DefaultTabController(
              length: 2, // Two tabs: Ingredients and Nutrition
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
                    height: 300, // Fixed height for tab content
                    child: TabBarView(
                      children: [
                        // Ingredients Tab
                        Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: (cleanedRecipe['ingredientLines'] as List<dynamic>?)?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final ingredient =
                                      (cleanedRecipe['ingredientLines'] as List<dynamic>)[index] as String;
                                  return ListTile(
                                    leading: const Icon(Icons.circle, size: 8),
                                    title: Text(
                                      ingredient,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  final groceryListProvider = Provider.of<GroceryListProvider>(context, listen: false);

                                  // Clear the grocery list
                                  groceryListProvider.clearList();

                                  // Add new ingredients to the grocery list
                                  final ingredients = (cleanedRecipe['ingredientLines'] as List<dynamic>?)
                                          ?.map((line) => line as String)
                                          .toList() ??
                                      [];

                                  for (var ingredient in ingredients) {
                                    groceryListProvider.addIngredient(ingredient);
                                  }

                                  // Navigate to the Grocery List screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GroceryList(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Create Grocery List'),
                              ),
                            ),
                          ],
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (cleanedRecipe['totalNutrients']['CHOCDF'] != null)
                                      Text(
                                        'Carbs: ${cleanedRecipe['totalNutrients']['CHOCDF']['quantity'].toStringAsFixed(2)} ${cleanedRecipe['totalNutrients']['CHOCDF']['unit']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (cleanedRecipe['totalNutrients']['PROCNT'] != null)
                                      Text(
                                        'Protein: ${cleanedRecipe['totalNutrients']['PROCNT']['quantity'].toStringAsFixed(2)} ${cleanedRecipe['totalNutrients']['PROCNT']['unit']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                  ],
                                ),
                              const SizedBox(height: 16),
                              Text(
                                'Source: ${cleanedRecipe['source'] ?? 'Unknown'}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _launchURL(cleanedRecipe['url'] ?? '');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor, // Button background color
                                    foregroundColor: Colors.white, // Text color
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                    textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                  child: const Text('View Full Recipe'),
                                ),
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
          ],
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
