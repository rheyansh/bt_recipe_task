# bt_recipe_management_task
Flutter application that manages a list of recipes

# Note: Run pub get to install bloc and run the code

## Folder Structure with CLEAN Architecture and Bloc State Management Solution

lib/
├── data/
│   ├── models/
│   │   └── recipe.dart
│   ├── repositories/
│       ├── recipe_repository.dart
│       └── recipe_repository_impl.dart
├── domain/
│   ├── usecases/
│       ├── add_recipe.dart
│       ├── already_exist_recipe.dart
│       ├── delete_all_recipes.dart
│       ├── delete_recipe.dart
│       ├── edit_recipe.dart
│       ├── filter_recipes.dart
│       └── search_recipes.dart
├── presentation/
│   ├── blocs/
│       ├── recipe_bloc.dart
│       ├── recipe_event.dart
│       └── recipe_state.dart
│   ├── pages/
│       ├── recipe_list_page.dart
│       └── recipe_detail_page.dart
│   ├── widgets/
│       ├── alert_dialog.dart
│       ├── recipe_input_form.dart
│       └── recipe_row.dart
├── core/
│   ├── constants/
│       ├── string_constant.dart
│       └── app_color.dart
│   ├── shared/widgets
│       └── app_bar.dart
└── main.dart

## Task performed 
Add recipe
Edit recipe
Delete Recipe
Delete all recipes
Filter recipes based on categories
Search recipes based on title (i.e name)
On recipe list items, navigate to recipe detail page

