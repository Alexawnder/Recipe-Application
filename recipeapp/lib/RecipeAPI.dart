import 'dart:io' as io;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'apikey.dart';

import 'types/recipe.dart';
import 'types/ingredient.dart';


class RecipeAPI{
    static Future<String> get _recipeCacheDir async {
        final directory = await getApplicationCacheDirectory();
        return "${directory.path}/recipes/";
    }
    static Future<List<Recipe>> searchRecipesByName(String query) async{
        http.Response resp = await http.get(Uri.parse("https://api.spoonacular.com/recipes/complexSearch?apiKey=$API_KEY&query=$query"));
        print("api call!");
        
        if(resp.statusCode != 200){
            return [];
        }
        // create output variable
        List<Recipe> out = [];
        // return a List of Maps (json)
        List<dynamic> recipesJson = jsonDecode(resp.body)["results"];
        for(int i = 0; i < recipesJson.length; i++){
            var recipe = recipesJson[i];
            if(recipe is Map<String, dynamic>){
                out.add(Recipe(recipe));
            }
        }

        return out;
    }

    static Future<List<Recipe>> searchRecipesByIngredient(List<Ingredient> ingredients) async{
        // turn ingredients List into comma-separated string
        var flattenedIngredients = "";
        ingredients.forEach((i) => (flattenedIngredients += "${i.name},"));
        if(flattenedIngredients.lastIndexOf(",") == flattenedIngredients.length-1){
            flattenedIngredients = flattenedIngredients.substring(0, flattenedIngredients.length-1);
        }
        // query the API
        http.Response resp = await http.get(Uri.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=$API_KEY&ingredients=$flattenedIngredients"));
        print("api call!");

        // return nothing if bad resp code
        if(resp.statusCode != 200){
            return [];
        }
        // create output variable
        List<Recipe> out = [];
        // return a List of Maps (json)
        List<dynamic> recipesJson = jsonDecode(resp.body);
        for(int i = 0; i < recipesJson.length; i++){
            var recipe = recipesJson[i];
            if(recipe is Map<String, dynamic>){
                out.add(Recipe(recipe));
            }
        }

        return out;
    }
    static Future<List<Recipe>> searchRecipesByIngredientString(List<String> ingredients) async{
        // turn ingredients List into comma-separated string
        var flattenedIngredients = ingredients.join(",");
        // query the API
        http.Response resp = await http.get(Uri.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=$API_KEY&ingredients=$flattenedIngredients"));
        print("api call!");

        // create output variable
        List<Recipe> out = [];
        if(resp.statusCode != 200){
            return out;
        }
        // return a List of Maps (json)
        List<dynamic> recipesJson = jsonDecode(resp.body);
        for(int i = 0; i < recipesJson.length; i++){
            var recipe = recipesJson[i];
            if(recipe is Map<String, dynamic>){
                out.add(Recipe(recipe));
            }
        }

        return out;
    }
    static Future<Recipe?> getRecipe(int id) async{
        io.File myFile = io.File("${await _recipeCacheDir}$id.json");
        // check if the recipe exists in the cache already
        if(!myFile.existsSync()){
            // if not, download it
            bool succeeded = await downloadRecipe(id);
            if(!succeeded){
                return null;
            }
        }
        // return cached recipe
        return Recipe(jsonDecode(myFile.readAsStringSync()));
    }
    static Future<bool> downloadRecipe(int id) async{
         // query API for recipe data
        http.Response resp = await http.get(Uri.parse("https://api.spoonacular.com/recipes/$id/information?apiKey=$API_KEY"));
        print("api call!");

        if(resp.statusCode != 200){
            return false;
        }

        io.File myFile = io.File("${await _recipeCacheDir}$id.json");
        // check if the recipe alreday in cache
        if(!myFile.existsSync()){
            // if not, create new file and write data
            myFile.createSync();
        }
        myFile.writeAsStringSync(resp.body);
        return true;
    }
}
