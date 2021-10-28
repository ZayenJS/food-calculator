import { Module } from '@nestjs/common';
import { Ingredient } from 'src/models/Ingredient';
import { IngredientResolver } from './ingredient.resolver';
import { IngredientService } from './ingredient.service';

@Module({
  imports: [Ingredient],
  providers: [IngredientResolver, IngredientService],
})
export class IngredientsModule {}
