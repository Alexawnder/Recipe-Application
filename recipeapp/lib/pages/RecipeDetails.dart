import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class RecipeDetails extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['label'], style: const TextStyle(fontSize: 18)),
        backgroundColor: const Color(0xFF7EA16B),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Recipe Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                recipe['label'],
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Recipe Image
            if (recipe['image'] != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    recipe['image'],
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemCount: (recipe['ingredientLines'] as List).length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.circle, size: 8),
                                title: Text(
                                  recipe['ingredientLines'][index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ),
                        ),
                        // Nutrition Tab
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Calories: ${recipe['calories'].toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 8),
                              if (recipe.containsKey('totalNutrients'))
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (recipe['totalNutrients']['FAT'] != null)
                                      Text(
                                        'Fat: ${recipe['totalNutrients']['FAT']['quantity'].toStringAsFixed(2)} ${recipe['totalNutrients']['FAT']['unit']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (recipe['totalNutrients']['CHOCDF'] != null)
                                      Text(
                                        'Carbs: ${recipe['totalNutrients']['CHOCDF']['quantity'].toStringAsFixed(2)} ${recipe['totalNutrients']['CHOCDF']['unit']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (recipe['totalNutrients']['PROCNT'] !=
                                        null)
                                      Text(
                                        'Protein: ${recipe['totalNutrients']['PROCNT']['quantity'].toStringAsFixed(2)} ${recipe['totalNutrients']['PROCNT']['unit']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                  ],
                                ),
                              const SizedBox(height: 16),
                              Text(
                                'Source: ${recipe['source']}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _launchURL(recipe['url']);
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
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}