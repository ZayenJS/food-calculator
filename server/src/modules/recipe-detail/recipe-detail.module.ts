import { Module } from '@nestjs/common';
import { RecipeDetailService } from './recipe-detail.service';
import { RecipeDetailResolver } from './recipe-detail.resolver';

@Module({
  providers: [RecipeDetailService, RecipeDetailResolver]
})
export class RecipeDetailModule {}
