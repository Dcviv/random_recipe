import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_recipe/models/meal_model.dart';

import '../repository/meal_repository.dart';

final mealProvider = FutureProvider((ref) {
  print("Calling Provider");
  return MealRepository().getMeal();
});
// final mealProvider = Provider(
//   (ref) => MealRepository(
    
//   ),
// );
