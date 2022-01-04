import { Injectable } from '@nestjs/common';
import { ErrorMEssage, ErrorType } from 'src/constants/Errors';
import { FormErrorMessage, FormErrorType } from 'src/constants/formErrors';
import { Ingredient } from 'src/models/Ingredient';
import { ILike } from 'typeorm';
import { CreateIngredientData } from './InputTypes/CreateIngredientData';
import { EditIngredientData } from './InputTypes/EditIngredientData';
import { IngredientResponse } from './Responses/IngredientResponse';

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
    const response: IngredientResponse = { errors: [], ingredient: null };

    try {
      const ingredient = Ingredient.create(data);
      response.ingredient = await ingredient.save({ reload: true });

      return response;
    } catch (error) {
      if (error.code === '23505') {
        const column = (error.detail as string).match(/\(([^()]*)\)/)?.[1];

        response.errors.push({
          type: ErrorType.DUPLICATE,
          field: column,
          message: ErrorMEssage.DUPLICATE,
        });
      }

      return response;
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
      if (ingredient) {
        await ingredient.remove();
        return 'ok';
      }

      return "La ressource n'existe déjà plus.";
    } catch (error) {
      console.trace(error);
    }
  }
}
