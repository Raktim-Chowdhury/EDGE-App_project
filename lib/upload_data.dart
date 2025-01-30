import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadRecipes extends StatelessWidget {
  // List of recipes to upload
  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Curried Sausages',
      'image': 'https://img.freepik.com/free-photo/front-view-meat-sauce-soup-with-greens-potatoes-dark-desk-soup-meal-sauce-meat_140725-79067.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.5',
      'reviews': 10,
      'time': 20,
      'cal': 350,
      'ingredients': [
        {'name': 'Sausages', 'quantity': '500g'},
        {'name': 'Curry Powder', 'quantity': '2 tbsp'},
        {'name': 'Onions', 'quantity': '2 medium'},
      ],
      'ingredientsImage': [
        'https://example.com/sausage.jpg',
        'https://example.com/curry_powder.jpg',
        'https://example.com/onions.jpg',
      ],
      'ingredientsAmount': ['500', '2', '2'],
      'steps': [
        'Cook sausages until browned.',
        'Add onions and curry powder, and sauté.',
        'Simmer with water or stock for 15 minutes.',
      ],
    },
    {
      'name': 'Butter-Paneer',
      'image': 'https://j6e2i8c9.rocketcdn.me/wp-content/uploads/2020/12/Paneer-butter-masala-recipe-3.jpg',
      'category': 'Dinner',
      'rate': '4.5',
      'reviews': 10,
      'time': 25,
      'cal': 400,
      'ingredients': [
        {'name': 'Paneer', 'quantity': '400g'},
        {'name': 'Butter', 'quantity': '100g'},
        {'name': 'Spices', 'quantity': '100g'},
      ],
      'ingredientsImage': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLk48UP4u-kcv0MmyAVeR8RoI-nkKzxTxiwg&s',
        'https://www.creedfoodservice.co.uk/media/catalog/product/cache/935f6cdd49b787f7edd26d0d606f282f/0/9/09bcd2f99a0640be0ffe0e05e4091189.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtlDa881r2wjaDegXwN7L6NyXipqCITNR45A&s',
      ],
      'ingredientsAmount': ['400', '100', '100'],
      'steps': [
        'Heat butter in a pan.',
        'Add spices and cook for 2 minutes.',
        'Add paneer cubes and cook for another 5 minutes.',
        'Serve hot with naan or rice.',
      ],
    },
    {
      'name': 'Vegetable Stir Fry',
      'image': 'https://img.freepik.com/premium-photo/asian-cuisine-stir-fry-with-chicken-red-paprika-pepper-zucchini-bowl-white-kitchen-table-background-top-view-copy-space_630207-7403.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Quick Meals',
      'rate': '4.3',
      'reviews': 15,
      'time': 15,
      'cal': 200,
      'ingredients': [
        {'name': 'Mixed Vegetables', 'quantity': '400g'},
        {'name': 'Soy Sauce', 'quantity': '3 tbsp'},
        {'name': 'Garlic', 'quantity': '2 cloves'},
      ],
      'ingredientsImage': [
        'https://example.com/vegetables.jpg',
        'https://example.com/soy_sauce.jpg',
        'https://example.com/garlic.jpg',
      ],
      'ingredientsAmount': ['400', '3', '2'],
      'steps': [
        'Heat oil in a wok.',
        'Add vegetables and stir fry on high heat.',
        'Add soy sauce and cook for another 2 minutes.',
      ],
    },
    {
      'name': 'Pasta Alfredo',
      'image': 'https://img.freepik.com/premium-photo/penne-pasta-carbonara-cream-sauce-with-mushroom_1339-123126.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.6',
      'reviews': 18,
      'time': 20,
      'cal': 400,
      'ingredients': [
        {'name': 'Pasta', 'quantity': '200g'},
        {'name': 'Cream', 'quantity': '100ml'},
        {'name': 'Cheese', 'quantity': '100g'},
      ],
      'ingredientsImage': [
        'https://example.com/pasta.jpg',
        'https://example.com/cream.jpg',
        'https://example.com/cheese.jpg',
      ],
      'ingredientsAmount': ['200', '100', '100'],
      'steps': [
        'Boil pasta until al dente.',
        'Heat cream and cheese in a pan.',
        'Mix pasta into the sauce and serve hot.',
      ],
    },
    {
      'name': 'Grilled Salmon',
      'image': 'https://img.freepik.com/free-photo/plate-salmon-steak-with-broccoli_181624-32092.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Healthy',
      'rate': '4.8',
      'reviews': 22,
      'time': 20,
      'cal': 320,
      'ingredients': [
        {'name': 'Salmon', 'quantity': '2 fillets'},
        {'name': 'Lemon', 'quantity': '1'},
        {'name': 'Olive Oil', 'quantity': '2 tbsp'},
      ],
      'ingredientsImage': [
        'https://example.com/salmon.jpg',
        'https://example.com/lemon.jpg',
        'https://example.com/olive_oil.jpg',
      ],
      'ingredientsAmount': ['2', '1', '2'],
      'steps': [
        'Marinate salmon with lemon and olive oil.',
        'Grill for 10 minutes on each side.',
        'Serve with a side of vegetables.',
      ],
    },
    {
      'name': 'French Toast',
      'image': 'https://img.freepik.com/free-photo/french-toast-with-berries-jam-breakfast_2829-19875.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Breakfast',
      'rate': '4.4',
      'reviews': 8,
      'time': 10,
      'cal': 250,
      'ingredients': [
        {'name': 'Bread Slices', 'quantity': '4'},
        {'name': 'Eggs', 'quantity': '2'},
        {'name': 'Milk', 'quantity': '50ml'},
      ],
      'ingredientsImage': [
        'https://example.com/bread.jpg',
        'https://example.com/eggs.jpg',
        'https://example.com/milk.jpg',
      ],
      'ingredientsAmount': ['4', '2', '50'],
      'steps': [
        'Whisk eggs and milk together.',
        'Dip bread slices in the mixture.',
        'Cook on a hot pan until golden brown.',
      ],
    },
    {
      'name': 'Caesar Salad',
      'image': 'https://img.freepik.com/premium-photo/appetizing-caesar-salad-plate-wooden-table_437222-2952.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Healthy',
      'rate': '4.2',
      'reviews': 12,
      'time': 10,
      'cal': 180,
      'ingredients': [
        {'name': 'Lettuce', 'quantity': '200g'},
        {'name': 'Croutons', 'quantity': '50g'},
        {'name': 'Caesar Dressing', 'quantity': '50ml'},
      ],
      'ingredientsImage': [
        'https://example.com/lettuce.jpg',
        'https://example.com/croutons.jpg',
        'https://example.com/caesar_dressing.jpg',
      ],
      'ingredientsAmount': ['200', '50', '50'],
      'steps': [
        'Toss lettuce with croutons and dressing.',
        'Serve immediately.',
      ],
    },
    {
      'name': 'Chicken Biryani',
      'image': 'https://img.freepik.com/free-photo/top-view-arrangement-with-delicious-pakistan-meal_23-2148821534.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.7',
      'reviews': 35,
      'time': 50,
      'cal': 500,
      'ingredients': [
        {'name': 'Chicken', 'quantity': '500g'},
        {'name': 'Rice', 'quantity': '300g'},
        {'name': 'Spices', 'quantity': '50g'},
      ],
      'ingredientsImage': [
        'https://example.com/chicken.jpg',
        'https://example.com/rice.jpg',
        'https://example.com/spices.jpg',
      ],
      'ingredientsAmount': ['500', '300', '50'],
      'steps': [
        'Marinate chicken with spices.',
        'Cook rice until half done.',
        'Layer rice and chicken, cook on low heat.',
      ],
    },
    {
      'name': 'Miso Soup',
      'image': 'https://img.freepik.com/free-photo/close-up-delicious-asian-food_23-2150535878.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Healthy',
      'rate': '4.5',
      'reviews': 25,
      'time': 15,
      'cal': 120,
      'ingredients': [
        {'name': 'Miso Paste', 'quantity': '2 tbsp'},
        {'name': 'Tofu', 'quantity': '100g'},
        {'name': 'Seaweed', 'quantity': '10g'},
      ],
      'ingredientsImage': [
        'https://example.com/miso_paste.jpg',
        'https://example.com/tofu.jpg',
        'https://example.com/seaweed.jpg',
      ],
      'ingredientsAmount': ['2', '100', '10'],
      'steps': [
        'Boil water and add miso paste.',
        'Add tofu and seaweed, simmer for 5 minutes.',
        'Serve hot.',
      ],
    },
    {
      'name': 'Veggie Tacos',
      'image': 'https://img.freepik.com/premium-photo/tacos-with-chicken-tomatoes-corn-onions-mexican-food-fast-food_97840-2678.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Quick Meals',
      'rate': '4.6',
      'reviews': 18,
      'time': 20,
      'cal': 250,
      'ingredients': [
        {'name': 'Tortillas', 'quantity': '4'},
        {'name': 'Mixed Veggies', 'quantity': '200g'},
        {'name': 'Salsa', 'quantity': '50ml'},
      ],
      'ingredientsImage': [
        'https://example.com/tortillas.jpg',
        'https://example.com/veggies.jpg',
        'https://example.com/salsa.jpg',
      ],
      'ingredientsAmount': ['4', '200', '50'],
      'steps': [
        'Warm tortillas.',
        'Fill with veggies and salsa.',
        'Serve with a lime wedge.',
      ],
    },
    {
      'name': 'Shrimp Scampi',
      'image': 'https://img.freepik.com/free-photo/stir-fried-spaghetti-seafood_1339-3424.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.8',
      'reviews': 28,
      'time': 30,
      'cal': 350,
      'ingredients': [
        {'name': 'Shrimp', 'quantity': '500g'},
        {'name': 'Garlic', 'quantity': '3 cloves'},
        {'name': 'Butter', 'quantity': '100g'},
      ],
      'ingredientsImage': [
        'https://example.com/shrimp.jpg',
        'https://example.com/garlic.jpg',
        'https://example.com/butter.jpg',
      ],
      'ingredientsAmount': ['500', '3', '100'],
      'steps': [
        'Sauté garlic in butter.',
        'Add shrimp and cook until pink.',
        'Serve with pasta or bread.',
      ],
    },
    {
      'name': 'Greek Salad',
      'image': 'https://img.freepik.com/free-photo/top-view-greek-salad-with-black-olives-bread-mushrooms_141793-4030.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Healthy',
      'rate': '4.4',
      'reviews': 20,
      'time': 10,
      'cal': 200,
      'ingredients': [
        {'name': 'Tomatoes', 'quantity': '200g'},
        {'name': 'Cucumbers', 'quantity': '150g'},
        {'name': 'Feta Cheese', 'quantity': '100g'},
      ],
      'ingredientsImage': [
        'https://example.com/tomatoes.jpg',
        'https://example.com/cucumbers.jpg',
        'https://example.com/feta_cheese.jpg',
      ],
      'ingredientsAmount': ['200', '150', '100'],
      'steps': [
        'Chop veggies.',
        'Mix with feta and olive oil.',
        'Serve chilled.',
      ],
    },
    {
      'name': 'Beef Stroganoff',
      'image': 'https://img.freepik.com/premium-photo/liver-stroganoff-black-bowl-top-view_268847-6967.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.7',
      'reviews': 30,
      'time': 40,
      'cal': 500,
      'ingredients': [
        {'name': 'Beef', 'quantity': '500g'},
        {'name': 'Mushrooms', 'quantity': '200g'},
        {'name': 'Sour Cream', 'quantity': '100ml'},
      ],
      'ingredientsImage': [
        'https://example.com/beef.jpg',
        'https://example.com/mushrooms.jpg',
        'https://example.com/sour_cream.jpg',
      ],
      'ingredientsAmount': ['500', '200', '100'],
      'steps': [
        'Cook beef until browned.',
        'Add mushrooms and sauté for 5 minutes.',
        'Mix in sour cream and simmer for 10 minutes.',
      ],
    },
    {
      'name': 'Avocado Toast',
      'image': 'https://img.freepik.com/free-photo/toast-with-avocado-plate_1220-7325.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Breakfast',
      'rate': '4.6',
      'reviews': 15,
      'time': 10,
      'cal': 220,
      'ingredients': [
        {'name': 'Avocado', 'quantity': '1'},
        {'name': 'Bread', 'quantity': '2 slices'},
        {'name': 'Lemon Juice', 'quantity': '1 tbsp'},
      ],
      'ingredientsImage': [
        'https://example.com/avocado.jpg',
        'https://example.com/bread.jpg',
        'https://example.com/lemon.jpg',
      ],
      'ingredientsAmount': ['1', '2', '1'],
      'steps': [
        'Mash avocado with lemon juice.',
        'Spread mixture on toasted bread.',
        'Serve with salt and pepper to taste.',
      ],
    },
    {
      'name': 'Chicken Fajitas',
      'image': 'https://img.freepik.com/free-photo/meat-with-vegetables-sauce-sprinkled-with-sesame-seeds_140725-6734.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Quick Meals',
      'rate': '4.8',
      'reviews': 25,
      'time': 25,
      'cal': 450,
      'ingredients': [
        {'name': 'Chicken', 'quantity': '500g'},
        {'name': 'Bell Peppers', 'quantity': '3'},
        {'name': 'Tortillas', 'quantity': '4'},
      ],
      'ingredientsImage': [
        'https://example.com/chicken.jpg',
        'https://example.com/peppers.jpg',
        'https://example.com/tortillas.jpg',
      ],
      'ingredientsAmount': ['500', '3', '4'],
      'steps': [
        'Cook chicken and peppers in a pan.',
        'Fill tortillas with the mixture.',
        'Serve with sour cream and salsa.',
      ],
    },
    {
      'name': 'Quinoa Salad',
      'image': 'https://img.freepik.com/free-photo/mixed-salad-cucumber-tomato-onion-pomegranate-lemon-side-view_140725-9146.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Healthy',
      'rate': '4.5',
      'reviews': 18,
      'time': 15,
      'cal': 300,
      'ingredients': [
        {'name': 'Quinoa', 'quantity': '1 cup'},
        {'name': 'Cucumber', 'quantity': '1'},
        {'name': 'Cherry Tomatoes', 'quantity': '10'},
      ],
      'ingredientsImage': [
        'https://example.com/quinoa.jpg',
        'https://example.com/cucumber.jpg',
        'https://example.com/tomatoes.jpg',
      ],
      'ingredientsAmount': ['1', '1', '10'],
      'steps': [
        'Cook quinoa as per package instructions.',
        'Chop vegetables and mix with quinoa.',
        'Serve with olive oil and lemon dressing.',
      ],
    },
    {
      'name': 'Eggplant Parmesan',
      'image': 'https://img.freepik.com/premium-photo/famous-french-dish-from-provence_2829-9343.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.3',
      'reviews': 12,
      'time': 35,
      'cal': 380,
      'ingredients': [
        {'name': 'Eggplant', 'quantity': '1'},
        {'name': 'Tomato Sauce', 'quantity': '1 cup'},
        {'name': 'Cheese', 'quantity': '100g'},
      ],
      'ingredientsImage': [
        'https://example.com/eggplant.jpg',
        'https://example.com/tomato_sauce.jpg',
        'https://example.com/cheese.jpg',
      ],
      'ingredientsAmount': ['1', '1', '100'],
      'steps': [
        'Slice eggplant and bake until soft.',
        'Layer eggplant with sauce and cheese.',
        'Bake for 15 minutes at 180°C.',
      ],
    },
    {
      'name': 'Stuffed Bell Peppers',
      'image': 'https://img.freepik.com/premium-photo/concept-tasty-food-with-stuffed-pepper-white-background_185193-64561.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Healthy',
      'rate': '4.4',
      'reviews': 14,
      'time': 30,
      'cal': 350,
      'ingredients': [
        {'name': 'Bell Peppers', 'quantity': '4'},
        {'name': 'Rice', 'quantity': '1 cup'},
        {'name': 'Ground Beef', 'quantity': '200g'},
      ],
      'ingredientsImage': [
        'https://example.com/peppers.jpg',
        'https://example.com/rice.jpg',
        'https://example.com/beef.jpg',
      ],
      'ingredientsAmount': ['4', '1', '200'],
      'steps': [
        'Cook rice and mix with beef.',
        'Stuff the mixture into peppers.',
        'Bake for 20 minutes at 180°C.',
      ],
    },
    {
      'name': 'Spinach Smoothie',
      'image': 'https://img.freepik.com/premium-photo/green-spinach-smoothie-with-spirulina-chia-seed-lime-apple_214995-3463.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Breakfast',
      'rate': '4.6',
      'reviews': 10,
      'time': 5,
      'cal': 150,
      'ingredients': [
        {'name': 'Spinach', 'quantity': '1 cup'},
        {'name': 'Banana', 'quantity': '1'},
        {'name': 'Almond Milk', 'quantity': '1 cup'},
      ],
      'ingredientsImage': [
        'https://example.com/spinach.jpg',
        'https://example.com/banana.jpg',
        'https://example.com/milk.jpg',
      ],
      'ingredientsAmount': ['1', '1', '1'],
      'steps': [
        'Blend all ingredients until smooth.',
        'Serve chilled.',
      ],
    },
    {
      'name': 'Lemon Chicken',
      'image': 'https://img.freepik.com/premium-photo/duck-leg-steak-with-orange-sauce_1339-61675.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.5',
      'reviews': 20,
      'time': 30,
      'cal': 400,
      'ingredients': [
        {'name': 'Chicken Breast', 'quantity': '2'},
        {'name': 'Lemon Juice', 'quantity': '2 tbsp'},
        {'name': 'Garlic', 'quantity': '2 cloves'},
      ],
      'ingredientsImage': [
        'https://example.com/chicken.jpg',
        'https://example.com/lemon.jpg',
        'https://example.com/garlic.jpg',
      ],
      'ingredientsAmount': ['2', '2', '2'],
      'steps': [
        'Marinate chicken with lemon juice and garlic.',
        'Cook in a pan until done.',
        'Serve with steamed vegetables.',
      ],
    },
    {
      'name': 'Tuna Sandwich',
      'image': 'https://img.freepik.com/free-photo/tuna-sandwich-wood_1339-7587.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Quick Meals',
      'rate': '4.3',
      'reviews': 8,
      'time': 10,
      'cal': 280,
      'ingredients': [
        {'name': 'Tuna', 'quantity': '1 can'},
        {'name': 'Mayonnaise', 'quantity': '2 tbsp'},
        {'name': 'Bread', 'quantity': '2 slices'},
      ],
      'ingredientsImage': [
        'https://example.com/tuna.jpg',
        'https://example.com/mayo.jpg',
        'https://example.com/bread.jpg',
      ],
      'ingredientsAmount': ['1', '2', '2'],
      'steps': [
        'Mix tuna with mayonnaise.',
        'Spread mixture on bread slices.',
        'Serve with a side of chips.',
      ],
    },
    {
      'name': 'Chickpea Curry',
      'image': 'https://img.freepik.com/premium-photo/chickpeas-masala-chole-masala-curry-traditional-north-indian-lunch-dinner-white-background_781325-5212.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid',
      'category': 'Dinner',
      'rate': '4.7',
      'reviews': 18,
      'time': 25,
      'cal': 320,
      'ingredients': [
        {'name': 'Chickpeas', 'quantity': '1 can'},
        {'name': 'Coconut Milk', 'quantity': '1 cup'},
        {'name': 'Curry Powder', 'quantity': '2 tbsp'},
      ],
      'ingredientsImage': [
        'https://example.com/chickpeas.jpg',
        'https://example.com/coconut_milk.jpg',
        'https://example.com/curry_powder.jpg',
      ],
      'ingredientsAmount': ['1', '1', '2'],
      'steps': [
        'Sauté curry powder in a pan.',
        'Add chickpeas and coconut milk, simmer for 15 minutes.',
        'Serve with rice or naan.',
      ],
    },
    {
      "name": "Grilled Chicken Caesar Salad",
      "image": "https://img.freepik.com/premium-photo/chicken-caesar-salad-with-tomato-cucumber-olive-served-dish-isolated-table-side-view-middle-east-food_689047-3371.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Lunch",
      "rate": "4.8",
      "reviews": 22,
      "time": 20,
      "cal": 350,
      "ingredients": [
        {"name": "Romaine Lettuce", "quantity": "2 cups"},
        {"name": "Grilled Chicken Breast", "quantity": "1 piece"},
        {"name": "Caesar Dressing", "quantity": "2 tbsp"}
      ],
      "ingredientsImage": [
        "https://example.com/lettuce.jpg",
        "https://example.com/chicken.jpg",
        "https://example.com/caesar_dressing.jpg"
      ],
      "ingredientsAmount": ["2", "1", "2"],
      "steps": [
        "Chop romaine lettuce.",
        "Slice grilled chicken into strips.",
        "Toss with dressing and serve."
      ]
    },
    {
      "name": "Spaghetti Carbonara",
      "image": "https://img.freepik.com/premium-photo/classic-pasta-carbonara-with-yolk-plate-wooden_186277-837.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Dinner",
      "rate": "4.9",
      "reviews": 35,
      "time": 25,
      "cal": 480,
      "ingredients": [
        {"name": "Spaghetti", "quantity": "200g"},
        {"name": "Pancetta", "quantity": "100g"},
        {"name": "Eggs", "quantity": "2"}
      ],
      "ingredientsImage": [
        "https://example.com/spaghetti.jpg",
        "https://example.com/pancetta.jpg",
        "https://example.com/eggs.jpg"
      ],
      "ingredientsAmount": ["200", "100", "2"],
      "steps": [
        "Cook spaghetti until al dente.",
        "Fry pancetta until crispy.",
        "Mix cooked spaghetti with pancetta and egg mixture."
      ]
    },
    {
      "name": "Beef Tacos",
      "image": "https://img.freepik.com/free-photo/mexican-tacos-with-meat-vegetables-cheese_2829-5622.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Dinner",
      "rate": "4.6",
      "reviews": 28,
      "time": 20,
      "cal": 300,
      "ingredients": [
        {"name": "Ground Beef", "quantity": "300g"},
        {"name": "Taco Seasoning", "quantity": "1 packet"},
        {"name": "Tortillas", "quantity": "6"}
      ],
      "ingredientsImage": [
        "https://example.com/ground_beef.jpg",
        "https://example.com/taco_seasoning.jpg",
        "https://example.com/tortillas.jpg"
      ],
      "ingredientsAmount": ["300", "1", "6"],
      "steps": [
        "Cook ground beef with taco seasoning.",
        "Warm tortillas in a skillet.",
        "Assemble beef in tortillas with toppings."
      ]
    },
    {
      "name": "Caprese Salad",
      "image": "https://img.freepik.com/premium-photo/mozzarella-cheese-tomatoes-basil-herb-leaves-plate-white-wooden-table-caprese-salad-italian-food-top-view_2829-5995.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Salad",
      "rate": "4.8",
      "reviews": 15,
      "time": 10,
      "cal": 250,
      "ingredients": [
        {"name": "Tomatoes", "quantity": "2"},
        {"name": "Mozzarella", "quantity": "200g"},
        {"name": "Basil", "quantity": "10 leaves"}
      ],
      "ingredientsImage": [
        "https://example.com/tomatoes.jpg",
        "https://example.com/mozzarella.jpg",
        "https://example.com/basil.jpg"
      ],
      "ingredientsAmount": ["2", "200", "10"],
      "steps": [
        "Slice tomatoes and mozzarella.",
        "Layer with basil leaves.",
        "Drizzle with olive oil and balsamic glaze."
      ]
    },
    {
      "name": "Teriyaki Chicken Stir-Fry",
      "image": "https://img.freepik.com/free-photo/veal-fillet-stir-fry-with-oranges-paprika-sweet-sour-sauce-light-table_2829-19993.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Dinner",
      "rate": "4.7",
      "reviews": 20,
      "time": 25,
      "cal": 400,
      "ingredients": [
        {"name": "Chicken Breast", "quantity": "200g"},
        {"name": "Mixed Vegetables", "quantity": "2 cups"},
        {"name": "Teriyaki Sauce", "quantity": "1/4 cup"}
      ],
      "ingredientsImage": [
        "https://example.com/chicken.jpg",
        "https://example.com/vegetables.jpg",
        "https://example.com/teriyaki_sauce.jpg"
      ],
      "ingredientsAmount": ["200", "2", "1/4"],
      "steps": [
        "Stir-fry chicken until golden.",
        "Add vegetables and cook until tender.",
        "Pour teriyaki sauce and stir until coated."
      ]
    },
    {
      "name": "Greek Salad",
      "image": "https://img.freepik.com/free-photo/side-view-greek-salad-with-black-olives-bread-mushrooms_141793-4932.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Salad",
      "rate": "4.5",
      "reviews": 12,
      "time": 15,
      "cal": 200,
      "ingredients": [
        {"name": "Cucumber", "quantity": "1"},
        {"name": "Tomatoes", "quantity": "2"},
        {"name": "Feta Cheese", "quantity": "100g"}
      ],
      "ingredientsImage": [
        "https://example.com/cucumber.jpg",
        "https://example.com/tomatoes.jpg",
        "https://example.com/feta.jpg"
      ],
      "ingredientsAmount": ["1", "2", "100"],
      "steps": [
        "Chop cucumber and tomatoes.",
        "Combine with feta cheese and olives.",
        "Drizzle with olive oil and oregano."
      ]
    },
    {
      "name": "Chicken Alfredo",
      "image": "https://img.freepik.com/premium-photo/pasta-alfredo-with-chicken-spinach-cheese-italian-food_97840-8671.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Dinner",
      "rate": "4.9",
      "reviews": 40,
      "time": 30,
      "cal": 600,
      "ingredients": [
        {"name": "Fettuccine", "quantity": "200g"},
        {"name": "Chicken Breast", "quantity": "1"},
        {"name": "Parmesan Cheese", "quantity": "1/2 cup"}
      ],
      "ingredientsImage": [
        "https://example.com/fettuccine.jpg",
        "https://example.com/chicken.jpg",
        "https://example.com/parmesan.jpg"
      ],
      "ingredientsAmount": ["200", "1", "1/2"],
      "steps": [
        "Cook fettuccine pasta.",
        "Sauté chicken in butter and garlic.",
        "Add cream, Parmesan, and toss with pasta."
      ]
    },
    {
      "name": "Veggie Wrap",
      "image": "https://img.freepik.com/free-photo/shawarma-from-juicy-beef-lettuce-tomatoes-cucumbers-paprika-onion-pita-bread-with-spinach-diet-menu_2829-14482.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Lunch",
      "rate": "4.3",
      "reviews": 10,
      "time": 10,
      "cal": 250,
      "ingredients": [
        {"name": "Tortilla", "quantity": "1"},
        {"name": "Hummus", "quantity": "2 tbsp"},
        {"name": "Vegetables", "quantity": "1 cup"}
      ],
      "ingredientsImage": [
        "https://example.com/tortilla.jpg",
        "https://example.com/hummus.jpg",
        "https://example.com/vegetables.jpg"
      ],
      "ingredientsAmount": ["1", "2", "1"],
      "steps": [
        "Spread hummus on the tortilla.",
        "Add chopped vegetables.",
        "Wrap tightly and serve."
      ]
    },
    {
      "name": "Avocado Toast with Egg",
      "image": "https://img.freepik.com/premium-photo/breakfast-toast-with-avocado-poached-egg_56619-1276.jpg?ga=GA1.1.730837433.1732857960&semt=ais_hybrid",
      "category": "Breakfast",
      "rate": "4.7",
      "reviews": 30,
      "time": 10,
      "cal": 300,
      "ingredients": [
        {"name": "Bread", "quantity": "2 slices"},
        {"name": "Avocado", "quantity": "1"},
        {"name": "Egg", "quantity": "1"}
      ],
      "ingredientsImage": [
        "https://example.com/bread.jpg",
        "https://example.com/avocado.jpg",
        "https://example.com/egg.jpg"
      ],
      "ingredientsAmount": ["2", "1", "1"],
      "steps": [
        "Toast the bread.",
        "Spread mashed avocado on the toast.",
        "Top with a fried egg and season."
      ]
    }
  ];

  // Function to upload recipes to Firestore
  Future<void> uploadRecipes() async {
    final collection = FirebaseFirestore.instance.collection('Complete-Flutter-App');

    for (var recipe in recipes) {
      try {
        await collection.add(recipe);
        print('Uploaded recipe: ${recipe['name']}');
      } catch (e) {
        print('Failed to upload recipe: ${recipe['name']}');
        print(e);
      }
    }
    print('All recipes uploaded!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Recipes')),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadRecipes,
          child: const Text('Upload Recipes'),
        ),
      ),
    );
  }
}
