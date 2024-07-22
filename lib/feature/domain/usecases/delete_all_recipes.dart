import '../../data/repositories/recipe_repository.dart';
import '../../data/models/recipe.dart';

class DeleteAllRecipes {
  final RecipeRepository repository;

  DeleteAllRecipes(this.repository);

  void call() {
    repository.deleteAllRecipes();
  }
}
