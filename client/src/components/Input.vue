<template>
  <div>
    <label :for="id">{{ label }}</label>
    <input :id="id" type="text" :value="value" @input="inputChange" />
    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>

<script lang="ts">
  import { Options, Vue } from 'vue-class-component';

  @Options({
    props: {
      id: String,
      label: String,
      error: String,
      name: String,
      value: String,
    },
    methods: {
      inputChange(event: any) {
        this.$emit('inputChange', { name: this.name, value: event.target.value });
      },
    },
  })
  export default class AddIngredient extends Vue {}
</script>

<style lang="scss" scoped>
  div {
    display: flex;
    align-items: flex-start;
    flex-flow: column nowrap;
    gap: 0.25rem;
    width: 100%;
  }

  label {
    font-weight: bold;
    font-size: 1.25rem;
  }

  input {
    padding: 0.5rem 1rem;
    border: 2px solid transparent;
    border-radius: 8px;
    width: inherit;
    font-size: 1.25rem;
    transition: all 250ms ease;
  }

  .error {
    color: red;
  }
</style>
