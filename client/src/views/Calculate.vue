<template>
  <Input
    :id="'search-input'"
    :label="'Rechercher'"
    :name="'searchInput'"
    :value="searchInput.value"
    @inputChange="search"
  />
  <ul class="search-results" v-if="searchInput.value && foundIngredients.length">
    <li
      @click="selectIngredient(ingredient)"
      v-for="ingredient in foundIngredients"
      :key="ingredient._id"
    >
      {{ ingredient.name }}
    </li>
  </ul>
  <ul
    class="search-results"
    v-else-if="searchInput.value && !foundIngredients.length && !searching"
  >
    <li>Pas de resultats</li>
  </ul>

  <div class="table" v-if="selectedIngredients.length">
    <div class="table-caption">
      Ingrédients selectionnés
    </div>
    <div class="table-header">
      <div class="table-row">
        <div class="table-header-data">Nom</div>
        <div class="table-header-data">Calories</div>
        <div class="table-header-data">Protéines</div>
        <div class="table-header-data">Glucides</div>
        <div class="table-header-data">dont sucres</div>
        <div class="table-header-data">Lipides</div>
        <div class="table-header-data">dont saturés</div>
        <div class="table-header-data">sel</div>
        <div class="table-header-data">Quantité (en grammes)</div>
      </div>
      <div class="table-body">
        <div
          class="table-row"
          v-for="selectedIngredient in selectedIngredients"
          :key="selectedIngredient._id"
        >
          <div class="table-body-data">{{ selectedIngredient.name }}</div>
          <div class="table-body-data">{{ selectedIngredient.calories }}</div>
          <div class="table-body-data">{{ selectedIngredient.proteins }}</div>
          <div class="table-body-data">{{ selectedIngredient.carbohydrates }}</div>
          <div class="table-body-data">{{ selectedIngredient.sugars }}</div>
          <div class="table-body-data">{{ selectedIngredient.fats }}</div>
          <div class="table-body-data">{{ selectedIngredient.saturated }}</div>
          <div class="table-body-data">{{ selectedIngredient.salt }}</div>
          <div class="table-body-data">
            <Input
              :name="selectedIngredient._id"
              :value="selectedIngredient.quantity"
              @inputChange="changeIngredientQuantity"
            />
          </div>
        </div>
      </div>
      <div class="table-footer">
        <div class="table-row">
          <div class="table-body-data">Total</div>
          <div class="table-body-data">{{ caloriesTotal }}</div>
          <div class="table-body-data">{{ proteinsTotal }}</div>
          <div class="table-body-data">{{ carbohydratesTotal }}</div>
          <div class="table-body-data">{{ sugarsTotal }}</div>
          <div class="table-body-data">{{ fatsTotal }}</div>
          <div class="table-body-data">{{ saturatedTotal }}</div>
          <div class="table-body-data">{{ saltTotal }}</div>
          <div class="table-body-data">{{ quantityTotal }}</div>
        </div>
        <div class="table-row">
          <div class="table-body-data">Total (100 grammes)</div>
          <div class="table-body-data">{{ calories100 }}</div>
          <div class="table-body-data">{{ proteins100 }}</div>
          <div class="table-body-data">{{ carbohydrates100 }}</div>
          <div class="table-body-data">{{ sugars100 }}</div>
          <div class="table-body-data">{{ fats100 }}</div>
          <div class="table-body-data">{{ saturated100 }}</div>
          <div class="table-body-data">{{ salt100 }}</div>
          <div class="table-body-data">100</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
  import { Options, Vue } from 'vue-class-component';
  import axios from '@/util/axios';

  import Input from '@/components/Input.vue';

  @Options({
    components: {
      Input,
    },

    data: () => ({
      searchInput: {
        error: '',
        value: '',
      },
      searching: false,
      foundIngredients: [],
      selectedIngredients: [],
    }),
    computed: {
      caloriesTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.calories * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },
      proteinsTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.proteins * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },
      carbohydratesTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.carbohydrates * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },
      sugarsTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.sugars * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },
      fatsTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.fats * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },
      saturatedTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.saturated * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },
      saltTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.salt * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },
      quantityTotal() {
        return this.selectedIngredients
          .map(
            (selectedIngredient: any) =>
              +selectedIngredient.quantity * (+selectedIngredient.quantity / 100),
          )
          .reduce((prevValue: number, currentValue: number) => prevValue + currentValue)
          .toFixed(2);
      },

      calories100() {
        return +(this.caloriesTotal / (this.quantityTotal / 100)).toFixed(2);
      },
      proteins100() {
        return +(this.proteinsTotal / (this.quantityTotal / 100)).toFixed(2);
      },
      carbohydrates100() {
        return +(this.carbohydratesTotal / (this.quantityTotal / 100)).toFixed(2);
      },
      sugars100() {
        return +(this.sugarsTotal / (this.quantityTotal / 100)).toFixed(2);
      },
      fats100() {
        return +(this.fatsTotal / (this.quantityTotal / 100)).toFixed(2);
      },
      saturated100() {
        return +(this.saturatedTotal / (this.quantityTotal / 100)).toFixed(2);
      },
      salt100() {
        return +(this.saltTotal / (this.quantityTotal / 100)).toFixed(2);
      },
    },

    methods: {
      selectIngredient(ingredient: any) {
        this.selectedIngredients.push({ ...ingredient, quantity: '100' });
        this.foundIngredients = this.foundIngredients.filter(
          (foundIngredient: any) => foundIngredient._id !== ingredient._id,
        );
        this.searchInput.value = '';
      },
      changeIngredientQuantity({ name, value }: any) {
        const index = this.selectedIngredients.findIndex((el: any) => el._id === name);
        this.selectedIngredients[index].quantity = value;
      },
      async search({ name, value }: { name: string; value: string }) {
        this.searching = true;

        this[name].value = value;

        if (!value) {
          this.foundIngredients = [];
          return;
        }

        try {
          const {
            data: { data },
          }: any = await axios.post('/graphql', {
            query: `
            query FindIngredientsByName($name: String!) {
              findIngredientsByName(name: $name) {
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
            }
            `,
            variables: {
              name: this[name].value,
            },
          });

          const foundIngredients = [];

          for (const foundIngredient of data.findIngredientsByName) {
            if (
              !this.selectedIngredients.map((ingr: any) => ingr._id).includes(foundIngredient._id)
            ) {
              foundIngredients.push(foundIngredient);
            }
          }

          this.foundIngredients = foundIngredients;
          this.searching = false;
        } catch (error) {
          console.trace(error);
        }
      },
    },
  })
  export default class Calculate extends Vue {}
</script>

<style lang="scss">
  @import '../assets/scss/partials/_variables.scss';

  .search-results {
    background-color: $main-color;
    color: #fff;
    height: 11rem;
    overflow: hidden auto;

    li {
      cursor: pointer;
      margin: 0.5em;
      padding: 1rem;
      background-color: $secondary-color;
      border-radius: 8px;
      transition: all 750ms ease;

      &:hover,
      &:active {
        background-color: lighten($secondary-color, 5%);
        transition: all 250ms ease;
      }
    }
  }
</style>
