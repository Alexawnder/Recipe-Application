import 'ingredient.dart';
class Recipe
{
    late String uri,
        title,
        image,
        source,
        url,
        shareAs;
    late double yield,
        calories,
        totalWeight;
    late List<dynamic> dietLabels,
        ingredientLines,
        cautions,
        mealType,
        dishType,
        digest;
    late List<Ingredient> ingredients;
    late Map<String, dynamic> totalNutrients, totalDaily;
    Recipe(Map<String,dynamic> jsonData){
        // strings
        title = jsonData["label"] ?? "";
        image = jsonData["image"] ?? "";
        source = jsonData["source"] ?? "";
        url = jsonData["url"] ?? "";
        shareAs = jsonData["shareAs"] ?? "";
        // doubles
        yield = jsonData["yield"] ?? 0.0;
        calories = jsonData["calories"] ?? 0.0;
        totalWeight = jsonData["totalWeight"] ??0.0;
        // lists
        dietLabels = jsonData["dietLabels"] ?? [];
        ingredientLines = jsonData["ingredientLines"] ?? [];
        cautions = jsonData["cautions"] ?? [];
        mealType = jsonData["mealType"] ?? [];
        dishType = jsonData["dishType"] ?? [];
        digest = jsonData["digest"] ?? [];
        // maps
        totalNutrients = jsonData["totalNutrients"] ?? {};
        totalDaily = jsonData["totalDaily"] ?? {};
        
        ingredients = [];
        jsonData["ingredients"].forEach((ingredient) => ingredients.add(Ingredient(ingredient)));
    }


    @override
    String toString(){
        return "Recipe $title";
    }

}
