import 'dart:convert';

import 'package:random_recipe/models/meal_model.dart';
import 'package:http/http.dart' as http;

class MealRepository {
  Future<MealModel> getMeal() async {
    String url = "https://www.themealdb.com/api/json/v1/1/random.php";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    print(response.body);
    return MealModel.fromJson(jsonDecode(response.body));
  }
}
