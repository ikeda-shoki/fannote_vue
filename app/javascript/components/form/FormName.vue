<template>
  <dt id="form-name">
    <label :for="id">{{ labelName }}</label>
    <span v-show="required" class="require-icon">必須</span>
  </dt>
</template>

<script>
export default {
  props: {
    id: { type: String },
    required: { type: Boolean, required: true },
    labelName: { type: String, required: true }
  }
}
</script>

<style lang="scss" scoped>
  #form-name {
    width: 30%;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    align-items: center;

    label {
      font-weight: bold;
    }
  }
</style>