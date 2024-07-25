import 'package:bt_recipe_management_task/core/constants/string_constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/recipe.dart';
import '../../domain/usecases/add_recipe.dart';
import '../../domain/usecases/already_exist_recipe.dart';
import '../../domain/usecases/delete_all_recipes.dart';
import '../../domain/usecases/delete_recipe.dart';
import '../../domain/usecases/edit_recipe.dart';
import '../../domain/usecases/filter_recipes.dart';
import '../../domain/usecases/search_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {

  /* dependencies for the bloc to provide from outside of bloc init */
  final AddRecipe addRecipe;
  final AlreadyExistRecipe alreadyExistRecipe;
  final DeleteRecipe deleteRecipe;
  final DeleteAllRecipes deleteAllRecipes;
  final EditRecipe editRecipe;
  final FilterRecipes filterRecipes;
  final SearchRecipes searchRecipes;

  /* hold ongoing edit operation */
  int? _editableRecipeId;

  /* Bloc constructor */

  RecipeBloc({
    required this.addRecipe,
    required this.alreadyExistRecipe,
    required this.deleteRecipe,
    required this.deleteAllRecipes,
    required this.editRecipe,
    required this.filterRecipes,
    required this.searchRecipes,
  }) : super(RecipeInitial()) {

    // load recipes
    on<LoadRecipesEvent>((event, emit) async {
      emit(RecipeLoadInProgress());
      try {
        final recipes = searchRecipes("");
        emit(RecipeLoadSuccess(recipes));
      } catch (err) {
        emit(RecipeLoadFailure());
      }
    });

    /* Map AddRecipeEvent to State */

    on<AddRecipeEvent>((event, emit) {
      Recipe recipe = event.recipe;
      // check if valid recipe
      if (recipe.isValid == false) {
        // emit error
        emit(const ErrorRecipe(StringConst.enterInputFields));
      } else if (alreadyExistRecipe(event.recipe)) {
        // emit error
        emit(const ErrorRecipe(StringConst.recipeAlreadyExists));
      } else {
        // add recipe
        if (_editableRecipeId != null) {
          final updatedRecipe = Recipe(
              id: _editableRecipeId!,
              name: recipe.name,
              category: recipe.category,
              ingredients: recipe.ingredients
          );

          editRecipe(updatedRecipe);
          _editableRecipeId = null;
        } else {
          addRecipe(event.recipe);
        }
        emit(RecipeAdded());
      }
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    /* Map DeleteRecipeEvent to State */

    on<DeleteRecipeEvent>((event, emit) {
      deleteRecipe(event.id);
      emit(RecipeDeleted());
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    /* Map DeleteAllRecipesEvent to State */

    on<DeleteAllRecipesEvent>((event, emit) {
      deleteAllRecipes();
      emit(AllRecipesDeleted());
    });

    /* Map GetAllRecipesEvent to State */

    on<GetAllRecipesEvent>((event, emit) {
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    /* Map RecipeExistenceEvent to State */

    on<RecipeExistenceEvent>((event, emit) {
      bool isExists = alreadyExistRecipe(event.recipe);
      if (isExists) {
        emit(const ErrorRecipe(StringConst.recipeAlreadyExists));
      }
    });

    /* Map EditRecipeEventAction to State */

    on<EditRecipeEventAction>((event, emit) {
      _editableRecipeId = event.recipe.id;
      emit(RecipeEditAction(event.recipe));
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    /* Map ErrorRecipeEvent to State */

    on<ErrorRecipeEvent>((event, emit) {
      emit(ErrorRecipe(event.message));
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    /* Map FilterRecipesEvent to State */

    on<FilterRecipesEvent>((event, emit) {
      final filteredRecipes = filterRecipes(event.category);
      emit(RecipeFilterSuccess(filteredRecipes));
    });

    /* Map SearchRecipesEvent to State */

    on<SearchRecipesEvent>((event, emit) {
      final searchedRecipes = searchRecipes(event.query);
      emit(RecipeSearchSuccess(searchedRecipes));
    });

    // Automatically load recipes on initialization
    add(LoadRecipesEvent());
  }
}
