import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Category, CategoryModel } from 'src/models/Category';
import { Food, FoodModel } from 'src/models/Food';
import { Ingredient, IngredientModel } from 'src/models/Ingredient';

@Injectable()
export class AppService {
  constructor(
    @InjectModel(Ingredient.name)
    private readonly ingredientModel: IngredientModel,
    @InjectModel(Category.name)
    private readonly categoryModel: CategoryModel,
    @InjectModel(Food.name)
    private readonly foodModel: FoodModel,
  ) {}

  async getHello(): Promise<Ingredient> {
    const ingr = await this.ingredientModel.findOne();
    const dessertCat = await this.categoryModel.findOne({ name: 'dessert' });
    const food = await this.foodModel.findOne();
    food.ingredients.push({ _id: ingr._id, quantity: 3.2 });
    await food.save();
    dessertCat.foods.push(food);
    await dessertCat.save();

    return this.ingredientModel.findOne();
  }
}
