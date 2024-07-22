import 'package:bt_recipe_management_task/core/constants/app_color.dart';
import 'package:bt_recipe_management_task/core/constants/string_constant.dart';
import 'package:bt_recipe_management_task/core/shared/widgets/app_bar.dart';
import 'package:bt_recipe_management_task/feature/data/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBackground,
      appBar: appBar(StringConst.recipeDetail),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.name,
              style: const TextStyle(fontSize: 32, color: AppColor.primary, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              'Category: ${recipe.category}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.ingredients,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
