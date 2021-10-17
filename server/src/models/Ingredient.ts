import { Field, ObjectType, Float, ID } from '@nestjs/graphql';
import { Schema, Prop, SchemaFactory } from '@nestjs/mongoose';
import { ObjectID } from 'typeorm';
import { Document, Model, Schema as MongooseSchema } from 'mongoose';
import { Food } from './Food';

@ObjectType()
@Schema()
export class Ingredient {
  @Field(() => ID)
  public _id: ObjectID;

  @Field(() => String)
  @Prop({ type: String })
  public name: string;

  @Field(() => Float)
  @Prop({ type: Number })
  public calories: number;

  @Field(() => Float)
  @Prop({ type: Number })
  public proteins: number;

  @Field(() => Float)
  @Prop({ type: Number })
  public carbohydrates: number;

  @Field(() => Float)
  @Prop({ type: Number })
  public sugars: number;

  @Field(() => Float)
  @Prop({ type: Number })
  public fats: number;

  @Field(() => Float)
  @Prop({ type: Number })
  public saturated: number;

  @Field(() => Float)
  @Prop({ type: Number })
  public salt: number;

  @Field(() => [Food])
  @Prop({
    type: [
      {
        _id: MongooseSchema.Types.ObjectId,
      },
    ],
    ref: 'Food',
  })
  public foods: Food[];

  @Field(() => Number)
  @Prop({ type: Number })
  public createdAt: number;

  @Field(() => Number, { nullable: true })
  @Prop({ type: Number, nullable: true })
  public updatedAt: number;
}

export type IngredientDocument = Ingredient & Document;
export type IngredientModel = Model<IngredientDocument>;

export const IngredientSchema = SchemaFactory.createForClass(Ingredient);
