import { Field, ID, ObjectType } from '@nestjs/graphql';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Recipe } from './Recipe';

@ObjectType()
@Entity({ name: 'instructions' })
export class Instruction extends BaseEntity {
  @Field(() => ID, { nullable: false })
  @PrimaryGeneratedColumn({ type: 'bigint' })
  public id: number;

  @Field(() => String, { nullable: false })
  @Column({ type: 'text', nullable: false })
  public content: string;

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

  @Field(() => Recipe)
  @JoinColumn({ name: 'recipe_id' })
  @ManyToOne(() => Recipe)
  public recipe: Recipe;
}
