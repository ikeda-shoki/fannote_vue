<template>
  <div id="user-edit-modal">
    <transition-group name="fade-list">
      <p v-if="errors" class="error" key="error">入力内容を確認してください</p>
      <div class="form-item" key="form-user-name">
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
        <ErrorMessage
          v-if="errorMessage.user_name"
          :message="errorMessage.user_name"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-account-name">
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
        <ErrorMessage
          v-if="errorMessage.account_name"
          :message="errorMessage.account_name"
        ></ErrorMessage>
      </div>
      <div class="form-item" key="form-textarea">
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
      <div class="form-item" key="form-file">
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
      <div class="form-item" key="form-radio-button">
        <RadioButton
          name="user-is-reception-edit"
          :options="options"
          :required="true"
          :checkedValue="editData.is_reception"
          labelName="受付状況"
          @input="user.is_reception = $event"
        >
        </RadioButton>
        <ErrorMessage
          v-if="errorMessage.is_reception"
          :message="errorMessage.is_reception"
        ></ErrorMessage>
      </div>
      <div class="form-item user-edit-modal-buttons" key="form-button">
        <FormButton buttonName="更新する" @click.native="editUser"></FormButton>
        <button
          class="button"
          @click="openConfirm"
        >
          退会する
        </button>
      </div>
    </transition-group>
    <transition name="fade">
      <Confirm v-if="isConfirm === true" @falseAction="closeConfirm" @successAction="deleteUser">
        あなたに関する全てのデータが消去されます。本当に退会しますか？
      </Confirm>
    </transition>
  </div>
</template>

<script>
import TextForm from "../form/TextForm.vue";
import TextArea from "../form/TextArea.vue";
import FileForm from "../form/FileForm.vue";
import RadioButton from "../form/RadioButton.vue";
import FormButton from "../form/FormButton.vue";
import CircleImage from "../parts/CircleImage.vue";
import ErrorMessage from "../form/ErrorMessage.vue";
import Confirm from "../parts/Confirm.vue";
import axios from "axios";

export default {
  components: {
    TextForm,
    TextArea,
    FileForm,
    RadioButton,
    FormButton,
    CircleImage,
    ErrorMessage,
    Confirm,
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
          value: true,
        },
        {
          label: "受け付けない",
          value: false,
        },
      ],
      isConfirm: false,
      errors: false,
      errorMessage: {},
    };
  },
  methods: {
    onFileChange(value) {
      this.user.image = value;
    },
    imageDelete(value) {
      this.user.image = value;
    },
    scrollTop() {
      var modalTop = document.getElementById("user-edit-modal");
      modalTop.scrollTo({
        top: 0,
        behavior: "smooth",
      });
    },
    editUser() {
      axios({
        url: "/api/v1/users/" + this.$route.params.id,
        data: {
          user: this.user,
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
          }, 500);
        });
    },
    deleteUser() {
      axios({
        url: "/api/v1/users/" + this.$route.params.id,
        data: {
          id: this.$route.params.id,
        },
        method: "DELETE",
      })
        .then((response) => {
          this.$router.push("/users/withdrawal");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    openConfirm() {
      this.isConfirm = true;
    },
    closeConfirm() {
      this.isConfirm = false;
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

#user-edit-modal {
  height: 94%;
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;
  height: 655px;
  -ms-overflow-style: none;
  scrollbar-width: none;

  @include sp {
    padding: 20px;
  }

  &::-webkit-scrollbar {
    display: none;
  }

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

  .user-edit-modal-buttons {
    margin-top: 50px;
    display: flex;
    justify-content: center;

    .button {
      margin-left: 15px;
      background-color: $danger-color;
    }
  }

  #error-message {
    width: 65%;
    margin: 20px 0 30px auto;
    text-align: left;
  }

  .error {
    font-weight: bold;
    font-size: 20px;
    color: $danger-color;
    margin-bottom: 40px;
    text-align: left;
  }

  #confirm {
    /deep/ p {
      font-size: 18px;
    }
  }
}

/deep/ .button {
  @include sp {
    min-width: 140px;
  }
}
</style>
