import 'package:flutter/material.dart';

class RecipeDetails extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetails({super.key, required this.recipe});

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
            const SizedBox(height: 16),
            Text(
              'Source: ${recipe['source']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              onPressed: () {
                // Implement the URL launch functionality later
              },
              child: const Text('View Full Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}

