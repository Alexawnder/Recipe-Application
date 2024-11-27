import 'ingredient.dart';
class Recipe
{
    late bool? vegetarian,
        vegan,
        glutenFree,
        dairyFree,
        veryHealthy,
        cheap,
        veryPopular,
        sustainable,
        lowFodmap;
    late int? weightWatcherSmartPoints,
        aggregateLikes,
        healthScore,
        id,
        readyInMinutes,
        servings,
        preparationMinutes,
        cookingMinutes,
        originalId;
    late String? gaps,
        creditsText,
        sourceName,
        title,
        sourceUrl,
        image,
        imageType,
        summary,
        instructions;
    late List<Ingredient> ingredients = [];
    late List<dynamic> cuisines,
        dishTypes,
        diets,
        occasions,
        analyzedInstructions;
    Recipe(Map<String,dynamic> jsonData){
        // booleans
        vegetarian = jsonData["vegetarian"];
        vegan = jsonData["vegan"];
        glutenFree = jsonData["glutenFree"];
        dairyFree = jsonData["dairyFree"];
        veryHealthy = jsonData["veryHealthy"];
        cheap = jsonData["cheap"];
        sustainable = jsonData["sustainable"];
        lowFodmap = jsonData["lowFodmap"];
        // ints
        weightWatcherSmartPoints = jsonData["weightWatcherSmartPoints"];
        aggregateLikes = jsonData["aggregateLikes"];
        healthScore = jsonData["healthScore"];
        id = jsonData["id"];
        readyInMinutes = jsonData["readyInMinutes"];
        servings = jsonData["servings"];
        preparationMinutes = jsonData["preparationMinutes"];
        cookingMinutes = jsonData["cookingMinutes"];
        originalId = jsonData["originalId"];
        // strings
        gaps = jsonData["gaps"];
        creditsText = jsonData["creditsText"];
        sourceName = jsonData["sourceName"];
        title = jsonData["title"];
        sourceUrl = jsonData["sourceUrl"];
        image = jsonData["image"];
        imageType = jsonData["imageType"];
        summary = jsonData["summary"];
        instructions = jsonData["instructions"];
        // ingredients
        jsonData["extendedIngredients"]?.forEach((ingredient) => ingredients.add(Ingredient(ingredient)));
        // lists
        // note: syntax roughly equals
        // variable = jsonData["variable"] != null ? jsonData["variable"] : [];
        cuisines = jsonData["cuisines"]?? [];
        dishTypes = jsonData["dishTypes"]?? [];
        diets = jsonData["diets"]?? [];
        occasions = jsonData["occasions"]?? [];
        analyzedInstructions = jsonData["analyzedInstructions"]?? []; 
    }

    @override
    String toString(){
        return "Recipe title = $title, id = $id. Ingredients = $ingredients";
    }

}
