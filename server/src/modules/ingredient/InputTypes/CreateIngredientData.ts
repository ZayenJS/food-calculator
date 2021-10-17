import { Field, Float, InputType } from '@nestjs/graphql';

@InputType()
export class CreateIngredientData {
  @Field(() => String, { nullable: false })
  public name: string;

  @Field(() => Float, { nullable: false })
  public calories: number;

  @Field(() => Float, { nullable: false })
  public proteins: number;

  @Field(() => Float, { nullable: false })
  public carbohydrates: number;

  @Field(() => Float, { nullable: false })
  public sugars: number;

  @Field(() => Float, { nullable: false })
  public fats: number;

  @Field(() => Float, { nullable: false })
  public saturated: number;

  @Field(() => Float, { nullable: false })
  public salt: number;
}
