import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_recipe/models/meal_model.dart';
import 'package:random_recipe/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/meal_provider.dart';

class RecipePage extends ConsumerWidget {
  RecipePage({Key? key}) : super(key: key);
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MealModel> meal =
        ref.watch(mealProvider); //as ProviderListenable<MealModel>);
    print(meal.toString());
    return Scaffold(
        body: meal.when(
            // checks the conditions for provider
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            error: (err, stack) => Center(
                  child: const Text(""), //you can print error here
                ),
            data: (recipeData) {
              recipeData.ingredients.removeWhere(
                  (element) => element.name == null || element.name == '');
              return Container(
                  child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(recipeData.image),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipeData.name,
                            style: textStyle(35, Colors.black, FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Row(children: [
                                Chip(
                                  backgroundColor: Colors.yellowAccent,
                                  label: Center(
                                    child: Text(
                                      recipeData.category,
                                      style: textStyle(
                                          18, Colors.black, FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Chip(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  label: Center(
                                    child: Text(
                                      recipeData.area,
                                      style: textStyle(
                                          18, Colors.black, FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ]),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onPressed: () async {
                                  if (recipeData.youtubeUrl != null &&
                                      recipeData.youtubeUrl != "") {
                                    if (await canLaunchUrl(
                                        Uri.parse(recipeData.youtubeUrl))) {
                                      final bool nativeAppSuceed =
                                          await launchUrl(
                                        Uri.parse(recipeData.youtubeUrl),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  "Youtube",
                                  style: textStyle(
                                      18, Colors.white, FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Ingredients",
                            style: textStyle(25, Colors.black, FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Scrollbar(
                                  controller: _controller,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      controller: _controller,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recipeData.ingredients.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Column(children: [
                                              Image(
                                                image: NetworkImage(
                                                  "https://www.themealdb.com/images/ingredients/${recipeData.ingredients[index].name}.png",
                                                ),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                recipeData
                                                    .ingredients[index].name,
                                                style: textStyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                recipeData
                                                    .ingredients[index].measure,
                                                style: textStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              )
                                            ]));
                                      }))),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Instructions",
                            style: textStyle(25, Colors.black, FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            recipeData.instructions,
                            style: textStyle(18, Colors.black, FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ));
            }));
  }
}
