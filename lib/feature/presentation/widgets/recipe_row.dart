import 'package:bt_recipe_management_task/core/constants/app_color.dart';
import 'package:bt_recipe_management_task/core/constants/string_constant.dart';
import 'package:bt_recipe_management_task/feature/data/models/recipe.dart';
import 'package:bt_recipe_management_task/feature/presentation/bloc/recipe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeRow extends StatelessWidget {
  final Recipe recipe;
  final int index;
  final Function? onTap;

  const RecipeRow({Key? key, required this.recipe, required this.index, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // add null safety
        if (onTap != null) {
          onTap!();
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          key: Key('recipeItem$index'),
          title: Text("Name: ${recipe.name}"),
          subtitle: Text('Category: ${recipe.category}\nIngredients: ${recipe.ingredients}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _editButton(context),
              const SizedBox(width: 8),
              _deleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /* returns edit button */
  Widget _editButton(BuildContext context) {
    return IconButton(
      key: Key('editButton$index'),
      onPressed: () {
        context.read<RecipeBloc>().add(EditRecipeEventAction(recipe));
      },
      icon: const Icon(Icons.edit, color: AppColor.primary),
      tooltip: StringConst.editButtonTooltip,
    );
  }

  /* returns delete button */
  Widget _deleteButton(BuildContext context) {
    return IconButton(
      key: Key('deleteButton$index'),
      onPressed: () {
        context.read<RecipeBloc>().add(DeleteRecipeEvent(recipe.id));
      },
      icon: const Icon(Icons.delete, color: AppColor.red,),
      tooltip: StringConst.deleteButtonTooltip,
    );
  }
}
