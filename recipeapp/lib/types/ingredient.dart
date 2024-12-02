class Ingredient {
  late int id;
  late String name;
  late String original;
  late String aisle;
  late String image;
  late Map<String, dynamic> measures;

  Ingredient(Map<String, dynamic> jsonData) {
    id = jsonData["id"] ?? jsonData["original"].hashCode; // Default to hash if ID is missing
    name = jsonData["name"] ?? jsonData["original"];
    original = jsonData["original"] ?? "";
    aisle = jsonData["aisle"] ?? "Unknown";
    image = jsonData["image"] != null
        ? "https://img.spoonacular.com/ingredients_250x250/${jsonData["image"]}"
        : ""; // Handle missing image
    measures = jsonData["measures"] ?? {};
  }

  @override
  String toString() {
    return "Ingredient name = $name, id = $id";
  }

  @override
  bool operator ==(Object other) =>
      other is Ingredient &&
      other.runtimeType == this.runtimeType &&
      other.id == this.id;

  @override
  int get hashCode => id.hashCode;
}
