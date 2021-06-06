<template>
  <div id="request-edit-modal">
    <transition-group name="fade-list">
      <p v-if="errors" class="error" key="error">入力内容を確認してください</p>
      <div class="form-item" key="form-request-introduction">
        <TextArea
          v-model="request.request_introduction"
          id="request-introduction-edit"
          type="text"
          name="request-introduction-edit"
          :required="true"
          labelName="依頼内容"
        >
          例)アイコンの作成、キャラクターの作成、HP用の素材写真etc...
        </TextArea>
        <ErrorMessage
          v-if="errorMessage.request_introduction"
          :message="errorMessage.request_introduction"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-file">
        <FileForm
          id="request-reference-image-edit"
          name="request-reference-image-edit"
          :required="false"
          :image="request.image"
          labelName="参考画像"
          @imageDelete="imageDelete"
          @input="onFileChange"
        >
          <p>参考画像</p>
          <img :src="request.image" alt="参考画像">
        </FileForm>
      </div>
      <div class="form-item" key="form-radio-button">
        <RadioButton
          name="file-format-edit"
          :options="options"
          :required="true"
          :checkedValue="request.file_format"
          labelName="ファイル形式"
          @input="request.file_format = $event"
        >
        </RadioButton>
        <ErrorMessage
          v-if="errorMessage.file_format"
          :message="errorMessage.file_format"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-use">
        <TextArea
          v-model="request.use"
          id="request-use-edit"
          type="text"
          name="request-use-edit"
          :required="true"
          labelName="用途"
        >
          例)SNSのアイコン用、自作のHP用の素材etc...
        </TextArea>
        <ErrorMessage v-if="errorMessage.use" :message="errorMessage.use"></ErrorMessage>
      </div>
      <div class="form-item" key="form-amount">
        <TextForm
          v-model.number="request.amount"
          id="amuont-edit"
          type="number"
          name="amount-edit"
          :required="true"
          labelName="枚数"
          ref="amount"
        >
          ※枚数は1枚以上99枚以下での範囲で選択してください
        </TextForm>
        <ErrorMessage
          v-if="errorMessage.amount"
          :message="errorMessage.amount"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-deadline">
        <TextForm
          v-model="request.deadline"
          id="deadline-edit"
          type="date"
          name="deadline-edit"
          :required="true"
          labelName="締め切り"
          ref="deadline"
        >
          ※締切には最短で3日後から入力してください
        </TextForm>
        <ErrorMessage
          v-if="errorMessage.deadline"
          :message="errorMessage.deadline"
        ></ErrorMessage>
      </div>
      <div class="request-edit-button" key="form-button">
        <FormButton buttonName="更新する" @click.native="updateRequest"></FormButton>
      </div>
    </transition-group>
  </div>
</template>

<script>
import axios from "axios"
import TextArea from "../form/TextArea.vue"
import FileForm from "../form/FileForm.vue"
import RadioButton from "../form/RadioButton.vue"
import TextForm from "../form/TextForm.vue"
import FormButton from "../form/FormButton.vue"
import ErrorMessage from "../form/ErrorMessage.vue"

export default {
  props: {
    editData: { type: Object, required: true },
  },
  data() {
    return {
      errors: false,
      errorMessage: {},
      request: {
        request_introduction: this.editData.request_introduction,
        file_format: this.editData.file_format,
        use: this.editData.use,
        amount: this.editData.amount,
        deadline: this.editData.deadline,
        image: this.editData.reference_image,
      },
      options: [
        {
          label: "jpeg",
          value: "jpeg",
        },
        {
          label: "png",
          value: "png",
        },
      ],
    };
  },
  components: {
    TextArea,
    FileForm,
    RadioButton,
    TextForm,
    FormButton,
    ErrorMessage,
  },
  methods: {
    onFileChange(value) {
      this.request.image = value;
    },
    imageDelete(value) {
      this.request.image = value;
    },
    updateRequest() {
      axios({
        url: "/api/v1/users/" + this.$route.params.id + "/requests/" + this.editData.id,
        data: {
          request: this.request,
        },
        method: "PATCH",
      })
        .then((response) => {
          this.$emit("success", response.data);
        })
        .catch((error) => {
          this.errorMessage = error.response.data;
          this.errors = true;
          setTimeout(() => {
            this.scrollTop();
          }, 500)
        });
    },
    scrollTop() {
      var modalTop = document.getElementById('request-edit-modal');
      modalTop.scrollTo({
        top: 0,
        behavior: "smooth"
      })
    },
  }
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

#request-edit-modal {
  margin: 0 auto;
  padding: 30px 40px;
  text-align: left;
  height: 655px;
  overflow: auto;
  -webkit-overflow-scrolling: touch;
  -ms-overflow-style: none;
  scrollbar-width: none;

  @include sp {
    height: 560px;
  }

  &::-webkit-scrollbar {
    display: none;
  }

  .form-item {
    margin-bottom: 20px;
  }

  .request-edit-button {
    margin-top: 50px;
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

  #file-form {
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
}
</style>
