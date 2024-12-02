class Ingredient
{
    late String? text,
        measure,
        name,
        foodCategory,
        id,
        image;
    late double? quantity, weight;
    Ingredient(Map<String,dynamic> jsonData){
        text = jsonData["text"];
        measure = jsonData["measure"];
        name = jsonData["food"];
        foodCategory = jsonData["foodCategory"];
        id = jsonData["foodId"];
        image = jsonData["image"];
        quantity = jsonData["quantity"];
        weight = jsonData["weight"];
    }

    @override
    String toString(){
        return "Ingredient name = $text, id = $id";
    }
    @override
    bool operator ==(Object other) =>
        other is Ingredient &&
        other.runtimeType == this.runtimeType &&
        other.id == this.id;

    @override
    int get hashCode => id.hashCode;
}
