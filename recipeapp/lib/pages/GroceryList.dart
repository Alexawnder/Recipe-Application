import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/GroceryListProvider.dart';
import '../types/ingredient.dart';
import 'package:google_fonts/google_fonts.dart';


class GroceryList extends StatefulWidget {
  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final Set<Ingredient> _checkedItems = {};

  @override
  Widget build(BuildContext context) {
    final groceryListProvider = Provider.of<GroceryListProvider>(context);
    return Scaffold(
      appBar: AppBar(
      title: Text(
        'Grocery List',
        style: GoogleFonts.playfairDisplay(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF000000), // Ensure the font color matches the theme
        ),
      ),
        backgroundColor: const Color(0xFF7EA16B),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              // Clear the list before setting new list
              groceryListProvider.clearList();
              setState(() {
                _checkedItems.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Grocery list cleared!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF9DEC9),
        child: groceryListProvider.groceryList.isEmpty
            ? const Center(
                child: Text(
                  'Your grocery list is empty!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: groceryListProvider.groceryList.keys.length,
                itemBuilder: (context, index) {
                  final ingredient =
                      groceryListProvider.groceryList.keys.elementAt(index);
                  final quantity = groceryListProvider.groceryList[ingredient]!;

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    color: const Color(0xFFC4A69D),
                    child: CheckboxListTile(
                      title: Text(
                        "${quantity}x ${ingredient.name}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                      subtitle: Text(
                        ingredient.original,
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      value: _checkedItems.contains(ingredient),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked == true) {
                            _checkedItems.add(ingredient);
                          } else {
                            _checkedItems.remove(ingredient);
                          }
                        });
                      },
                      activeColor: const Color(0xFF7EA16B), // Checkbox active color
                      checkColor: Colors.white, // Checkmark color
                      secondary: ingredient.image.isNotEmpty
                          ? Image.network(
                              ingredient.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image_not_supported, size: 50),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
