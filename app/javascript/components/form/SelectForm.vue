<template>
  <div id="select-form">
    <label>
      <select :name="name" @change="updateValue">
        <template v-for="option in options">
          <option
            :value="option.value"
            :key="option.label"
            :selected="option.value === checkedValue"
          >
            {{ option.label }}
          </option>
        </template>
      </select>
    </label>
  </div>
</template>

<script>
export default {
  props: {
    value: { type: String, required: true },
    options: { type: Array, required: true },
    name: { type: String, required: true },
    checkedValue: {},
  },
  methods: {
    updateValue: function(e) {
      this.$emit("input", e.target.value);
    },
  },
  mounted() {
    this.$emit("input", this.options[0].value);
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

label {
  box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
  padding: 15px;
  background: #fffffe;
  width: 260px;
  display: inline-block;
  position: relative;
  margin-left: 50px;

  &:after {
    content: "\25bc";
    font-size: 16px;
    color: #fffffe;
    background: $accent-color;
    width: 42px;
    text-align: center;
    line-height: 3.2em;
    top: 0;
    right: 0;
    bottom: 0;
    position: absolute;
    pointer-events: none;
  }

  select {
    border: none;
    outline: none;
    display: inline-block;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    cursor: pointer;
    font-size: 16px;
    color: $font-color;
    border-radius: 0;
    width: 275px;
    z-index: 2;
    background: transparent;
  }
}
</style>
