import * as path from 'path';
import * as fs from 'fs';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './modules/app/app.module';
import { TypeormStore } from 'connect-typeorm/out';
import * as morgan from 'morgan';
import * as session from 'express-session';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const store = new TypeormStore({
    cleanupLimit: 2,
    ttl: 86400,
  });

  const accessLogStream = fs.createWriteStream(
    path.join(__dirname, '..', 'access.log'),
    { flags: 'a' },
  );

  app.use(
    morgan(
      ':date[web] - method::method - url::url - status::status - response time:response-time ms - response size::res[content-length] - user agent::user-agent',
      {
        stream: accessLogStream,
      },
    ),
  );

  app.use(
    session({
      name: 'the-tavern-sid',
      cookie: {
        httpOnly: true,
        maxAge: 1000 * 60 * 60 * 24 * 365,
        secure: false,
      },
      resave: true,
      saveUninitialized: true,
      // store: store.connect(sessionRepo),
      secret: process.env.SESSION_SECRET ?? 'dev',
    }),
  );

  await app.listen(3000);
}
bootstrap();
