import { Injectable } from '@nestjs/common';
import { Ingredient } from 'src/models/Ingredient';
import { ILike } from 'typeorm';
import { CreateIngredientData } from './InputTypes/CreateIngredientData';
import { EditIngredientData } from './InputTypes/EditIngredientData';

@Injectable()
export class IngredientService {
  public async getIngredients(): Promise<Ingredient[]> {
    try {
      return await Ingredient.find({ relations: ['recipes'] });
    } catch (error) {
      console.trace(error);
    }
  }

  public async getIngredient(id: number) {
    try {
      return await Ingredient.findOne(id, {
        where: { id },
        relations: ['recipes'],
      });
    } catch (error) {
      console.trace(error);
    }
  }

  public async findIngredientsByName(value: string) {
    try {
      return await Ingredient.find({
        where: { name: ILike(`${value}%`) },
        relations: ['recipes'],
      });
    } catch (error) {
      console.trace(error);
    }
  }

  public async createIngredient(data: CreateIngredientData) {
    try {
      const ingredient = await Ingredient.create(data);
      return ingredient.save({ reload: true });
    } catch (error) {
      console.trace(error);
    }
  }

  public async editIngredient(data: EditIngredientData) {
    try {
      await Ingredient.update(data.id, data, { reload: true });
      return this.getIngredient(data.id);
    } catch (error) {
      console.trace(error);
    }
  }

  public async deleteIngredient(id: number) {
    try {
      const ingredient = await Ingredient.findOne(id);
      let message = "La ressource n'existe déjà plus.";
      if (ingredient) {
        await ingredient.remove();
        message = 'ok';
      }
      return message;
    } catch (error) {
      console.trace(error);
    }
  }
}
