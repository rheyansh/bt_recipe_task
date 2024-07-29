import 'package:bt_recipe_management_task/feature/data/models/recipe.dart';
import 'package:bt_recipe_management_task/feature/data/repositories/recipe_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RecipeRepositoryImpl', () {
    late RecipeRepositoryImpl repository;
    late Recipe testRecipe;

    setUp(() {
      repository = RecipeRepositoryImpl();
      testRecipe = const Recipe(
        id: 1,
        name: 'Test Recipe',
        category: 'Test Category',
        ingredients: 'Test Ingredients',
      );
    });

    test('addRecipe should add a recipe to the list', () async {
      repository.addRecipe(testRecipe);
      final recipes = await repository.getRecipes();

      expect(recipes.contains(testRecipe), isTrue);
    });



    test('deleteRecipe should remove a recipe by id', () async {
      repository.addRecipe(testRecipe);
      repository.deleteRecipe(testRecipe.id);
      final recipes = await repository.getRecipes();
      expect(recipes.contains(testRecipe), isFalse);
    });

    test('deleteAllRecipes should clear the recipe list', () async {
      repository.addRecipe(testRecipe);
      repository.deleteAllRecipes();
      final recipes = await repository.getRecipes();
      expect(recipes.isEmpty, isTrue);
    });
    //
    test('editRecipe should update an existing recipe', () async {
      repository.addRecipe(testRecipe);
      final updatedRecipe = Recipe(
        id: testRecipe.id,
        name: 'Updated Recipe',
        category: 'Updated Category',
        ingredients: 'Updated Ingredients',
      );
      repository.editRecipe(updatedRecipe);
      final recipes = await repository.getRecipes();
      expect(recipes.first.name, equals('Updated Recipe'));
    });

    test('isRecipeAlreadyExists should return true if recipe exists', () {
      repository.addRecipe(testRecipe);
      expect(repository.isRecipeAlreadyExists(testRecipe), isTrue);
    });

    test('filterRecipes should return recipes matching the category', () {
      repository.addRecipe(testRecipe);
      final filteredRecipes = repository.filterRecipes('Test Category');
      expect(filteredRecipes.length, equals(1));
    });

    test('searchRecipes should return recipes matching the query', () {
      repository.addRecipe(testRecipe);
      final searchedRecipes = repository.searchRecipes('Test Recipe');
      expect(searchedRecipes.length, equals(1));
    });
  });
}
