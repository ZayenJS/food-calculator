recipe_ingredient, 0N ingredients, 1N recipes: ingredient_id, recipe_id, quantity, created_at, updated_at
recipes: id, name, cooking_time, preparation_time, difficulty, created_at, updated_at
recipe_instruction, 1N recipes, 11 instructions

ingredients: id, name, calories, proteins, carbohydrates, sugars, fats, saturated, salt, created_at, updated_at
recipe_category, 1N recipes, 0N categories
instructions: id, content, created_at, updated_at

:
categories: id, name, created_at, updated_at
:
