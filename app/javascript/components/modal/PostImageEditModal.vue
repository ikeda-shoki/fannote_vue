<template>
  <form id="post-image-edit-modal" @submit.prevent="editPostImage">
    <div class="form-item">
      <TextForm
        :value="editData.title"
        id="post-image-title-edit"
        type="text"
        name="post-image-title"
        :required="true"
        labelName="タイトル"
        ref= "title"
      >
        例)鋼の錬金術師 エドワードエルリック
      </TextForm>
    </div>
    <div class="form-item">
      <TextArea
        :value="editData.image_introduction"
        id="post-image-introduction-edit"
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
        :value="editData.post_image_genre"
        name="post-image-genre"
        :options="options"
        :required="true"
        labelName="ジャンル"
      >
      </RadioButton>
    </div>
    <div class="form-item">
      <FileForm
        id="post-image-edit"
        name="post-image"
        :required="true"
        :image="editData.post_image"
        labelName="作品ファイル"
        @imageDelete="imageDelete"
      >
      </FileForm>
    </div>
    <div class="form-item">
      <FormButton buttonName="更新する"></FormButton>
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
      this.editData.post_image = value;
    },
    imageDelete(value) {
      this.editData.post_image = value;
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
          console.log(error, response);
        });
    },
  },
};
</script>

<style lang="scss" scoped>
$back-ground-color: #f7f4f2;

#post-image-edit-modal {
  height: 94%;
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;

  .form-item {
    margin-bottom: 20px;
  }
}
</style>
