import { Resolver, Query } from '@nestjs/graphql';
import { Ingredient } from 'src/models/Ingredient';
import { AppService } from './app.service';

@Resolver()
export class AppResolver {
  constructor(private readonly appService: AppService) {}

  @Query(() => Ingredient)
  hello() {
    return this.appService.getHello();
  }
}
