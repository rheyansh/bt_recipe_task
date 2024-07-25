import '../../data/repositories/recipe_repository.dart';
import '../../data/models/recipe.dart';

class FilterRecipes {
  final RecipeRepository repository;

  FilterRecipes(this.repository);

  List<Recipe> call(String category) {
    return repository.filterRecipes(category) ?? [];
  }
}
