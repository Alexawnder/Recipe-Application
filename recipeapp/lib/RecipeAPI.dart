import 'dart:io' as io;
import 'dart:convert';

final String _RECIPE_CACHE_DIR = "cache/recipes/";

class RecipeAPI{
    static Map searchRecipes(String query){
        return new Map();
    }
    static Map<String,dynamic> getRecipe(int id){
        io.File myFile = new io.File(_RECIPE_CACHE_DIR + id.toString() + ".json");
        if(myFile.existsSync()){
            return jsonDecode(myFile.readAsStringSync());
        }
        return new Map<String,dynamic>(); 
    }
}
