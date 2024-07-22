import '../../data/repositories/recipe_repository.dart';

class DeleteRecipe {
  final RecipeRepository repository;

  DeleteRecipe(this.repository);

  void call(int id) {
    repository.deleteRecipe(id);
  }
}
