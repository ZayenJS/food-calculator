import { Field, Int, ObjectType } from '@nestjs/graphql';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryColumn,
  UpdateDateColumn,
} from 'typeorm';

@ObjectType()
@Entity({ name: 'recipe_details' })
export class RecipeDetail extends BaseEntity {
  @Field(() => Int, { nullable: false })
  @PrimaryColumn({
    type: 'bigint',
    name: 'ingredient_id',
    nullable: false,
    generated: false,
  })
  public ingredientId: number;

  @Field(() => Int, { nullable: false })
  @PrimaryColumn({
    type: 'bigint',
    name: 'recipe_id',
    nullable: false,
    generated: false,
  })
  public recipeId: number;

  @Field(() => Int, { nullable: false })
  @Column({ type: 'int', nullable: false })
  public quantity: number;

  @Field(() => Number)
  @CreateDateColumn({
    type: 'timestamp with time zone',
    name: 'created_at',
  })
  public createdAt: number;

  @Field(() => Number, { nullable: true })
  @UpdateDateColumn({
    type: 'timestamp with time zone',
    nullable: true,
    name: 'updated_at',
  })
  public updatedAt: number;
}
