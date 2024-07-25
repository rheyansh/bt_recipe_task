
part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

/* Initial state */
class RecipeInitial extends RecipeState {}

/* State on Recipe load */
class RecipeLoadInProgress extends RecipeState {}

/* State on Recipe success */
class RecipeLoadSuccess extends RecipeState {
  final List<Recipe> recipes;
  const RecipeLoadSuccess(this.recipes);

  @override
  List<Object> get props => [recipes];
}

/* State on recipe filter success */
class RecipeFilterSuccess extends RecipeState {
  final List<Recipe> recipes;
  const RecipeFilterSuccess(this.recipes);

  @override
  List<Object> get props => [recipes];
}

/* State on recipe search success */
class RecipeSearchSuccess extends RecipeState {
  final List<Recipe> recipes;
  const RecipeSearchSuccess(this.recipes);

  @override
  List<Object> get props => [recipes];
}

/* State on Recipe failure */
class RecipeLoadFailure extends RecipeState {}

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

/* State to trigger error message */

class ErrorRecipe extends RecipeState {
  final String message;

  const ErrorRecipe(this.message);

  @override
  List<Object> get props => [message];
}