<template>
  <div id="post-image-edit-modal">
    <transition-group name="fade-list">
      <p v-if="errors" class="error" key="error">入力内容を確認してください</p>
      <div class="form-item" key="form-text">
        <TextForm
          v-model="postImage.title"
          id="post-image-title-edit"
          type="text"
          name="post-image-title"
          :required="true"
          labelName="タイトル"
          ref= "title"
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
          id="post-image-introduction-edit"
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
          :checkedValue="postImage.post_image_genre"
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
          id="post-image-edit"
          name="post-image"
          :required="true"
          :image="postImage.image"
          labelName="作品ファイル"
          @imageDelete="imageDelete"
          @input="onFileChange"
        >
          <img :src="editData.post_image" alt="投稿した画像" />
          <p>※投稿する画像は編集することは出来ません</p>
        </FileForm>
      </div>
      <div class="form-item" key="form-button">
        <div class="post-image-edit-modal-buttons">
          <FormButton buttonName="更新する" @click.native="editPostImage"></FormButton>
          <!-- <button class="button" @click="postImageDelete">投稿を削除する</button> -->
          <button class="button" @click="openConfirm">投稿を削除する</button>
        </div>
      </div>
    </transition-group>
    <transition name="fade">
      <Confirm v-if="isConfirm" @falseAction="closeConfirm" @successAction="postImageDelete">
        投稿は元に戻りませんが、本当に投稿を削除してもいいですか？
      </Confirm>
    </transition>
  </div>
</template>

<script>
import FormName from "../form/FormName.vue"
import TextForm from "../form/TextForm.vue";
import TextArea from "../form/TextArea.vue";
import RadioButton from "../form/RadioButton.vue";
import FileForm from "../form/FileForm.vue";
import FormButton from "../form/FormButton.vue";
import ErrorMessage from "../form/ErrorMessage.vue";
import Confirm from "../parts/Confirm.vue";
import axios from "axios";

export default {
  components: {
    TextForm,
    TextArea,
    RadioButton,
    FileForm,
    FormButton,
    ErrorMessage,
    Confirm,
  },
  data() {
    return {
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
      postImage: {
        title: this.editData.title,
        image_introduction: this.editData.image_introduction,
        image: this.editData.post_image,
        post_image_genre: this.editData.post_image_genre,
      },
      isConfirm: false,
      errors: false,
      errorMessage: {},
    };
  },
  props: {
    editData: {
      type: Object,
      required: true,
    },
  },
  methods: {
    onFileChange(value) {
      this.postImage.image = value;
    },
    imageDelete(value) {
      this.postImage.image = value;
    },
    scrollTop() {
      var modalTop = document.getElementById('post-image-edit-modal');
      modalTop.scrollTo({
        top: 0,
        behavior: "smooth"
      })
    },
    editPostImage() {
      axios({
        url: "/api/v1/post_images/" + this.$route.params.id,
        data: {
          post_image: this.postImage,
        },
        method: "PATCH",
      })
        .then((response) => {
          this.$emit("success");
        })
        .catch((error) => {
          this.errorMessage = error.response.data;
          this.errors = true;
          setTimeout(() => {
            this.scrollTop();
          }, 500)
        });
    },
    postImageDelete() {
      axios({
        url: "/api/v1/post_images/" + this.$route.params.id,
        method: "DELETE",
      })
        .then(response => {
          this.$emit('postImageDeleteSuccess', this.editData.user.id);
        })
    },
    openConfirm() {
      this.isConfirm = true;
    },
    closeConfirm() {
      this.isConfirm = false;
    }
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#post-image-edit-modal {
  height: 94%;
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;
  height: 655px;
  -ms-overflow-style: none;
  scrollbar-width: none;

  &::-webkit-scrollbar {
    display: none;
  }

  .form-item {
    margin-bottom: 20px;

    .post-image-edit-modal-buttons {
      display: flex;
      justify-content: center;

      .button {
        margin-left: 20px;
        background-color: $danger-color;
      }
    }
  }

  #file-form {
    /deep/ .form-file {
      display: none;
    }

    /deep/ #close-button {
      display: none;
    }

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
