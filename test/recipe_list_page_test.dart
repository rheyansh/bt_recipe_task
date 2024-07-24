import 'package:bt_recipe_management_task/feature/data/repositories/recipe_repository_impl.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/already_exist_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bt_recipe_management_task/feature/data/models/recipe.dart';
import 'package:bt_recipe_management_task/feature/data/repositories/recipe_repository.dart';
import 'package:bt_recipe_management_task/feature/presentation/bloc/recipe_bloc.dart';
import 'package:bt_recipe_management_task/feature/presentation/pages/recipe_list_page.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/add_recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/delete_all_recipes.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/delete_recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/edit_recipe.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/filter_recipes.dart';
import 'package:bt_recipe_management_task/feature/domain/usecases/search_recipes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';

void main() {
  late RecipeRepositoryImpl recipeRepository;
  late RecipeBloc recipeBloc;

  setUp(() {
    recipeRepository = RecipeRepositoryImpl(recipes: []);
    recipeBloc = RecipeBloc(
      addRecipe: AddRecipe(recipeRepository),
      alreadyExistRecipe: AlreadyExistRecipe(recipeRepository),
      deleteRecipe: DeleteRecipe(recipeRepository),
      deleteAllRecipes: DeleteAllRecipes(recipeRepository),
      editRecipe: EditRecipe(recipeRepository),
      filterRecipes: FilterRecipes(recipeRepository),
      searchRecipes: SearchRecipes(recipeRepository),
    );
  });

  testWidgets('RecipeListPage displays list of recipes', (WidgetTester tester) async {
    // Add a recipe to the repository
    recipeRepository.addRecipe(Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'Salt, Onion'));

    // Pump the widget tree with RecipeListPage
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RecipeBloc>(
          create: (_) => recipeBloc,
          child: const RecipeListPage(),
        ),
      ),
    );

    // Allow the UI to settle
    await tester.pumpAndSettle();

    // Expect to find the added recipe in the UI
    expect(find.text('Pasta'), findsOneWidget);
  });

  testWidgets('Deleting a recipe updates the list', (WidgetTester tester) async {
    recipeRepository.addRecipe(Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'Salt, Onion'));
    await tester.pumpAndSettle();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RecipeBloc>(
          create: (_) => recipeBloc,
          child: const RecipeListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    // expect(find.text('Pasta'), findsOneWidget);
    recipeRepository.deleteRecipe(1);
    await tester.tap(find.byKey(const Key('deleteButton0')));
    await tester.pumpAndSettle();
    expect(find.text('Pasta'), findsNothing);
  });

  testWidgets('Filtering recipes updates the list', (WidgetTester tester) async {
    recipeRepository.addRecipe(Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'Salt, Onion'));
    recipeRepository.addRecipe(Recipe(id: 2, name: 'Salad', category: 'Side', ingredients: 'Lettuce, Tomato'));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RecipeBloc>(
          create: (_) => recipeBloc,
          child: const RecipeListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('filterField')), 'Side');
    await tester.pumpAndSettle();

    expect(find.text('Pasta'), findsNothing);
    expect(find.text('Salad'), findsOneWidget);
  });

  testWidgets('Adding a recipe updates the list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RecipeBloc>(
          create: (_) => recipeBloc,
          child: const RecipeListPage(),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('nameField')), 'Pasta');
    await tester.enterText(find.byKey(const Key('categoryField')), 'Main');
    await tester.enterText(find.byKey(const Key('ingredientsField')), 'Salt, Onion');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Pasta'), findsOneWidget);
  });

  testWidgets('Deleting all recipes updates the list', (WidgetTester tester) async {
    recipeRepository.addRecipe(Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'Salt, Onion'));
    recipeRepository.deleteAllRecipes();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RecipeBloc>(
          create: (_) => recipeBloc,
          child: const RecipeListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('deleteAll')));
    await tester.pumpAndSettle();

    expect(find.text('Pasta'), findsNothing);
  });

  testWidgets('Searching recipes updates the list', (WidgetTester tester) async {
    recipeRepository.addRecipe(Recipe(id: 1, name: 'Pasta', category: 'Main', ingredients: 'Salt, Onion'));
    recipeRepository.addRecipe(Recipe(id: 2, name: 'Salad', category: 'Side', ingredients: 'Lettuce, Tomato'));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RecipeBloc>(
          create: (_) => recipeBloc,
          child: const RecipeListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('searchField')), 'Salad');
    await tester.pumpAndSettle();

    expect(find.text('Pasta'), findsNothing);
    expect(find.text('Salad'), findsOneWidget);
  });
}
