import 'dart:io' as io;
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'apikey.dart';

const String _recipeCacheDir = "cache/recipes/";

class RecipeAPI{
    static Map? searchRecipes(String query){
        return null;
    }
    static Future<Map<String,dynamic>> getRecipe(int id) async{
        io.File myFile = io.File("$_recipeCacheDir$id.json");
        if(!myFile.existsSync()){
            await downloadRecipe(id);
        }
        return jsonDecode(myFile.readAsStringSync());
    }
    static Future<void> downloadRecipe(int id) async{
       http.Response resp = await http.get(Uri.parse("https://api.spoonacular.com/recipes/$id/information?apiKey=$API_KEY"));
       print("api call");
       io.File myFile = io.File("$_recipeCacheDir$id.json");
       if(!myFile.existsSync()){
           myFile.createSync();
           myFile.writeAsStringSync(resp.body);
       } else{
            myFile.writeAsStringSync(resp.body);
       }
    }
}
