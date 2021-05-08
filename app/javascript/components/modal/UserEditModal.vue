<template>
  <form id="user-edit-modal" @submit.prevent="editUser">
    <div class="form-item">
      <TextForm
        v-model="user.user_name"
        id="user-user-name-edit"
        type="text"
        name="user-name-edit"
        :required="true"
        labelName="ユーザーネーム"
        ref="userName"
      >
        例)山田 太朗
      </TextForm>
    </div>
    <div class="form-item">
      <TextForm
        v-model="user.account_name"
        id="user-account-name-edit"
        type="text"
        name="account-name-edit"
        :required="false"
        labelName="アカウントネーム"
        ref="accountName"
      >
        例)やまちゃん
      </TextForm>
    </div>
    <div class="form-item">
      <TextArea
        v-model="user.user_introduction"
        id="user-user-introduction-edit"
        type="text"
        name="user-introduction"
        :required="false"
        labelName="プロフィール"
      >
        例)よろしくお願いします！
      </TextArea>
    </div>
    <div class="form-item">
      <FileForm
        id="user-profile-image-edit"
        name="profile-image"
        :required="false"
        :image="user.image"
        labelName="アイコン"
        @imageDelete="imageDelete"
        @input="onFileChange"
      >
        <p>アイコン</p>
        <CircleImage :image="user.image"></CircleImage>
      </FileForm>
    </div>
    <div class="form-item">
      <RadioButton
        name="user-is-reception-edit"
        :options="options"
        :required="true"
        :checkedValue="editData.is_reception"
        labelName="受付状況"
        @input="user.is_reception = $event"
      >
      </RadioButton>
    </div>
    <div class="form-item">
      <FormButton buttonName="更新する"></FormButton>
    </div>
  </form>
</template>

<script>
import TextForm from "../form/TextForm.vue";
import TextArea from "../form/TextArea.vue";
import FileForm from "../form/FileForm.vue";
import RadioButton from "../form/RadioButton.vue";
import FormButton from "../form/FormButton.vue";
import CircleImage from "../parts/CircleImage.vue";
import axios from "axios";

export default {
  components: {
    TextForm,
    TextArea,
    FileForm,
    RadioButton,
    FormButton,
    CircleImage,
  },
  props: {
    editData: { type: Object },
  },
  data() {
    return {
      user: {
        user_name: this.editData.user_name,
        account_name: this.editData.account_name,
        user_introduction: this.editData.user_introduction,
        image: this.editData.profile_image,
        is_reception: this.editData.is_reception,
      },
      options: [
        {
          label: "受け付ける",
          value: true
        },
        {
          label: "受け付けない",
          value: false
        }
      ]
    }
  },
  methods: {
    onFileChange(value) {
      this.user.image = value;
    },
    imageDelete(value) {
      this.user.image = value;
    },
    editUser() {
      axios({
        url: "/api/v1/users/" + this.$route.params.id,
        data: {
          user: this.user
        },
        method: "PATCH",
      })
        .then((response) => {
          this.$emit("success");
        })
        .catch((error) => {
          console.log(error, response);
        });
    }
  }
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#user-edit-modal {
  height: 94%;
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;

  #text-form {
    /deep/ p {
      text-align: left;
    }
  }

  #textarea-form {
    /deep/ p {
      text-align: left;
    }
  }

  #file-form {
    text-align: left;

    /deep/ p {
      text-align: left;
      font-size: 14px;
      opacity: 0.7;
      text-align: center;
      margin-bottom: 5px;
    }

    #circle-image {
      text-align: center;
    }
  }

  .form-item {
    margin-bottom: 20px;
  }
}
</style>
