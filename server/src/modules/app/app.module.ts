import * as path from 'path';
import { Module } from '@nestjs/common';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GraphQLModule } from '@nestjs/graphql';
import { ServeStaticModule } from '@nestjs/serve-static';
import { Context } from 'src/classes/Context';
import { entities } from '../../models';
import { AppResolver } from './app.resolver';
import { IngredientsModule } from '../ingredient/ingredient.module';
import { CategoryModule } from '../category/category.module';
import { RecipeModule } from '../recipe/recipe.module';

@Module({
  imports: [
    IngredientsModule,
    CategoryModule,
    RecipeModule,
    TypeOrmModule.forRoot({
      type: 'postgres',
      url: process.env.PG_URI,
      applicationName: 'dish-calculator',
      synchronize: false,
      // dropSchema: true,
      logging: true,
      entities,
    }),
    GraphQLModule.forRoot({
      autoSchemaFile: path.join(process.cwd(), 'src/schema.gql'),
      cors: {
        credentials: true,
        origin: [
          process.env.CLIENT_URL,
          'https://studio.apollographql.com',
          '*',
        ],
      },
      playground: true,
      context: ({ req, res }: Context) => ({ req, res }),
    }),
    ServeStaticModule.forRoot({
      rootPath: path.join(__dirname, '..', '..', 'public'),
    }),
  ],
  controllers: [],
  providers: [AppService, AppResolver],
})
export class AppModule {}
