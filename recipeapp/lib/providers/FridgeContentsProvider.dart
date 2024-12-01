import 'package:flutter/foundation.dart';
import '../types/ingredient.dart';
class FridgeContentsProvider with ChangeNotifier {
    Map<Ingredient, int> _fridgeContents = Map<Ingredient, int>();
    Map<Ingredient, int> get fridgeContents => _fridgeContents;

    void addIngredient(Ingredient i){
        if(_fridgeContents.containsKey(i)){
            _fridgeContents.update(i, (value) => value + 1);
        } else {
            _fridgeContents[i] = 1;
        }
        notifyListeners();
    }
    void removeIngredient(Ingredient i){
        if(_fridgeContents.containsKey(i)){
            _fridgeContents.update(i, (value) => value - 1);
            notifyListeners();
        }
    }
    void removeAllIngredient(Ingredient i){
        if(_fridgeContents.containsKey(i)){
            _fridgeContents.remove(i);
            notifyListeners();
        }
    }
    void setIngredientQty(Ingredient i, int qty){
        if(_fridgeContents.containsKey(i)){
            _fridgeContents.update(i, (value) => qty);
            notifyListeners();
        }
    }
}
