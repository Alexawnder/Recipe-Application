import 'RecipeAPI.dart';


void main(){
    var result = RecipeAPI.getRecipe(123);
    print(result.runtimeType);
}

