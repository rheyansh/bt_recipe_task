import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final int id;
  final String name;
  final String category;
  final String ingredients;

  /* constructor */

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.ingredients,
  });

  @override
  List<Object?> get props => [id, name, category, ingredients];
}

/* extension of Recipe to check if it has valid filed */
extension RecipeValidator on Recipe {
  bool get isValid => name.isNotEmpty && category.isNotEmpty && ingredients.isNotEmpty;
}
