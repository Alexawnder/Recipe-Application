import 'RecipeAPI.dart';
import 'types/recipe.dart';
void main() async{
    List<Recipe> recipes = await RecipeAPI.searchRecipesByName("carbonara"); 
}
