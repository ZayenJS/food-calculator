import { Field, ObjectType, ID } from '@nestjs/graphql';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@ObjectType()
@Entity({ name: 'categories' })
export class Category extends BaseEntity {
  @Field(() => ID, { nullable: false })
  @PrimaryGeneratedColumn({ type: 'bigint' })
  public id: number;

  @Field(() => String, { nullable: false })
  @Column({ type: 'varchar', length: 100, nullable: false })
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
}
