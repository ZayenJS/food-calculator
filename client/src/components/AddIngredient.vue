<template>
  <h1>Ajouter ingrédient</h1>

  <form @submit.prevent="onFormSubmit">
    <div class="input-group">
      <Input
        :id="'ingredient-name'"
        :name="'name'"
        :error="ingredient.name.error"
        :label="'Nom'"
        :value="ingredient.name.value"
        @inputChange="listenInput"
      />
      <Input
        :id="'ingredient-calories'"
        :name="'calories'"
        :error="ingredient.calories.error"
        :label="'Calories'"
        :value="ingredient.calories.value"
        @inputChange="listenInput"
      />
    </div>
    <div class="input-group">
      <Input
        :id="'ingredient-proteins'"
        :name="'proteins'"
        :error="ingredient.proteins.error"
        :label="'Protéines'"
        :value="ingredient.proteins.value"
        @inputChange="listenInput"
      />
      <Input
        :id="'ingredient-carbohydrates'"
        :name="'carbohydrates'"
        :error="ingredient.carbohydrates.error"
        :label="'Glucides'"
        :value="ingredient.carbohydrates.value"
        @inputChange="listenInput"
      />
    </div>
    <div class="input-group">
      <Input
        :id="'ingredient-sugars'"
        :name="'sugars'"
        :error="ingredient.sugars.error"
        :label="'Sucres'"
        :value="ingredient.sugars.value"
        @inputChange="listenInput"
      />
      <Input
        :id="'ingredient-fats'"
        :name="'fats'"
        :error="ingredient.fats.error"
        :label="'Lipides'"
        :value="ingredient.fats.value"
        @inputChange="listenInput"
      />
    </div>
    <div class="input-group">
      <Input
        :id="'ingredient-saturated'"
        :name="'saturated'"
        :error="ingredient.saturated.error"
        :label="'Gras saturés'"
        :value="ingredient.saturated.value"
        @inputChange="listenInput"
      />
      <Input
        :id="'ingredient-salt'"
        :name="'salt'"
        :error="ingredient.salt.error"
        :label="'Sel'"
        :value="ingredient.salt.value"
        @inputChange="listenInput"
      />
    </div>
    <button>Ajouter l'ingrédient</button>
  </form>
</template>

<script lang="ts">
  import { Options, Vue } from 'vue-class-component';
  import Input from '@/components/Input.vue';
  import axios from 'axios';

  @Options({
    components: { Input },
    props: {
      addIngredient: { type: Function },
    },
    data() {
      return {
        ingredient: {
          name: { value: '', error: '' },
          calories: { value: '', error: '' },
          proteins: { value: '', error: '' },
          carbohydrates: { value: '', error: '' },
          sugars: { value: '', error: '' },
          fats: { value: '', error: '' },
          saturated: { value: '', error: '' },
          salt: { value: '', error: '' },
        },
      };
    },
    emits: ['addIngredient'],
    methods: {
      listenInput({ name, value }: { name: string; value: string }) {
        this.ingredient[name].value = value;

        if (!value) {
          this.ingredient[name].error = 'Ce champs doit être remplis!';
          return;
        }

        this.ingredient[name].error = '';
      },

      async onFormSubmit() {
        let hasError = false;

        for (const key in this.ingredient) {
          if (!this.ingredient[key].value) {
            this.ingredient[key].error = 'Ce champs doit être remplis.';
            hasError = true;
          }
        }

        if (!hasError) {
          const ingredient = {
            name: this.ingredient.name.value,
            calories: +this.ingredient.calories.value,
            proteins: +this.ingredient.proteins.value,
            carbohydrates: +this.ingredient.carbohydrates.value,
            sugars: +this.ingredient.sugars.value,
            fats: +this.ingredient.fats.value,
            saturated: +this.ingredient.saturated.value,
            salt: +this.ingredient.salt.value,
          };

          try {
            const {
              data: { data },
            }: any = await axios.post('http://localhost:8008/graphql', {
              query: `
              mutation($CreateIngredientData: CreateIngredientData!) {
                createIngredient(data: $CreateIngredientData) {
                  _id
                  name
                  calories
                  proteins
                  carbohydrates
                  sugars
                  fats
                  saturated
                  salt
                }
              }`,
              variables: {
                CreateIngredientData: ingredient,
              },
            });

            this.$emit('addIngredient', data.createIngredient);

            for (const key in this.ingredient) {
              this.ingredient[key].value = '';
            }
          } catch (error) {
            console.log({ error });
          }
        }
      },
    },
  })
  export default class AddIngredient extends Vue {}
</script>

<style lang="scss" scoped>
  h1 {
    text-align: center;
  }

  form {
    display: flex;
    flex-flow: column nowrap;
    max-width: 600px;
    width: 90%;
    gap: 2rem;
    margin: 4rem auto;
  }

  button {
    padding: 0.25rem 1rem;
    font-size: 1.25rem;
    border-radius: 8px;
    border: 2px solid transparent;
    cursor: pointer;
    transition: all 250ms ease;

    &:hover {
      background-color: rgb(63, 17, 148);
      color: #fff;
    }
  }

  .input-group {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 2rem;
  }
</style>
