import 'package:get_it/get_it.dart';


import '../feature/data/repositories/recipe_repository.dart';
import '../feature/data/repositories/recipe_repository_impl.dart';
import '../feature/domain/usecases/add_recipe.dart';
import '../feature/domain/usecases/already_exist_recipe.dart';
import '../feature/domain/usecases/delete_all_recipes.dart';
import '../feature/domain/usecases/delete_recipe.dart';
import '../feature/domain/usecases/edit_recipe.dart';
import '../feature/domain/usecases/filter_recipes.dart';
import '../feature/domain/usecases/search_recipes.dart';
import '../feature/presentation/bloc/recipe_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  // Register RecipeRepository
  getIt.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl());

  // Register use cases
  getIt.registerLazySingleton(() => AddRecipe(getIt<RecipeRepository>()));
  getIt.registerLazySingleton(() => AlreadyExistRecipe(getIt<RecipeRepository>()));
  getIt.registerLazySingleton(() => DeleteRecipe(getIt<RecipeRepository>()));
  getIt.registerLazySingleton(() => DeleteAllRecipes(getIt<RecipeRepository>()));
  getIt.registerLazySingleton(() => EditRecipe(getIt<RecipeRepository>()));
  getIt.registerLazySingleton(() => FilterRecipes(getIt<RecipeRepository>()));
  getIt.registerLazySingleton(() => SearchRecipes(getIt<RecipeRepository>()));

  // Register RecipeBloc
  getIt.registerFactory(() => RecipeBloc(
    addRecipe: getIt<AddRecipe>(),
    alreadyExistRecipe: getIt<AlreadyExistRecipe>(),
    deleteRecipe: getIt<DeleteRecipe>(),
    deleteAllRecipes: getIt<DeleteAllRecipes>(),
    editRecipe: getIt<EditRecipe>(),
    filterRecipes: getIt<FilterRecipes>(),
    searchRecipes: getIt<SearchRecipes>(),
  ));
}
