<template>
  <div id="radio-button">
    <dt class="form-name">
      <label>{{ labelName }}</label>
      <span v-show="required" class="require-icon">必須</span>
    </dt>
    <dt class="form-radio-button">
      <template v-for="(option, index) in options">
        <label :key="index">
          <input
            type="radio"
            :name="name"
            :value="option.value"
            @change="updateValue"
          />
          <span>{{ option.label }}</span>
        </label>
      </template>
    </dt>
  </div>
</template>

<script>
export default {
  props: {
    value: { type: String, required: true },
    options: { type: Array, required: true },
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
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$danger-color: #E15253;

#radio-button {
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

  .form-radio-button {
    margin-left: auto;
    margin-bottom: 8px;
    width: 65%;
    display: flex;
    flex-direction: column;

    label {
      margin-bottom: 8px;

      input {
        display: none;

        &:checked+span {
          border-radius: 5px;
          color: $back-ground-color;
          background-color: $accent-color;

          &::after {
            content: "";
            display: block;
            border-radius: 50%;
            width: 10px;
            height: 10px;
            background-color: #411f10;
            position: absolute;
            left: 13px;
          }
        }
      }

      span {
        position: relative;
        display: flex;
        align-items: center;
        padding: 5px 10px;

        &::before {
          content: "";
          display: block;
          border-radius: 50%;
          border: 1px solid #411f10;
          margin-right: 8px;
          width: 16px;
          height: 16px;
        }
      }
    }
  }
}
</style>