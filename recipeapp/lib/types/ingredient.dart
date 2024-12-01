class Ingredient
{
    late int id;
    late String aisle,
        image,
        consistency,
        name,
        nameClean,
        original,
        originalName;
    late List<dynamic> meta;
    late Map<String,dynamic> measures;
    Ingredient(Map<String,dynamic> jsonData){
        id = jsonData["id"];
        aisle = jsonData["aisle"];
        image = jsonData["image"];
        consistency = jsonData["consistency"];
        name = jsonData["name"];
        nameClean = jsonData["nameClean"];
        original = jsonData["original"];
        originalName = jsonData["originalName"];
        meta = jsonData["meta"];
        measures = jsonData["measures"];
    }

    @override
    String toString(){
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
