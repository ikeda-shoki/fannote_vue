<template>
  <div id="text-form">
    <dt class="form-name">
      <label :for="id">{{ labelName }}</label>
      <span v-show="required" class="require-icon">必須</span>
    </dt>
    <dl class="form-input">
      <input
        :id="id"
        :type="type"
        :name="name"
        :value="value"
        @input="updateValue">
    </dl>
    <p class="input-sub-text">
      <slot>
        例)記入例
      </slot>
    </p>
  </div>
</template>

<script>
export default {
  props: {
    value: { type: String, required: true },
    id: { type: String, required: true },
    type: { type: String, required: true },
    name: { type: String, required: true },
    required: { type: Boolean, required: true },
    labelName: { type: String, required: true },
  },
  methods: {
    updateValue(e) {
      this.$emit("input", e.target.value);
    }
  }
}
</script>

<style lang="scss" scoped>
  #text-form {
    display: flex;
    flex-direction: row;
    align-items: center;
    flex-wrap: wrap;
    width: 100%;

    .form-name {
      width: 30%;
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
      align-items: center;

      label {
        font-weight: bold;
        font-size: 20px;
      }
    }

    .form-input {
      margin-left: auto;
      margin-bottom: 8px;
      width: 65%;

      input {
        width: 100%;
        padding: 5px 10px;
      }
    }

    .input-sub-text {
      font-size: 14px;
      opacity: 0.7;
      width: 63%;
      margin-left: auto;
    }
  }
</style>