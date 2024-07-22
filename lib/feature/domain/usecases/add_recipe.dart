import '../../data/repositories/recipe_repository.dart';
import '../../data/models/recipe.dart';

class AddRecipe {
  final RecipeRepository repository;

  AddRecipe(this.repository);

  void call(Recipe recipe) {
    repository.addRecipe(recipe);
  }
}
