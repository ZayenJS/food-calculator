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

  public getHello(): string {
    return 'Hello World !';
  }
}
