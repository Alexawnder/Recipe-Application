import 'ingredient.dart';
class Recipe
{
    late String? uri,
        title,
        image,
        source,
        url,
        shareAs;
    late double? yield, calories, totalWeight;
    late List<dynamic>? dietLabels, ingredientLines, cautions, mealType, dishType, digest;
    late List<Ingredient>? ingredients;
    late Map<String, dynamic>? totalNutrients, totalDaily;
    Recipe(Map<String,dynamic> jsonData){
        title = jsonData["label"];
        image = jsonData["image"];
        source = jsonData["source"];
        url = jsonData["url"];
        shareAs = jsonData["shareAs"];
        yield = jsonData["yield"];
        dietLabels = jsonData["dietLabels"];
        cautions = jsonData["cautions"];
        ingredientLines = jsonData["ingredientLines"];
        calories = jsonData["calories"];
        totalWeight = jsonData["totalWeight"];
        mealType = jsonData["mealType"];
        dishType = jsonData["dishType"];
        totalNutrients = jsonData["totalNutrients"];
        totalDaily = jsonData["totalDaily"];
        digest = jsonData["digest"];
        
        ingredients = [];
        jsonData["ingredients"].forEach((ingredient) => ingredients?.add(Ingredient(ingredient)));
    }


    @override
    String toString(){
        return "Recipe $title";
    }

}
