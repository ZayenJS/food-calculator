import { Field, ObjectType, Float, ID } from '@nestjs/graphql';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  JoinTable,
  ManyToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

import { Recipe } from './Recipe';

@ObjectType()
@Entity({ name: 'ingredients' })
export class Ingredient extends BaseEntity {
  @Field(() => ID)
  @PrimaryGeneratedColumn({ type: 'bigint' })
  public id: number;

  @Field(() => String, { nullable: false })
  @Column({ type: 'varchar', length: 100, nullable: false })
  public name: string;

  @Field(() => Float, { nullable: false })
  @Column({ type: 'double precision', nullable: false })
  public calories: number;

  @Field(() => Float, { nullable: false })
  @Column({ type: 'double precision', nullable: false })
  public proteins: number;

  @Field(() => Float, { nullable: false })
  @Column({ type: 'double precision', nullable: false })
  public carbohydrates: number;

  @Field(() => Float, { nullable: false })
  @Column({ type: 'double precision', nullable: false })
  public sugars: number;

  @Field(() => Float, { nullable: false })
  @Column({ type: 'double precision', nullable: false })
  public fats: number;

  @Field(() => Float, { nullable: false })
  @Column({ type: 'double precision', nullable: false })
  public saturated: number;

  @Field(() => Float, { nullable: false })
  @Column({ type: 'double precision', nullable: false })
  public salt: number;

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

  @Field(() => [Recipe])
  @ManyToMany(() => Recipe, { onDelete: 'CASCADE', onUpdate: 'CASCADE' })
  @JoinTable({
    name: 'recipe_details',
    joinColumn: { name: 'ingredient_id', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'recipe_id', referencedColumnName: 'id' },
  })
  public recipes: Recipe[];
}
