import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Ingredient } from 'src/models/Ingredient';
import { IngredientService } from './ingredient.service';
import { CreateIngredientData } from './InputTypes/CreateIngredientData';
import { EditIngredientData } from './InputTypes/EditIngredientData';
import { IngredientResponse } from './Responses/IngredientResponse';

@Resolver()
export class IngredientResolver {
  constructor(private readonly ingredientService: IngredientService) {}

  @Query(() => [Ingredient])
  public async getIngredients(): Promise<Ingredient[]> {
    return this.ingredientService.getIngredients();
  }

  @Query(() => [Ingredient])
  public async findIngredientsByName(@Args('name') name: string) {
    return this.ingredientService.findIngredientsByName(name);
  }

  @Mutation(() => IngredientResponse)
  public async createIngredient(@Args('data') data: CreateIngredientData) {
    return this.ingredientService.createIngredient(data);
  }

  @Mutation(() => Ingredient)
  public async editIngredient(@Args('data') data: EditIngredientData) {
    return this.ingredientService.editIngredient(data);
  }

  @Mutation(() => String)
  public async deleteIngredient(@Args('id') id: number) {
    return this.ingredientService.deleteIngredient(id);
  }
}
