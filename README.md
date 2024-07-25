# bt_recipe_management_task
Flutter application that manages a list of recipes

### Note: Please Run pub get to install bloc and run the code

### Architecture used
CLEAN Architecture

### State management solution used
Bloc State Management

### Folder Structure
![Alt text](https://github.com/rheyansh/bt_recipe_task/blob/main/Screenshots/11.png)

### Task performed
	1.	Add recipe
	2.	Edit recipe
	3.	Delete Recipe
	4.	Delete all recipes
	5.	Filter recipes based on categories
	6.	Search recipes based on title (i.e name)
	7.	On recipe list items, navigate to recipe detail page
	8.	Check if input field is valid or not
	9.	Check id recipe is already exists or not

### Added lTDD and BDD:

A) Listed Unit Test Cases written for Recipe Repository

	1.	Should add a recipe
	2.	Should delete a recipe by id
	3.	Should clear all recipes
	4.	Should edit a recipe
	5.	Should check if recipe already exists
	6.	Should filter recipes by category
	7.	Should search recipes by name

B) Listed Unit Test Cases written for Recipe Bloc

	1.	emits [RecipeAdded, RecipeLoadSuccess] when a recipe is added
	2.	emits [ErrorRecipe] when adding an existing recipe
	3.	emits [RecipeDeleted, RecipeLoadSuccess] when a recipe is deleted
	4.	emits [AllRecipesDeleted] when all recipes are deleted
	5.	emits [RecipesFiltered] when recipes are filtered
	6.	emits [RecipesSearched] when recipes are searched

C) Listed Widget Test Cases written for Recipe List Page

	1.	RecipeListPage displays list of recipes
	2.	Deleting a recipe updates the list
	3.	Adding a recipe updates the list
	4.	Deleting all recipes updates the list
	5.	Searching recipes updates the list
	6.	Filtering recipes updates the list

D) Listed Widget Test Cases written for Recipe Detail Page

	1.	User taps on recipe and navigates to recipe details page and info is showing

### Web
![Alt text](https://github.com/rheyansh/bt_recipe_task/blob/main/Screenshots/1.png)
![Alt text](https://github.com/rheyansh/bt_recipe_task/blob/main/Screenshots/2.png)

### Mobile
![Alt text](https://github.com/rheyansh/bt_recipe_task/blob/main/Screenshots/3.png)
![Alt text](https://github.com/rheyansh/bt_recipe_task/blob/main/Screenshots/4.png)
![Alt text](https://github.com/rheyansh/bt_recipe_task/blob/main/Screenshots/5.png)
![Alt text](https://github.com/rheyansh/bt_recipe_task/blob/main/Screenshots/6.png)

# Author

* [Raj Sharma](https://sites.google.com/view/rheyansh)

# License
RPicker is available under the MIT license. See the LICENSE file for more info.

## Other Libraries
* [RPicker](https://github.com/rheyansh/RPicker):-  Elegant and Easy-to-Use Date and Options Picker.
* [RBiometric](https://github.com/rheyansh/RBiometric):- Elegant and Easy-to-Use library for iOS Biometric (TouchId and FaceId) authentication.
* [RFirebaseMessaging](https://github.com/rheyansh/RFirebaseMessaging):- Project provides basic idea and approach for building small social media application using firebase and implementing chat using Firebase.
* [RBeacon](https://github.com/rheyansh/RBeacon):- Sample project for turning android device into a Beacon device. App can work as both broadcaster and receiver.
* [RPdfGenerator](https://github.com/rheyansh/RPdfGenerator):- A sample project to generate PDF file from data using itextpdf/itext7 library.
