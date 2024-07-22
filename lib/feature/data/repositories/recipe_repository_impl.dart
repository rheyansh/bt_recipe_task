import 'package:bt_recipe_management_task/feature/data/repositories/recipe_repository.dart';
import '../models/recipe.dart';

/* RecipeRepository */

class RecipeRepositoryImpl implements RecipeRepository {
  List<Recipe> _recipes = [];

  @override
  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  @override
  bool isRecipeAlreadyExists(Recipe recipe) {
    // check if already exist
    final list = _recipes.where((rec) {
      return (rec.name.toLowerCase() == recipe.name.toLowerCase()
          && rec.category.toLowerCase() == recipe.category.toLowerCase()
          && rec.ingredients.toLowerCase() == recipe.ingredients.toLowerCase()
      );
    }).toList();

    return list.isNotEmpty;
  }

  @override
  Future<void> deleteRecipe(int id) async {
    _recipes.removeWhere((recipe) => recipe.id == id);
  }

  @override
  Future<void> deleteAllRecipes() async {
    _recipes.clear();
  }

  @override
  Future<void> editRecipe(Recipe recipe) async {
    int index = _recipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) {
      _recipes[index] = recipe;
    }
  }
  @override
  List<Recipe> filterRecipes(String category) {
    return _recipes.where((recipe) => recipe.category.toLowerCase().contains(category.toLowerCase())).toList();
  }

  @override
  List<Recipe> searchRecipes(String query) {
    return _recipes.where((recipe) => recipe.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    return _recipes;
  }
}
