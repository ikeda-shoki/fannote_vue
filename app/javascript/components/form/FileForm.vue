<template>
  <div id="file-form">
    <FormName :id="id" :required="required" :labelName="labelName"></FormName>
    <dt class="form-file">
      <label :for="id" class="button">
        <input :id="id" :name="name" type="file" ref="file" @change="upload" />ファイルを選択
      </label>
    </dt>
    <transition name="fade">
      <div class="preview-image" v-if="image64">
        <slot>
          <p>投稿する画像</p>
          <img :src="image64" alt="投稿した画像" />
        </slot>
        <CloseButton @click.native="previewDelete"></CloseButton>
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
      image64: "",
    };
  },
  props: {
    id: { type: String, required: true },
    name: { type: String, required: true },
    required: { type: Boolean, required: true },
    labelName: { type: String, required: true },
    image: { type: String },
    images: { type: Array },
  },
  methods: {
    upload() {
      let file = event.target.files[0] || event.dataTransfer.files;
      let reader = new FileReader();
      reader.onload = () => {
        this.image64 = event.target.result;
        this.$emit("input", this.image64);
      };
      reader.readAsDataURL(file);
    },
    previewDelete() {
      this.image64 = "";
      this.$refs.file.value = null;
      this.$emit("imageDelete", "");
    },
    postImage() {
      if (this.image) {
        this.image64 = this.image;
      }
    },
  },
  components: {
    FormName,
    CloseButton,
  },
  created() {
    this.postImage();
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
