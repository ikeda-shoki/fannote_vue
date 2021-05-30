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
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

#form-name {
  width: 30%;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: center;

  label {
    font-weight: bold;

    @include sp {
      font-size: 13px;
    }
  }
}
</style>