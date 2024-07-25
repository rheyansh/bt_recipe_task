import '../../data/repositories/recipe_repository.dart';
import '../../data/models/recipe.dart';

class SearchRecipes {
  final RecipeRepository repository;

  SearchRecipes(this.repository);

  List<Recipe> call(String query) {
    return repository.searchRecipes(query) ?? [];
  }
}
