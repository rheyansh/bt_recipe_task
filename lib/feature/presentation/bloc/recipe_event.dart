// presentation/blocs/recipe_event.dart

part of 'recipe_bloc.dart';

/* abstarct class to define the base event */

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

/* Event to load recipes */

class LoadRecipesEvent extends RecipeEvent {}

/* Event to add recipe */

class AddRecipeEvent extends RecipeEvent {
  final Recipe recipe;

  const AddRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

/* Event to trigger error message, so that bloc can notify UI to show error alert */

class ErrorRecipeEvent extends RecipeEvent {
  final String message;

  const ErrorRecipeEvent(this.message);

  @override
  List<Object> get props => [message];
}

/* Event to delete recipe */

class DeleteRecipeEvent extends RecipeEvent {
  final int id;

  const DeleteRecipeEvent(this.id);

  @override
  List<Object> get props => [id];
}

/* Event to edit recipe action */
class EditRecipeEventAction extends RecipeEvent {
  final Recipe recipe;

  const EditRecipeEventAction(this.recipe);

  @override
  List<Object> get props => [recipe];
}

/* event to check if recipe already exists or not */
class RecipeExistenceEvent extends RecipeEvent {
  final Recipe recipe;

  const RecipeExistenceEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

/* Event to filter recipes */

class FilterRecipesEvent extends RecipeEvent {
  final String category;

  const FilterRecipesEvent(this.category);

  @override
  List<Object> get props => [category];
}

/* Event to search recipe */

class SearchRecipesEvent extends RecipeEvent {
  final String query;

  const SearchRecipesEvent(this.query);

  @override
  List<Object> get props => [query];
}

/* Event to delete all recipes */
class DeleteAllRecipesEvent extends RecipeEvent {}

/* Event to get all recipes */
class GetAllRecipesEvent extends RecipeEvent {}