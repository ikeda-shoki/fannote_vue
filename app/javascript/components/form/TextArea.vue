<template>
  <div id="textarea-form">
    <FormName :required="required" :labelName="labelName"></FormName>
    <dl class="form-textarea">
      <textarea
        :id="id"
        :type="type"
        :name="name"
        :value="value"
        ref="textarea"
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
import FormName from "./FormName.vue"

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
  components: {
    FormName,
  }
};
</script>

<style lang="scss" scoped>
#textarea-form {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  flex-wrap: wrap;
  width: 100%;

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