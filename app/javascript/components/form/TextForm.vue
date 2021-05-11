<template>
  <div id="text-form">
    <FormName :required="required" :labelName="labelName"></FormName>
    <dl class="form-input">
      <input
        :id="id"
        :type="type"
        :name="name"
        :value="value"
        ref="text"
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
import FormName from "./FormName.vue"

export default {
  props: {
    value: { required: true },
    id: { type: String, required: true },
    type: { type: String, required: true },
    name: { type: String, required: true },
    required: { type: Boolean, required: true },
    labelName: { type: String, required: true },
  },
  methods: {
    updateValue(e) {
      this.$emit("input", e.target.value);
    },
  },
  components: {
    FormName,
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