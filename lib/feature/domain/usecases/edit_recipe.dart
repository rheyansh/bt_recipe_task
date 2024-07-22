import '../../data/repositories/recipe_repository.dart';
import '../../data/models/recipe.dart';

class EditRecipe {
  final RecipeRepository repository;

  EditRecipe(this.repository);

  void call(Recipe recipe) {
    repository.editRecipe(recipe);
  }
}
