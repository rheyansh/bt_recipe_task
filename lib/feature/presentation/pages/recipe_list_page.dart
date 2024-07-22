import 'package:bt_recipe_management_task/core/constants/app_color.dart';
import 'package:bt_recipe_management_task/core/shared/widgets/app_bar.dart';
import 'package:bt_recipe_management_task/feature/presentation/bloc/recipe_bloc.dart';
import 'package:bt_recipe_management_task/feature/presentation/pages/recipe_detail_page.dart';
import 'package:bt_recipe_management_task/feature/presentation/widgets/recipe_input_form.dart';
import 'package:bt_recipe_management_task/feature/presentation/widgets/recipe_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/recipe.dart';
import 'package:bt_recipe_management_task/core/constants/string_constant.dart';

class RecipeListPage extends StatelessWidget {

  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBackground,
      appBar: appBar(StringConst.appTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecipeInputForm(),
            const SizedBox(height: 16),
            RecipeFilter(),
            const SizedBox(height: 16),
            RecipeSearch(),
            const SizedBox(height: 16),
            Expanded(
              child: RecipeList(),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('filterField'),
      decoration: const InputDecoration(
        labelText: StringConst.filterByCategoryLabel,
      ),
      onChanged: (value) {
        context.read<RecipeBloc>().add(FilterRecipesEvent(value));
      },
    );
  }
}

class RecipeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('searchField'),
      decoration: const InputDecoration(
        labelText: StringConst.searchByNameOrIngredientsLabel,
      ),
      onChanged: (value) {
        context.read<RecipeBloc>().add(SearchRecipesEvent(value));
      },
    );
  }
}

class RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        if (state is RecipesFiltered || state is RecipesSearched) {
          final recipes = state is RecipesFiltered
              ? state.filteredRecipes
              : (state as RecipesSearched).searchedRecipes;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return RecipeRow(recipe: recipe, index: index, onTap: () {
                _moveToRecipeDetail(context, recipe);
              });
            },
          );
        } else {
          return const Center(child: Text(StringConst.noRecipeAvailable));
        }
      },
    );
  }

  /* function to move to recipe detail screen */
  _moveToRecipeDetail(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailPage(recipe: recipe),
      ),
    );
  }
}
