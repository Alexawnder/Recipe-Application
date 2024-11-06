import 'dart:io' as io;
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'apikey.dart';

final String _RECIPE_CACHE_DIR = "cache/recipes/";

class RecipeAPI{
    static Map searchRecipes(String query){
        return new Map();
    }
    static Map<String,dynamic> getRecipe(int id){
        io.File myFile = new io.File(_RECIPE_CACHE_DIR + id.toString() + ".json");
        if(!myFile.existsSync()){
            downloadRecipe(id);
        }
        return jsonDecode(myFile.readAsStringSync());

    }
    static void downloadRecipe(int id) async{
        await http.get("https://api.spoonacular.com/recipes/{id}/information?apiKey=" + apikey.API_KEY);
    }
}
