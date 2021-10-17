import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class Error {
  @Field({ nullable: true })
  field?: string;

  @Field({ nullable: true })
  type?: string;

  @Field()
  message!: string;
}
