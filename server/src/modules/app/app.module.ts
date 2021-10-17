import * as path from 'path';
import { Module } from '@nestjs/common';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GraphQLModule } from '@nestjs/graphql';
import { ServeStaticModule } from '@nestjs/serve-static';
import { Context } from 'src/classes/Context';
import { entities } from '../../models';
import { AppResolver } from './app.resolver';
import { Ingredient, IngredientSchema } from 'src/models/Ingredient';
import { Category, CategorySchema } from 'src/models/Category';
import { Food, FoodSchema } from 'src/models/Food';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Ingredient.name, schema: IngredientSchema },
      { name: Category.name, schema: CategorySchema },
      { name: Food.name, schema: FoodSchema },
    ]),
    MongooseModule.forRoot(process.env.MONGO_URI),
    TypeOrmModule.forRoot({
      name: 'default',
      type: 'mongodb',
      url: process.env.MONGO_URI,
      appname: 'the-tavern',
      synchronize: true,
      logging: true,
      entities,
    }),
    GraphQLModule.forRoot({
      autoSchemaFile: path.join(process.cwd(), 'src/schema.gql'),
      cors: {
        credentials: true,
        origin: ['http://localhost:8009', 'https://studio.apollographql.com'],
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
