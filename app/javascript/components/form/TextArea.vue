<template>
  <div id="textarea-form">
    <dt class="form-name">
      <label :for="id">{{ labelName }}</label>
      <span v-show="required" class="require-icon">必須</span>
    </dt>
    <dl class="form-textarea">
      <textarea
        :id="id"
        :type="type"
        :name="name"
        :value="value"
        @input="updateValue"
      >
      </textarea>
    </dl>
    <p class="textarea-sub-text">
      <slot> 例)記入例 </slot>
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
    },
  },
};
</script>

<style lang="scss" scoped>
#textarea-form {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
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

  .form-textarea {
    margin-left: auto;
    margin-bottom: 8px;
    width: 65%;

    textarea {
      width: 100%;
      height: 200px;
      padding: 5px 10px;
    }
  }

  .textarea-sub-text {
    font-size: 14px;
    opacity: 0.7;
    width: 63%;
    margin-left: auto;
  }
}
</style>