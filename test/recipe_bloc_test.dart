import 'package:bt_recipe_management_task/core/constants/string_constant.dart';
import 'package:bt_recipe_management_task/feature/data/models/recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/add_recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/already_exist_recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/delete_all_recipes.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/delete_recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/edit_recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/filter_recipes.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/search_recipes.dart';
import 'package:bt_recipe_management_task/feature/presentation/bloc/recipe_bloc.dart';
import 'package:bt_recipe_management_task/feature/data/repositories/recipe_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late RecipeBloc recipeBloc;
  late MockRecipeRepository mockRecipeRepository;

  /* set up initial to run the test case */
  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    recipeBloc = RecipeBloc(
      addRecipe: AddRecipe(mockRecipeRepository),
      alreadyExistRecipe: AlreadyExistRecipe(mockRecipeRepository),
      deleteRecipe: DeleteRecipe(mockRecipeRepository),
      deleteAllRecipes: DeleteAllRecipes(mockRecipeRepository),
      editRecipe: EditRecipe(mockRecipeRepository),
      filterRecipes: FilterRecipes(mockRecipeRepository),
      searchRecipes: SearchRecipes(mockRecipeRepository),
    );
  });

  tearDown(() {
    recipeBloc.close();
  });

  group('RecipeBloc', () {
    test('initial state is RecipeInitial', () {
      expect(recipeBloc.state, const RecipeLoadSuccess([]));
    });

    blocTest<RecipeBloc, RecipeState>(
      'emits [RecipeAdded, RecipeLoadSuccess] when a recipe is added',
      build: () {
        final recipe = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
        when(mockRecipeRepository.isRecipeAlreadyExists(recipe)).thenReturn(false);
        return recipeBloc;
      },
      act: (bloc) => bloc.add(AddRecipeEvent(Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion'))),
      expect: () => [
        RecipeAdded(),
        isA<RecipeLoadSuccess>(),
      ],
    );

    blocTest<RecipeBloc, RecipeState>(
      'emits [ErrorRecipe] when adding an existing recipe',
      build: () {
        final recipe = Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion');
        when(mockRecipeRepository.isRecipeAlreadyExists(recipe)).thenReturn(true);
        return recipeBloc;
      },
      act: (bloc) => bloc.add(AddRecipeEvent(Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'salt, onion'))),
      expect: () => [
        const ErrorRecipe(StringConst.recipeAlreadyExists),
        isA<RecipeLoadSuccess>(),
      ],
    );

    blocTest<RecipeBloc, RecipeState>(
      'emits [RecipeDeleted, RecipeLoadSuccess] when a recipe is deleted',
      build: () {
        return recipeBloc;
      },
      act: (bloc) => bloc.add(const DeleteRecipeEvent(1)),
      expect: () => [
        RecipeDeleted(),
        isA<RecipeLoadSuccess>(),
      ],
    );

    blocTest<RecipeBloc, RecipeState>(
      'emits [AllRecipesDeleted] when all recipes are deleted',
      build: () {
        return recipeBloc;
      },
      act: (bloc) => bloc.add(DeleteAllRecipesEvent()),
      expect: () => [
        AllRecipesDeleted(),
      ],
    );

    blocTest<RecipeBloc, RecipeState>(
        'emits [RecipesFiltered] when recipes are filtered',
        build: () {
      when(mockRecipeRepository.filterRecipes('Main')).thenReturn([]);
      return recipeBloc;
    },
    act: (bloc) => bloc.add(FilterRecipesEvent('Main')),
    expect: () => [
      RecipeFilterSuccess([]),
    ],
  );


  blocTest<RecipeBloc, RecipeState>(
    'emits [RecipesSearched] when recipes are searched',
    build: () {
      when(mockRecipeRepository.searchRecipes('Pasta')).thenReturn([]);
      return recipeBloc;
    },
    act: (bloc) => bloc.add(const SearchRecipesEvent('Pasta')),
    expect: () => [
      const RecipeSearchSuccess([]),
    ],
  );
});
}
