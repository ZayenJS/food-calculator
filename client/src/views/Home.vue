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
          <div class="table-row" v-for="ingredient in ingredients" :key="ingredient.id">
            <div class="table-body-data">{{ ingredient.id }}</div>
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
  import axios from '@/util/axios';
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
        }: any = await axios.post('/graphql', {
          query: `
                {
                  getIngredients {
                    id
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
  @import '@/assets/scss/partials/_variables.scss';

  ::-webkit-scrollbar {
    width: 1rem;
  }

  ::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, $main-color 0%, $secondary-color 100%);
    border-radius: 20rem;
    transition: all 250ms ease;

    &:hover {
      background: linear-gradient(
        135deg,
        lighten($main-color, 15%) 0%,
        lighten($secondary-color, 15%) 100%
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
</style>
