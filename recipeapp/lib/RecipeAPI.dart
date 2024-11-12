import 'dart:io' as io;
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'apikey.dart';

import 'types/recipe.dart';
import 'types/ingredient.dart';

const String _recipeCacheDir = "cache/recipes/";

class RecipeAPI{
    static Future<List<Recipe>> searchRecipesByIngredient(List<String> ingredients) async{
        // turn ingredients List into comma-separated string
        var flattenedIngredients = ingredients.join(",");
        // query the API
        http.Response resp = await http.get(Uri.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=$API_KEY&ingredients=$flattenedIngredients"));
        // return a List of Maps (json)
        List<Map<String,dynamic>> recipesJson = jsonDecode(resp.body);

        List<Recipe> out = [];
        recipesJson.forEach((recipe) => out.add(Recipe(recipe)));
        return out;
    }
    static Future<Recipe> getRecipe(int id) async{
        io.File myFile = io.File("$_recipeCacheDir$id.json");
        // check if the recipe exists in the cache already
        if(!myFile.existsSync()){
            // if not, download it
            await downloadRecipe(id);
        }
        // return cached recipe
        return Recipe(jsonDecode(myFile.readAsStringSync()));
    }
    static Future<void> downloadRecipe(int id) async{
         // query API for recipe data
        http.Response resp = await http.get(Uri.parse("https://api.spoonacular.com/recipes/$id/information?apiKey=$API_KEY"));
        print("api call");
        io.File myFile = io.File("$_recipeCacheDir$id.json");
        // check if the recipe alreday in cache
        if(!myFile.existsSync()){
            // if not, create new file and write data
            myFile.createSync();
        }
        myFile.writeAsStringSync(resp.body);
    }
}
