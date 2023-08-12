import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_recipe/provider/meal_provider.dart';
import 'package:random_recipe/screens/recipe_page.dart';
import 'package:random_recipe/utils/utils.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/food_image.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Feeling Hungry",
                  style: textStyle(30.0, Colors.black, FontWeight.w700),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent),
                    onPressed: () {
                      ref.refresh(mealProvider);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RecipePage()),
                      );
                    },
                    child: Text(
                      "Show a Recipe",
                      style: textStyle(22, Colors.black, FontWeight.w600),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
