<template>
  <form id="post-image-modal" v-on:submit.prevent="postPostImage">
    <div class="form-item">
      <TextForm
        v-model="title"
        id="post-image-title"
        type="text"
        name="post-image-title"
        :required="true"
        labelName="タイトル"
      >
        例)鋼の錬金術師 エドワードエルリック
      </TextForm>
    </div>
    <div class="form-item">
      <TextArea
        v-model="imageIntroduction"
        id="post-image-introduction"
        type="text"
        name="post-image-introduction"
        :required="false"
        labelName="作品詳細"
      >
        例)#ハガレン #漫画 鋼の錬金術師の主人公
      </TextArea>
    </div>
    <div class="form-item">
      <RadioButton
        v-model="postImageGenre"
        name="post-image-genre"
        :options="options"
        :required="true"
        labelName="ジャンル"
      >
      </RadioButton>
    </div>
    <div class="form-item">
      <FileForm
        id="post-image"
        name="post-image"
        :required="true"
        labelName="作品ファイル"
        @input="onFileChange"
        @imageDelete="imageDelete"
      >
      </FileForm>
    </div>
    <div class="form-item">
      <FormButton buttonName="投稿する"></FormButton>
    </div>
  </form>
</template>

<script>
import TextForm from "../form/TextForm.vue";
import TextArea from "../form/TextArea.vue";
import RadioButton from "../form/RadioButton.vue";
import FileForm from "../form/FileForm.vue";
import FormButton from "../form/FormButton.vue";
import axios from "axios";

export default {
  components: {
    TextForm,
    TextArea,
    RadioButton,
    FileForm,
    FormButton,
  },
  data() {
    return {
      title: "",
      imageIntroduction: "",
      postImageGenre: "",
      image: "",
      options: [
        {
          label: "イラスト",
          value: 0,
        },
        {
          label: "写真",
          value: 1,
        },
        {
          label: "ロゴ",
          value: 2,
        },
      ],
    };
  },
  methods: {
    onFileChange(value) {
      this.image = value;
    },
    imageDelete(value) {
      this.image = value;
      console.log(value);
    },
    postPostImage() {
      axios({
        url: "/api/v1/post_images",
        data: {
          title: this.title,
          image_introduction: this.imageIntroduction,
          image: this.image,
          post_image_genre: this.post_image_genre,
        },
        method: "POST",
      }).then(response => {
        this.title = "",
        this.imageIntroduction = "",
        this.image = "",
        this.postImagegenre = ""
      }).catch(error => {
        console.log(error, response)
      })
    }
  },
};
</script>

<style lang="scss" scoped>
#post-image-modal {
  height: 94%;
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;

  .form-item {
    margin-bottom: 20px;
  }
}
</style>