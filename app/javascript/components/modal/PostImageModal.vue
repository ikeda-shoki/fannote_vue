<template>
  <form id="post-image-modal" v-on:submit.prevent="postPostImage">
    <div class="form-item">
      <TextForm
        v-model="postImage.title"
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
        v-model="postImage.image_introduction"
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
        name="post-image-genre"
        :options="options"
        :required="true"
        labelName="ジャンル"
        @input="postImage.post_image_genre = $event"
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
      postImage: {
        title: "",
        image_introduction: "",
        post_image_genre: "",
        image: "",
      },
      options: [
        {
          label: "イラスト",
          value: "イラスト",
        },
        {
          label: "写真",
          value: "写真",
        },
        {
          label: "ロゴ",
          value: "ロゴ",
        },
      ],
      id: "",
    };
  },
  methods: {
    onFileChange(value) {
      this.postImage.image = value;
    },
    imageDelete(value) {
      this.postImage.image = value;
    },
    postPostImage() {
      axios({
        url: "/api/v1/post_images",
        data: {
          post_image: this.postImage
        },
        method: "POST",
      }).then(response => {
        this.postImage.title = "",
        this.postImage.image_introduction = "",
        this.postImage.image = "",
        this.postImage.post_image_genre = "",
        this.id = response.data.id
        this.$emit('success', this.id)
      }).catch(error => {
        console.log(error, response);
      })
    }
  },
};
</script>

<style lang="scss" scoped>
$back-ground-color: #f7f4f2;

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