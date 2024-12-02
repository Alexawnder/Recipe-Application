import 'package:flutter/material.dart';

class GroceryListProvider with ChangeNotifier {
  final List<String> _groceryList = [];

  List<String> get groceryList => List.unmodifiable(_groceryList);

  void addIngredient(String ingredient) {
    if (!_groceryList.contains(ingredient)) {
      _groceryList.add(ingredient);
      notifyListeners();
    }
  }

  void removeIngredient(String ingredient) {
    _groceryList.remove(ingredient);
    notifyListeners();
  }

  void clearList() {
    _groceryList.clear();
    notifyListeners();
  }
}
