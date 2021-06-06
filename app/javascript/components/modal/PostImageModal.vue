<template>
  <form id="post-image-modal" v-on:submit.prevent="postPostImage">
    <transition-group name="fade-list">
      <p v-if="errors" class="error" key="error">入力内容を確認してください</p>
      <div class="form-item" key="form-text">
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
        <ErrorMessage
          v-if="errorMessage.title"
          :message="errorMessage.title"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-textarea">
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
      <div class="form-item" key="form-radio-button">
        <RadioButton
          name="post-image-genre"
          :options="options"
          :required="true"
          labelName="ジャンル"
          @input="postImage.post_image_genre = $event"
        >
        </RadioButton>
        <ErrorMessage
          v-if="errorMessage.post_image_genre"
          :message="errorMessage.post_image_genre"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-file">
        <FileForm
          id="post-image"
          name="post-image"
          :required="true"
          labelName="作品ファイル"
          @input="onFileChange"
          @imageDelete="imageDelete"
        >
        </FileForm>
        <ErrorMessage
          v-if="errorMessage.post_image"
          :message="errorMessage.post_image"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-button">
        <FormButton buttonName="投稿する"></FormButton>
      </div>
    </transition-group>
  </form>
</template>

<script>
import TextForm from "../form/TextForm.vue";
import TextArea from "../form/TextArea.vue";
import RadioButton from "../form/RadioButton.vue";
import FileForm from "../form/FileForm.vue";
import FormButton from "../form/FormButton.vue";
import ErrorMessage from "../form/ErrorMessage.vue";
import axios from "axios";

export default {
  components: {
    TextForm,
    TextArea,
    RadioButton,
    FileForm,
    FormButton,
    ErrorMessage,
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
      errors: false,
      errorMessage: {},
    };
  },
  methods: {
    onFileChange(value) {
      this.postImage.image = value;
    },
    imageDelete(value) {
      this.postImage.image = value;
    },
    scrollTop() {
      var modalTop = document.getElementById('post-image-modal');
      modalTop.scrollTo({
        top: 0,
        behavior: "smooth"
      })
    },
    postPostImage() {
      axios({
        url: "/api/v1/post_images",
        data: {
          post_image: this.postImage,
        },
        method: "POST",
      })
        .then((response) => {
          (this.postImage.title = ""),
            (this.postImage.image_introduction = ""),
            (this.postImage.image = ""),
            (this.postImage.post_image_genre = ""),
            (this.id = response.data.id);
          this.$emit("success", this.id);
        })
        .catch((error) => {
          this.errorMessage = error.response.data;
          this.errors = true;
          setTimeout(() => {
            this.scrollTop();
          }, 500)
        });
    },
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

#post-image-modal {
  margin: 0 auto;
  padding: 30px 40px;
  height: 655px;
  overflow: auto;
  -webkit-overflow-scrolling: touch;
  -ms-overflow-style: none;
  scrollbar-width: none;

  @include sp {
    padding: 20px 20px;
    height: 560px;
  }

  &::-webkit-scrollbar {
    display: none;
  }

  .form-item {
    margin-bottom: 20px;
  }

  #error-message {
    width: 65%;
    margin: 20px 0 30px auto;
  }

  .error {
    font-weight: bold;
    font-size: 20px;
    color: $danger-color;
    margin-bottom: 40px;
  }
}
</style>
