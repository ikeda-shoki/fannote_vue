<template>
  <div id="file-form">
    <dt class="form-name">
      <label :for="id">{{ labelName }}</label>
      <span v-show="required" class="require-icon">必須</span>
    </dt>
    <dt class="form-file">
      <input :id="id" :name="name" type="file" ref="file" @change="upload" />
    </dt>
    <img :src="image64">
  </div>
</template>

<script>
export default {
  data() {
    return {
      image64: "",
    };
  },
  props: {
    id: { type: String, required: true },
    name: { type: String, required: true },
    required: { type: Boolean, required: true },
    labelName: { type: String, required: true },
  },
  methods: {
    upload() {
      let file = event.target.files[0] || event.dataTransfer.files;
      let reader = new FileReader();
      reader.onload = () => {
        this.image64 = event.target.result;
        this.$emit('input', this.image64);
      };
      reader.readAsDataURL(file);
    },
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$danger-color: #e15253;

#file-form {
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

  .form-file {
    margin-left: auto;
    margin-bottom: 8px;
    width: 65%;
  }
}
</style>