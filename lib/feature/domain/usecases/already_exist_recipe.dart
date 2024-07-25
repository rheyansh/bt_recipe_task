import '../../data/repositories/recipe_repository.dart';
import '../../data/models/recipe.dart';

class AlreadyExistRecipe {
  final RecipeRepository repository;

  AlreadyExistRecipe(this.repository);

  bool call(Recipe recipe) {
    return repository.isRecipeAlreadyExists(recipe) ?? false;
  }
}