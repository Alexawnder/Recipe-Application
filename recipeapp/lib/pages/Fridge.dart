import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../types/ingredient.dart';
import 'package:provider/provider.dart';
import '../providers/FridgeContentsProvider.dart';

class Fridge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
        'My Fridge',
        style: GoogleFonts.playfairDisplay(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF000000), // Ensure the font color matches the theme
        ),
      ),
        backgroundColor: const Color(0xFF7EA16B),
      ),
      body: Container(
        color: const Color(0xFFF9DEC9),
        child: Consumer<FridgeContentsProvider>(
          builder: (context, fridgeContentsProvider, child) {
            Map<Ingredient, int> contents = fridgeContentsProvider.fridgeContents;

            if (contents.isEmpty) {
              return const Center(
                child: Text(
                  'Your fridge is empty!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: contents.keys.length,
              itemBuilder: (context, index) {
                Ingredient fridgeItem = contents.keys.elementAt(index);
                int quantity = contents[fridgeItem] ?? 0;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  color: const Color(0xFFC4A69D),
                  child: ListTile(
                    leading: fridgeItem.image.isNotEmpty
                        ? Image.network(
                            fridgeItem.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported, size: 50),
                    title: Text(
                      "${quantity}x ${fridgeItem.name}",
                      style: GoogleFonts.dancingScript(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7EA16B),
                      ),
                    ),
                    subtitle: Text(
                      fridgeItem.original,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.green),
                          onPressed: () {
                            fridgeContentsProvider.addIngredient(fridgeItem);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.red),
                          onPressed: () {
                            fridgeContentsProvider.removeIngredient(fridgeItem);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
