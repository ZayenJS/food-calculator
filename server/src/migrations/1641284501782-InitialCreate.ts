import { MigrationInterface, QueryRunner } from 'typeorm';

export class InitialCreate1641284501782 implements MigrationInterface {
  name = 'InitialCreate1641284501782';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "categories" ("id" BIGSERIAL NOT NULL, "name" character varying(100) NOT NULL, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "PK_24dbc6126a28ff948da33e97d3b" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "instructions" ("id" BIGSERIAL NOT NULL, "content" text NOT NULL, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), "recipe_id" bigint, CONSTRAINT "PK_1695991f6159e4ae33b136a67ef" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "recipes" ("id" BIGSERIAL NOT NULL, "name" character varying(255) NOT NULL, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "PK_8f09680a51bf3669c1598a21682" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "ingredients" ("id" BIGSERIAL NOT NULL, "name" character varying(110) NOT NULL, "calories" double precision NOT NULL, "proteins" double precision NOT NULL, "carbohydrates" double precision NOT NULL, "sugars" double precision NOT NULL, "fats" double precision NOT NULL, "saturated" double precision NOT NULL, "fibers" double precision NOT NULL, "salt" double precision NOT NULL, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "UQ_a955029b22ff66ae9fef2e161f8" UNIQUE ("name"), CONSTRAINT "PK_9240185c8a5507251c9f15e0649" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "recipe_details" ("ingredient_id" bigint NOT NULL, "recipe_id" bigint NOT NULL, "quantity" integer NOT NULL, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "PK_70cdbd9824fcf419a46f755547c" PRIMARY KEY ("ingredient_id", "recipe_id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "recipe_category" ("recipe_id" bigint NOT NULL, "category_id" bigint NOT NULL, CONSTRAINT "PK_c4f7da99f60a0932883bfb46410" PRIMARY KEY ("recipe_id", "category_id"))`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_494efbd76164060ab9e624fb6e" ON "recipe_category" ("recipe_id") `,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_9f683b1e651da3285cba27aa68" ON "recipe_category" ("category_id") `,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP COLUMN "quantity"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP COLUMN "created_at"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP COLUMN "updated_at"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD "quantity" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now()`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_6f38b890666f33f47b437e1fa8" ON "recipe_details" ("ingredient_id") `,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_1e00ac60e8d8e6dc65e584bdf1" ON "recipe_details" ("recipe_id") `,
    );
    await queryRunner.query(
      `ALTER TABLE "instructions" ADD CONSTRAINT "FK_750397a709f19a4fadbdca7ee7b" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_category" ADD CONSTRAINT "FK_494efbd76164060ab9e624fb6ee" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_category" ADD CONSTRAINT "FK_9f683b1e651da3285cba27aa687" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD CONSTRAINT "FK_6f38b890666f33f47b437e1fa85" FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD CONSTRAINT "FK_1e00ac60e8d8e6dc65e584bdf11" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP CONSTRAINT "FK_1e00ac60e8d8e6dc65e584bdf11"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP CONSTRAINT "FK_6f38b890666f33f47b437e1fa85"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_category" DROP CONSTRAINT "FK_9f683b1e651da3285cba27aa687"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_category" DROP CONSTRAINT "FK_494efbd76164060ab9e624fb6ee"`,
    );
    await queryRunner.query(
      `ALTER TABLE "instructions" DROP CONSTRAINT "FK_750397a709f19a4fadbdca7ee7b"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_1e00ac60e8d8e6dc65e584bdf1"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_6f38b890666f33f47b437e1fa8"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP COLUMN "updated_at"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP COLUMN "created_at"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" DROP COLUMN "quantity"`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "recipe_details" ADD "quantity" integer NOT NULL`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_9f683b1e651da3285cba27aa68"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_494efbd76164060ab9e624fb6e"`,
    );
    await queryRunner.query(`DROP TABLE "recipe_category"`);
    await queryRunner.query(`DROP TABLE "recipe_details"`);
    await queryRunner.query(`DROP TABLE "ingredients"`);
    await queryRunner.query(`DROP TABLE "recipes"`);
    await queryRunner.query(`DROP TABLE "instructions"`);
    await queryRunner.query(`DROP TABLE "categories"`);
  }
}
