import { Field, ObjectType, ID } from '@nestjs/graphql';
import { Schema, Prop, SchemaFactory } from '@nestjs/mongoose';
import { ObjectID } from 'typeorm';
import { Document, Model, Schema as MongooseSchema } from 'mongoose';
import { Food } from './Food';

@ObjectType()
@Schema()
export class Category {
  @Field(() => ID)
  public _id: ObjectID;

  @Field(() => String)
  @Prop({ type: String })
  public name: string;

  @Field(() => [Food])
  @Prop({ type: [{ type: MongooseSchema.Types.ObjectId }], ref: 'Food' })
  public foods: Food[];

  @Field(() => Number)
  @Prop({ type: Number })
  public createdAt: number;

  @Field(() => Number, { nullable: true })
  @Prop({ type: Number, nullable: true })
  public updatedAt: number;
}

export type CategoryDocument = Category & Document;
export type CategoryModel = Model<CategoryDocument>;

export const CategorySchema = SchemaFactory.createForClass(Category);
