import 'RecipeAPI.dart';


void main() async{
    var result = await RecipeAPI.getRecipe(223);
    print(result);
}

