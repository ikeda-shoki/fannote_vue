<template>
  <div id="radio-button">
    <FormName :required="required" :labelName="labelName"></FormName>
    <dt class="form-radio-button">
      <template v-for="(option, index) in options">
        <label :key="index">
          <input
            type="radio"
            :name="name"
            :value="option.value"
            :checked="option.value === checkedValue"
            ref="radio-button"
            @change="updateValue"
          />
          <span>{{ option.label }}</span>
        </label>
      </template>
    </dt>
  </div>
</template>

<script>
import FormName from "./FormName.vue";

export default {
  props: {
    options: { type: Array, required: true },
    name: { type: String, required: true },
    required: { type: Boolean, required: true },
    labelName: { type: String, required: true },
    checkedValue: {},
  },
  methods: {
    updateValue(e) {
      this.$emit("input", e.target.value);
    },
  },
  components: {
    FormName,
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$danger-color: #e15253;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

#radio-button {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  flex-wrap: wrap;
  width: 100%;

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

        &:checked + span {
          border-radius: 5px;
          color: $back-ground-color;
          background-color: $accent-color;

          &::before {
            background-color: $back-ground-color;
            border: none;
          }

          &::after {
            content: "";
            display: block;
            border-radius: 50%;
            width: 10px;
            height: 10px;
            background-color: $accent-color;
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
        background: #d4d0cc;
        border-radius: 5px;
        width: 50%;

        @include sp {
          width: 80%;
        }

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
