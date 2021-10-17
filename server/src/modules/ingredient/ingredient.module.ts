import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { Ingredient, IngredientSchema } from 'src/models/Ingredient';
import { IngredientResolver } from './ingredient.resolver';
import { IngredientService } from './ingredient.service';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Ingredient.name, schema: IngredientSchema },
    ]),
  ],
  providers: [IngredientResolver, IngredientService],
})
export class IngredientsModule {}
