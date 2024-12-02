import 'dart:io' as io;
import 'dart:convert';
//import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'apikey.dart';

import 'types/recipe.dart';
import 'types/ingredient.dart';


class RecipeAPI{



    static Future<List<Recipe>> searchRecipesByName(String query) async{
        final searchRecipeURL = Uri.parse("https://api.edamam.com/search?q=$query&app_id=$APP_ID&app_key=$APP_KEY");
        http.Response resp = await http.get(searchRecipeURL);
        if(resp.statusCode != 200){
            return [];
        }
        List<Recipe> out = [];
        List<dynamic> recipesJson = jsonDecode(resp.body)["hits"];


        for(int i = 0; i < recipesJson.length; i++){
            Map<String,dynamic> entry = recipesJson[i]["recipe"];
            out.add(Recipe(entry));
        }
        return out;
    }
}
