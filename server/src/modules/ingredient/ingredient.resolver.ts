import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Ingredient } from 'src/models/Ingredient';
import { IngredientService } from './ingredient.service';
import { CreateIngredientData } from './InputTypes/CreateIngredientData';
import { EditIngredientData } from './InputTypes/EditIngredientData';

@Resolver()
export class IngredientResolver {
  constructor(private readonly ingredientService: IngredientService) {}

  @Query(() => [Ingredient])
  public async getIngredients(): Promise<Ingredient[]> {
    return this.ingredientService.getIngredients();
  }

  @Mutation(() => Ingredient)
  public async createIngredient(@Args('data') data: CreateIngredientData) {
    return this.ingredientService.createIngredient(data);
  }

  @Mutation(() => Ingredient)
  public async editIngredient(@Args('data') data: EditIngredientData) {
    return this.ingredientService.editIngredient(data);
  }

  @Mutation(() => Ingredient)
  public async deleteIngredient(@Args('_id') _id: string) {
    return this.ingredientService.deleteIngredient(_id);
  }
}
