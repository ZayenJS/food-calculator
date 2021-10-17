import { Field, ObjectType } from '@nestjs/graphql';
import { Error } from 'src/@types/Error';
import { Ingredient } from 'src/models/Ingredient';

@ObjectType()
export class IngredientResponse {
  @Field(() => [Error], { nullable: true })
  errors?: Error[];

  @Field(() => Ingredient, { nullable: true })
  ingredient?: Ingredient | null = null;
}
