import { Field, Float, ID, InputType } from '@nestjs/graphql';

@InputType()
export class EditIngredientData {
  @Field(() => ID, { nullable: false })
  public _id: string;

  @Field(() => String, { nullable: true })
  public name?: string;

  @Field(() => Float, { nullable: true })
  public calories?: number;

  @Field(() => Float, { nullable: true })
  public proteins?: number;

  @Field(() => Float, { nullable: true })
  public carbohydrates?: number;

  @Field(() => Float, { nullable: true })
  public sugars?: number;

  @Field(() => Float, { nullable: true })
  public fats?: number;

  @Field(() => Float, { nullable: true })
  public saturated?: number;

  @Field(() => Float, { nullable: true })
  public salt?: number;
}
