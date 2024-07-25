import '../models/recipe.dart';

/* abstract class to define all the required operations to do */

abstract class RecipeRepository {

  void addRecipe(Recipe recipe);

  void deleteRecipe(int id);

  void deleteAllRecipes();

  void editRecipe(Recipe recipe);

  bool? isRecipeAlreadyExists(Recipe recipe);

  List<Recipe>? filterRecipes(String category);

  List<Recipe>? searchRecipes(String query);
}
