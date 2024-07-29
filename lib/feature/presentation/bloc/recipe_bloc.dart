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
  final AddRecipe addRecipe;
  final AlreadyExistRecipe alreadyExistRecipe;
  final DeleteRecipe deleteRecipe;
  final DeleteAllRecipes deleteAllRecipes;
  final EditRecipe editRecipe;
  final FilterRecipes filterRecipes;
  final SearchRecipes searchRecipes;

  int? _editableRecipeId;

  RecipeBloc({
    required this.addRecipe,
    required this.alreadyExistRecipe,
    required this.deleteRecipe,
    required this.deleteAllRecipes,
    required this.editRecipe,
    required this.filterRecipes,
    required this.searchRecipes,
  }) : super(RecipeInitial()) {
    on<LoadRecipesEvent>((event, emit) async {
      emit(RecipeLoadInProgress());
      try {
        final recipes = searchRecipes("");
        emit(RecipeLoadSuccess(recipes));
      } catch (err) {
        emit(RecipeLoadFailure());
      }
    });

    on<AddRecipeEvent>((event, emit) {
      Recipe recipe = event.recipe;
      if (!recipe.isValid) {
        emit(const ErrorRecipe(StringConst.enterInputFields));
      } else if (alreadyExistRecipe(event.recipe)) {
        emit(const ErrorRecipe(StringConst.recipeAlreadyExists));
      } else {
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

    on<DeleteRecipeEvent>((event, emit) {
      deleteRecipe(event.id);
      emit(RecipeDeleted());
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    on<DeleteAllRecipesEvent>((event, emit) {
      deleteAllRecipes();
      emit(AllRecipesDeleted());
    });

    on<GetAllRecipesEvent>((event, emit) {
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    on<RecipeExistenceEvent>((event, emit) {
      bool isExists = alreadyExistRecipe(event.recipe);
      if (isExists) {
        emit(const ErrorRecipe(StringConst.recipeAlreadyExists));
      }
    });

    on<EditRecipeEventAction>((event, emit) {
      _editableRecipeId = event.recipe.id;
      emit(RecipeEditAction(event.recipe));
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    on<ErrorRecipeEvent>((event, emit) {
      emit(ErrorRecipe(event.message));
      final searchedRecipes = searchRecipes("");
      emit(RecipeLoadSuccess(searchedRecipes));
    });

    on<FilterRecipesEvent>((event, emit) {
      final filteredRecipes = filterRecipes(event.category);
      emit(RecipeFilterSuccess(filteredRecipes));
    });

    on<SearchRecipesEvent>((event, emit) {
      final searchedRecipes = searchRecipes(event.query);
      emit(RecipeSearchSuccess(searchedRecipes));
    });

    add(LoadRecipesEvent());
  }
}