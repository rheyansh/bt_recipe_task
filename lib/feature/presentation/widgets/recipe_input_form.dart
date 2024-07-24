import 'dart:math';
import 'package:bt_recipe_management_task/core/constants/app_color.dart';
import 'package:bt_recipe_management_task/feature/presentation/bloc/recipe_bloc.dart';
import 'package:bt_recipe_management_task/feature/presentation/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/recipe.dart';
import 'package:bt_recipe_management_task/core/constants/string_constant.dart';

class RecipeInputForm extends StatelessWidget {
  RecipeInputForm({super.key});

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final ingredientsController = TextEditingController();

  /* clear all input fields */
  void _clearTextControllers() {
    nameController.clear();
    categoryController.clear();
    ingredientsController.clear();
  }

  /* set values to input fields */
  void _setTextControllers({
    required String name,
    required String category,
    required String ingredients
  }) {
    nameController.text = name;
    categoryController.text = category;
    ingredientsController.text = ingredients;
  }

  /* generate a unique number for recipe id */
  int _generateTimestampBasedUniqueNumber() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final random = Random(now); // Seed the random number generator with timestamp
    return now + random.nextInt(10000); // Add randomness for further uniqueness
  }

  /* add recipe function */
  void _addRecipe(BuildContext context) {
    final recipe = Recipe(
      id: _generateTimestampBasedUniqueNumber(),
      name: nameController.text,
      category: categoryController.text,
      ingredients: ingredientsController.text,
    );
    context.read<RecipeBloc>().add(AddRecipeEvent(recipe));
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<RecipeBloc, RecipeState>(
      listener: (context, state) {
        if (state is RecipeEditAction) {
          Recipe recipe = state.recipe;
          _setTextControllers(name: recipe.name, category: recipe.category, ingredients: recipe.ingredients);
        } else if (state is RecipeAdded) {
          _clearTextControllers();
        } else if (state is ErrorRecipe && state.message.isNotEmpty) {
          AppAlertDialog.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _nameTextField(),
                const SizedBox(width: 8),
                _categoryTextField(),
                const SizedBox(width: 8),
                _ingredientTextField(),
                const SizedBox(width: 8),
                _addIconButton(context),
                _deleteAllIconButton(context),
              ],
            ),
            const SizedBox(width: 8),
          ],
        );
      },
    );
  }

  /* Returns name TextField */
  Widget _nameTextField() {
    return Expanded(
      child: TextField(
        key: const Key('nameField'),
        decoration: const InputDecoration(
          labelText: StringConst.nameLabel,
        ),
        controller: nameController,
      ),
    );
  }

  /* Returns category TextField */
  Widget _categoryTextField() {
    return Expanded(
      child: TextField(
        key: const Key('categoryField'),
        decoration: const InputDecoration(
          labelText: StringConst.categoryLabel,
        ),
        controller: categoryController,
      ),
    );
  }

  /* Returns ingredient TextField */
  Widget _ingredientTextField() {
    return Expanded(
      child: TextField(
        key: const Key('ingredientsField'),
        decoration: const InputDecoration(
          labelText: StringConst.ingredientsLabel,
        ),
        controller: ingredientsController,
      ),
    );
  }

  /* Returns add icon button */
  Widget _addIconButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        _addRecipe(context);
      },
      icon: const Icon(Icons.add, color: AppColor.primary),
      tooltip: StringConst.addButtonTooltip,
    );
  }

  /* Returns delete all icon button */
  Widget _deleteAllIconButton(BuildContext context) {
    return IconButton(
      key: const Key('deleteAll'),
      onPressed: () {
        context.read<RecipeBloc>().add(DeleteAllRecipesEvent());
      },
      icon: const Icon(Icons.delete_forever, color: AppColor.red),
      tooltip: StringConst.deleteAllButtonTooltip,
    );
  }
}