import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/GroceryListProvider.dart';

class GroceryList extends StatefulWidget {
  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final Set<String> _checkedItems = {};

  @override
  Widget build(BuildContext context) {
    final groceryListProvider = Provider.of<GroceryListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        backgroundColor: const Color(0xFF7EA16B),
      ),
      body: Container(
        color: const Color(0xFFF9DEC9),
        child: ListView.builder(
          itemCount: groceryListProvider.groceryList.length,
          itemBuilder: (context, index) {
            final ingredient = groceryListProvider.groceryList[index];

            return Card(
              margin: const EdgeInsets.all(8.0),
              color: const Color(0xFFC4A69D),
              child: CheckboxListTile(
                title: Text(
                  ingredient,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
