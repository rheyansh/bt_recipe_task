import 'package:bt_recipe_management_task/feature/data/models/recipe.dart';
import 'package:bt_recipe_management_task/feature/data/repositories/recipe_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RecipeRepositoryImpl recipeRepository;

  setUp(() {
    recipeRepository = RecipeRepositoryImpl();
  });

  group('RecipeRepositoryImpl', () {
    test('should add a recipe', () async {
      const recipe = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
      recipeRepository.addRecipe(recipe);
      final recipes = await recipeRepository.getRecipes();
      expect(recipes.length, 1);
      expect(recipes.contains(recipe), isTrue);
    });

    test('should delete a recipe by id', () async {
      const recipe = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
      recipeRepository.addRecipe(recipe);
      await recipeRepository.deleteRecipe(1);
      final recipes = await recipeRepository.getRecipes();
      expect(recipes.length, 0);
    });

    test('should clear all recipes', () async {
      const recipe1 = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
      const recipe2 = Recipe(id: 2, name: 'Pizza', category: 'Main', ingredients: 'cheese, tomato');
      recipeRepository.addRecipe(recipe1);
      recipeRepository.addRecipe(recipe2);
      recipeRepository.deleteAllRecipes();
      final recipes = await recipeRepository.getRecipes();
      expect(recipes.length, 0);
    });

    test('should edit a recipe', () async {
      const recipe = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
      recipeRepository.addRecipe(recipe);
      const updatedRecipe = Recipe(id: 1, name: 'Spaghetti', category: 'Main', ingredients: 'salt, garlic');
      await recipeRepository.editRecipe(updatedRecipe);
      final recipes = await recipeRepository.getRecipes();
      expect(recipes[0].name, 'Spaghetti');
    });

    test('should check if recipe already exists', () async {
      const recipe = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
      recipeRepository.addRecipe(recipe);
      final exists = recipeRepository.isRecipeAlreadyExists(recipe);
      expect(exists, isTrue);
    });

    test('should filter recipes by category', () async {
      const recipe1 = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
      const recipe2 = Recipe(id: 2, name: 'Pizza', category: 'Dessert', ingredients: 'cheese, tomato');
      recipeRepository.addRecipe(recipe1);
      recipeRepository.addRecipe(recipe2);
      final filteredRecipes = recipeRepository.filterRecipes('Main');
      expect(filteredRecipes.length, 1);
      expect(filteredRecipes[0].name, 'Pasta');
    });

    test('should search recipes by name', () async {
      const recipe1 = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
      const recipe2 = Recipe(id: 2, name: 'Pizza', category: 'Dessert', ingredients: 'cheese, tomato');
      recipeRepository.addRecipe(recipe1);
      recipeRepository.addRecipe(recipe2);
      final searchedRecipes = recipeRepository.searchRecipes('Pizza');
      expect(searchedRecipes.length, 1);
      expect(searchedRecipes[0].name, 'Pizza');
    });
  });
}
