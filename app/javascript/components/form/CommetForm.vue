<template>
  <div id="comment-form">
    <input
      :id="id"
      :type="type"
      :name="name"
      :value="value"
      :placeholder="placeholder"
      @input="updateValue">
  </div>
</template>

<script>

export default {
  props: {
    value: { type: String, required: true },
    id: { type: String, required: true },
    type: { type: String, required: true },
    name: { type: String, required: true },
    placeholder: { type: String }
  },
  methods: {
    updateValue(e) {
      this.$emit("input", e.target.value);
    }
  },
}
</script>

<style lang="scss" scoped>
  #comment-form {
    width: 100%;

    input {
      width: 100%;
      padding: 5px 10px;
    }
  }
</style>