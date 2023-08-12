import 'dart:convert';

MealModel clientFromJson(String str) => MealModel.fromJson(json.decode(str));
String clientToJson(MealModel data) => json.encode(data.toJson());

class MealModel {
  String id;
  String name;
  String category;

  String area;
  String instructions;
  String image;

  String youtubeUrl;
  List<Ingredients> ingredients;

  MealModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.image,
    required this.youtubeUrl,
    required this.ingredients,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        id: json["meals"][0]["idMeal"],
        name: json["meals"][0]["strMeal"],
        area: json["meals"][0]["strArea"],
        category: json["meals"][0]["strCategory"],
        instructions: json["meals"][0]["strInstructions"],
        image: json["meals"][0]["strMealThumb"],
        youtubeUrl: json["meals"][0]["strYoutube"],
        ingredients: List.generate(
            20,
            (index) => Ingredients(
                  json["meals"][0]["strMeasure${index + 1}"],
                  json["meals"][0]["strIngredient${index + 1}"],
                )),
      );

  Map<String, dynamic> toJson() => {
        "idMeal": id,
        "strMeal": name,
        "strCategory": category,
        "strArea": area,
        "strInstructions": instructions,
        "strMealThumb": image,
        "strYoutube": youtubeUrl,
        "is_active": ingredients,
      };
}

class Ingredients {
  final String name;
  final String measure;
  Ingredients(this.measure, this.name);
}
