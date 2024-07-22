
part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

/* Initial state */
class RecipeInitial extends RecipeState {}

/* State on Recipe added */
class RecipeAdded extends RecipeState {}

/* State on Recipe deletion */
class RecipeDeleted extends RecipeState {}

/* State on all Recipe deletion */
class AllRecipesDeleted extends RecipeState {}

/* State to trigger when user select a row to edit the recipe so that input field can be prepopulated with data */
class RecipeEditAction extends RecipeState {
  final Recipe recipe;

  const RecipeEditAction(this.recipe);

  @override
  List<Object> get props => [recipe];
}

/* State on to trigger error message */

class ErrorRecipe extends RecipeState {
  final String message;

  const ErrorRecipe(this.message);

  @override
  List<Object> get props => [message];
}

/* State on emit filtered recipes */

class RecipesFiltered extends RecipeState {
  final List<Recipe> filteredRecipes;

  const RecipesFiltered(this.filteredRecipes);

  @override
  List<Object> get props => [filteredRecipes];
}

/* State on emit search result of recipes */

class RecipesSearched extends RecipeState {
  final List<Recipe> searchedRecipes;

  const RecipesSearched(this.searchedRecipes);

  @override
  List<Object> get props => [searchedRecipes];
}
