import { Field, ObjectType, ID } from '@nestjs/graphql';
import { Schema, Prop, SchemaFactory } from '@nestjs/mongoose';
import { ObjectID } from 'typeorm';
import { Document, Model, Schema as MongooseSchema } from 'mongoose';
import { Category } from './Category';
import { Ingredient } from './Ingredient';

@ObjectType()
@Schema()
export class Food {
  @Field(() => ID)
  public _id: ObjectID;

  @Field(() => String)
  @Prop({ type: String })
  public name: string;

  @Field(() => Category)
  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'Category' })
  public category: Category;

  @Field(() => [Ingredient])
  @Prop({
    type: [
      {
        _id: MongooseSchema.Types.ObjectId,
        quantity: Number,
      },
    ],
    ref: 'Ingredient',
  })
  public ingredients: { _id: Ingredient; quantity: number }[];

  @Field(() => Number)
  @Prop({ type: Number })
  public createdAt: number;

  @Field(() => Number, { nullable: true })
  @Prop({ type: Number, nullable: true })
  public updatedAt: number;
}

export type FoodDocument = Food & Document;
export type FoodModel = Model<FoodDocument>;

export const FoodSchema = SchemaFactory.createForClass(Food);
