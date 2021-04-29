<template>
  <div id="post-image-modal">
    <div class="form-item">
      <TextForm
        v-model="postImageTitle"
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
        v-model="postImageIntroduction"
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
      >
      </FileForm>
    </div>
  </div>
</template>

<script>
import TextForm from "../form/TextForm.vue";
import TextArea from "../form/TextArea.vue";
import RadioButton from "../form/RadioButton.vue";
import FileForm from "../form/FileForm.vue";

export default {
  components: {
    TextForm,
    TextArea,
    RadioButton,
    FileForm,
  },
  data() {
    return {
      postImageTitle: "",
      postImageIntroduction: "",
      postImageGenre: "",
      postImage: "",
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
  methods: {
    onFileChange(value) {
      this.postImage = value;
    },
  },
};
</script>

<style lang="scss" scoped>
#post-image-modal {
  width: 90%;
  margin: 0 auto;
  padding-top: 30px;

  .form-item {
    margin-bottom: 20px;
  }
}
</style>