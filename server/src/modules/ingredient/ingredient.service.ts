import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Ingredient, IngredientModel } from 'src/models/Ingredient';
import { CreateIngredientData } from './InputTypes/CreateIngredientData';
import { EditIngredientData } from './InputTypes/EditIngredientData';

@Injectable()
export class IngredientService {
  constructor(
    @InjectModel(Ingredient.name)
    private readonly ingredientModel: IngredientModel,
  ) {}

  public async getIngredients(): Promise<Ingredient[]> {
    try {
      const ingredients = await this.ingredientModel
        .find()
        .populate({ path: 'foods' });

      return this.ingredientModel.populate(ingredients, {
        path: 'category',
      });
    } catch (error) {
      console.trace(error);
    }
  }

  public async getIngredient(id: string) {
    try {
      const ingredient = await this.ingredientModel
        .findById(id)
        .populate({ path: 'foods' });

      return this.ingredientModel.populate(ingredient, {
        path: 'category',
      });
    } catch (error) {
      console.trace(error);
    }
  }

  public async findIngredientsByName(value: string) {
    try {
      const regexp = new RegExp(`^${value}`, 'gi');
      const ingredients = await this.ingredientModel
        .find({ name: regexp })
        .populate({ path: 'foods' });

      return this.ingredientModel.populate(ingredients, { path: 'category' });
    } catch (error) {
      console.trace(error);
    }
  }

  public async createIngredient(data: CreateIngredientData) {
    try {
      return this.ingredientModel.create({
        ...data,
        foods: [],
        createdAt: new Date().getTime(),
      });
    } catch (error) {
      console.trace(error);
    }
  }

  public async editIngredient(data: EditIngredientData) {
    try {
      return this.ingredientModel.findByIdAndUpdate(data._id, data, {
        new: true,
      });
    } catch (error) {
      console.trace(error);
    }
  }

  public async deleteIngredient(_id: string) {
    try {
      return this.ingredientModel.findByIdAndDelete({ _id });
    } catch (error) {
      console.trace(error);
    }
  }
}
