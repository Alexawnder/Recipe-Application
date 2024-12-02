import 'package:flutter/material.dart';
import '../types/ingredient.dart';

class GroceryListProvider with ChangeNotifier {
  final Map<Ingredient, int> _groceryList = {};

  Map<Ingredient, int> get groceryList => Map.unmodifiable(_groceryList);

  void addIngredient(Ingredient i) {
    if (_groceryList.containsKey(i)) {
      _groceryList.update(i, (quantity) => quantity + 1);
    } else {
      _groceryList[i] = 1;
    }
    notifyListeners();
  }

  void removeIngredient(Ingredient i) {
    if (_groceryList.containsKey(i)) {
      if (_groceryList[i]! > 1) {
        _groceryList.update(i, (quantity) => quantity - 1);
      } else {
        _groceryList.remove(i);
      }
      notifyListeners();
    }
  }

  void removeAllOfIngredient(Ingredient i) {
    if (_groceryList.containsKey(i)) {
      _groceryList.remove(i);
      notifyListeners();
    }
  }
  void clearList() {
    _groceryList.clear();
    notifyListeners();
  }
}
