<template>
  <form id="request-modal" @submit.prevent="createRequest">
    <transition-group name="fade-list">
      <p v-if="errors" class="error" key="error">入力内容を確認してください</p>
      <div class="form-item" key="form-request-introduction">
        <TextArea
          v-model="request.request_introduction"
          id="request-introduction"
          type="text"
          name="request-introduction"
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
          id="reference_image"
          name="reference_image"
          :required="false"
          :image="request.image"
          labelName="参考画像"
          @imageDelete="imageDelete"
          @input="onFileChange"
        >
        </FileForm>
      </div>
      <div class="form-item" key="form-radio-button">
        <RadioButton
          name="file_format"
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
          id="request-use"
          type="text"
          name="request-use"
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
          id="amuont"
          type="number"
          name="amount"
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
          id="deadline"
          type="date"
          name="deadline"
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
      <div class="form-item" key="form-button">
        <FormButton buttonName="依頼する"></FormButton>
      </div>
    </transition-group>
  </form>
</template>

<script>
import FormName from "../form/FormName.vue";
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
      errors: false,
      errorMessage: {},
      request: {
        request_introduction: "",
        file_format: "",
        use: "",
        deadline: "",
        amount: 1,
        image: "",
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
  methods: {
    onFileChange(value) {
      this.request.image = value;
    },
    imageDelete(value) {
      this.request.image = value;
    },
    scrollTop() {
      var modalTop = document.getElementById('request-modal');
      modalTop.scrollTo({
        top: 0,
        behavior: "smooth"
      })
    },
    createRequest() {
      axios({
        url: "/api/v1/users/" + this.user.id + "/requests",
        data: {
          request: this.request,
        },
        method: "POST",
      })
        .then((response) => {
          (this.request.request_introduction = ""),
          (this.request.file_format = ""),
          (this.request.image = ""),
          (this.request.use = ""),
          (this.request.amount = ""),
          (this.request.deadline = ""),
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
  },
  props: {
    user: { type: Object, required: true }
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

#request-modal {
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;
  text-align: left;
  height: 655px;
  -ms-overflow-style: none;
  scrollbar-width: none;

  @include sp {
    padding: 20px;
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
