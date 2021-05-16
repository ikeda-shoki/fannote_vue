<template>
  <div id="file-form">
    <FormName :id="id" :required="required" :labelName="labelName"></FormName>
    <dt class="form-file">
      <label :for="id" class="button">
        <input
          :id="id"
          :name="name"
          type="file"
          ref="file"
          @change="fileUpload"
          multiple="true"
        />ファイルを選択
      </label>
    </dt>
    <transition
      name="fade-list"
      v-for="(image64, index) in image64s"
      :key="image64.id"
    >
      <div class="preview-image" key="image64">
        <p>送信する画像</p>
        <img :src="image64" alt="送信する画像" />
        <CloseButton @click.native="previewDelete(index)"></CloseButton>
      </div>
    </transition>
  </div>
</template>

<script>
import FormName from "./FormName.vue";
import CloseButton from "../parts/CloseButton.vue";

export default {
  data() {
    return {
      image64s: [],
    };
  },
  props: {
    id: { type: String, required: true },
    name: { type: String, required: true },
    required: { type: Boolean, required: true },
    labelName: { type: String, required: true },
    images: { type: Array },
    requesImagesCount: { type: Number, required: true },
  },
  methods: {
    async upload() {
      let fileList = event.target.files || event.dataTransfer.files;
      if (fileList === 0) {
        return;
      }
      for (var i = 0; i < fileList.length; i++) {
        let file = fileList[i];
        let reader = new FileReader();
        await (reader.onload = () => {
          this.image64s.push(event.target.result);
        });
        reader.readAsDataURL(file);
      }
    },
    async fileUpload() {
      await this.upload();
      this.$emit("input", this.image64s);
    },
    previewDelete(index) {
      this.image64s.splice(index, 1);
      this.$emit("imageDelete", this.image64s);
    },
    postImages() {
      if (this.images.length) {
        this.image64s = this.images;
      }
    },
  },
  components: {
    FormName,
    CloseButton,
  },
  created() {
    this.postImages();
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
  align-items: center;
  flex-wrap: wrap;
  width: 100%;

  .form-file {
    margin-left: auto;
    margin-bottom: 8px;
    width: 65%;

    .button {
      min-width: auto;
      font-size: 13px;
      padding: 10px 20px;

      input {
        display: none;
      }
    }
  }

  .preview-image {
    width: 65%;
    margin-top: 20px;
    margin-left: auto;
    position: relative;

    p {
      font-size: 14px;
      opacity: 0.7;
      text-align: center;
      margin-bottom: 5px;
    }

    img {
      width: 100%;
      height: auto;
    }

    #close-button {
      position: absolute;
      top: 15px;
      right: -15px;
    }
  }
}
</style>
