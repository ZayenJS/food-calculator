<template>
  <div class="home">
    <AddIngredient @addIngredient="addIngredient" />
    <div class="table">
      <div class="table-caption">
        Ingrédients
      </div>
      <div class="table-content-container">
        <div class="table-header">
          <div class="table-row">
            <div class="table-header-data">ID</div>
            <div class="table-header-data">Nom</div>
            <div class="table-header-data">Calories</div>
            <div class="table-header-data">Protéines</div>
            <div class="table-header-data">Glucides</div>
            <div class="table-header-data">dont sucres</div>
            <div class="table-header-data">Lipides</div>
            <div class="table-header-data">dont saturés</div>
            <div class="table-header-data">sel</div>
          </div>
        </div>
        <div class="table-body">
          <div class="table-row" v-for="ingredient in ingredients" :key="ingredient._id">
            <div class="table-body-data">{{ ingredient._id }}</div>
            <div class="table-body-data">{{ ingredient.name }}</div>
            <div class="table-body-data">{{ ingredient.calories }}</div>
            <div class="table-body-data">{{ ingredient.proteins }}</div>
            <div class="table-body-data">{{ ingredient.carbohydrates }}</div>
            <div class="table-body-data">{{ ingredient.sugars }}</div>
            <div class="table-body-data">{{ ingredient.fats }}</div>
            <div class="table-body-data">{{ ingredient.saturated }}</div>
            <div class="table-body-data">{{ ingredient.salt }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
  import { Options, Vue } from 'vue-class-component';
  import axios from 'axios';
  import AddIngredient from '@/components/AddIngredient.vue';

  @Options({
    components: {
      AddIngredient,
    },
    data: () => ({ ingredients: [] }),

    async created() {
      try {
        const {
          data: { data },
        }: any = await axios.post('http://localhost:8008/graphql', {
          query: `
                {
                  getIngredients {
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
        });

        this.ingredients = data.getIngredients;
      } catch (error) {
        console.trace(error);
      }
    },
    methods: {
      addIngredient(ingredient: any) {
        this.ingredients.push(ingredient);
      },
    },
  })
  export default class Home extends Vue {}
</script>

<style lang="scss" scoped>
  ::-webkit-scrollbar {
    width: 1rem;
  }

  ::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, rgb(88, 42, 141) 0%, rgb(0, 118, 122) 100%);
    border-radius: 20rem;
    transition: all 250ms ease;

    &:hover {
      background: linear-gradient(
        135deg,
        lighten(rgb(88, 42, 141), 15%) 0%,
        lighten(rgb(0, 118, 122), 15%) 100%
      );
    }
  }

  ::-webkit-scrollbar-track {
    background: rgb(107, 94, 151);
  }
  //

  .home {
    min-height: 100vh;
    padding: 2rem;
  }

  .table {
    width: 100%;
    max-width: 17rem + 8 * 10rem;
    margin: auto;
    position: relative;
    border-radius: 8px;
    overflow: hidden;

    &-caption {
      position: sticky;
      top: 0;

      grid-column: 1 / 10;
      text-align: center;
      padding: 1rem;
      font-size: 1.25rem;
      font-weight: bold;
      background-color: rgb(58, 40, 80);
    }

    $first-col: 17rem;

    &-content-container {
      display: grid;
      overflow: auto;
      width: 100%;
      max-height: 20rem;
      grid-template-columns: 17rem repeat(8, 10rem);
    }

    &-header {
      grid-column: 1/10;
      position: sticky;
      top: 0;

      &-data {
        font-weight: bold;
        background-color: rgb(162, 141, 200);
      }
    }

    &-row {
      display: grid;
      grid-template-columns: 17rem repeat(8, 10rem);
    }

    &-header-data,
    &-body-data {
      color: #222;
      text-align: center;
      padding: 1rem 0.25rem;
      color: rgb(255, 255, 255);
      font-size: 1.1rem;
    }

    &-body {
      grid-column: 1/10;
      .table-row {
        &:nth-child(odd) {
          .table-body-data {
            background-color: rgb(148, 114, 192);
          }
        }

        &:nth-child(even) {
          .table-body-data {
            background-color: rgb(162, 141, 200);
          }
        }
      }
    }
  }

  tbody tr {
  }
</style>
