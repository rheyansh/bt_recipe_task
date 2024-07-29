import 'package:bt_recipe_management_task/core/constants/string_constant.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/already_exist_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/data/models/recipe.dart';
import 'feature/data/repositories/recipe_repository_impl.dart';
import 'feature/presentation/bloc/recipe_bloc.dart';
import 'feature/presentation/pages/recipe_list_page.dart';
import 'feature/data/repositories/recipe_repository.dart';
import 'feature/domain/usecases/add_recipe.dart';
import 'feature/domain/usecases/delete_all_recipes.dart';
import 'feature/domain/usecases/delete_recipe.dart';
import 'feature/domain/usecases/edit_recipe.dart';
import 'feature/domain/usecases/filter_recipes.dart';
import 'feature/domain/usecases/search_recipes.dart';
import 'core/service_locator.dart' as di;

void main() {
  di.setup();

  final recipeRepository = RecipeRepositoryImpl(recipes: [
    const Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'Salt, Onion'),
    const Recipe(id: 2, name: 'Salad', category: 'Side', ingredients: 'Lettuce, Tomato')
  ]);

  runApp(MyApp(
    recipeRepository: recipeRepository,
  ));
}

class MyApp extends StatelessWidget {
  final RecipeRepository recipeRepository;

  const MyApp({required this.recipeRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => di.getIt<RecipeBloc>(),
        child: const RecipeListPage(),
      ),
    );
  }
}
