import { Field, ID, ObjectType } from '@nestjs/graphql';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  JoinTable,
  ManyToMany,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Category } from './Category';
import { Ingredient } from './Ingredient';
import { Instruction } from './Instruction';

@ObjectType()
@Entity({ name: 'recipes' })
export class Recipe extends BaseEntity {
  @Field(() => ID, { nullable: false })
  @PrimaryGeneratedColumn({ type: 'bigint' })
  public id: number;

  @Field(() => String, { nullable: false })
  @Column({ type: 'varchar', length: 255, nullable: false })
  public name: string;

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

  @Field(() => [Ingredient])
  @ManyToMany(() => Ingredient, { onDelete: 'CASCADE', onUpdate: 'CASCADE' })
  public ingredients: Ingredient[];

  @Field(() => [Category])
  @JoinTable({
    name: 'recipe_category',
    joinColumn: { name: 'recipe_id', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'category_id', referencedColumnName: 'id' },
  })
  @ManyToMany(() => Category, { onDelete: 'CASCADE', onUpdate: 'CASCADE' })
  public categories: Category[];

  @Field(() => [Instruction])
  @OneToMany(() => Instruction, (instruction) => instruction.recipe)
  public instructions: Instruction[];
}
