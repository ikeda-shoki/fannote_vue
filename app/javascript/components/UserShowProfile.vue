<template>
  <div id="user-show-profile">
    <UserReception :isReception="user.is_reception"></UserReception>
    <CircleImage :image="user.profile_image"></CircleImage>

    <Title v-if="user.account_name" :title="user.account_name"></Title>
    <Title v-else :title="user.user_name"></Title>

    <div class="user-show-profile-introduction">
      <p>{{ user.user_introduction }}</p>
    </div>

    <UserItems :user="user"></UserItems>

    <div
      class="user-show-profile-edit-button"
      v-if="user.current_user_same_as"
      @click="modalOpenUserEdit"
    >
      <p class="button">編集する</p>
    </div>

    <div class="user-show-request_button" v-if="!user.current_user_same_as">
      <template v-if="user.is_reception">
        <Button>
          <a href="" class="top-button" @click.prevent="modalOpenRequest">
            <span>作品を依頼する</span>
          </a>
        </Button>
      </template>
      <template v-else>
        <p>依頼不可</p>
      </template>
    </div>

    <div class="user-show-profile-request-buttons" v-if="user.current_user_same_as">
      <router-link :to="{ name: 'requested', params: { id: user.id }}" v-if="user.is_reception">
        <button class="button requested-button">依頼された内容</button>
      </router-link>
      <router-link :to="{ name: 'requesting', params: { id: user.id }}">
        <button class="button requesting-button">依頼した内容</button>
      </router-link>
    </div>

    <transition name="fade">
      <Modal
        v-if="isModal ? true : false"
        :isShow="isModal"
        :editData="user"
        :modalType="modalType"
        @modalClose="modalClose"
        @successUser="successUser"
        @screenTransition="screenTransition"
      ></Modal>
    </transition>
  </div>
</template>

<script>
import Title from "./parts/Title.vue";
import UserItems from "./parts/UserItems.vue";
import Button from "./parts/Button.vue";
import Modal from "./Modal.vue";
import CircleImage from "./parts/CircleImage.vue";
import UserReception from "./parts/UserReception.vue";

export default {
  components: {
    Title,
    UserItems,
    Button,
    Modal,
    CircleImage,
    UserReception,
  },
  props: {
    user: { type: Object, required: true },
    currenUserId: { required: true }
  },
  data() {
    return {
      isModal: false,
      modalType: ""
    };
  },
  methods: {
    modalOpenUserEdit() {
      this.isModal = true;
      this.modalType = "ユーザーを編集する"
    },
    modalOpenRequest() {
      this.isModal = true;
      this.modalType = "リクエストを依頼する"
    },
    modalClose(value) {
      this.isModal = value;
    },
    successUser() {
      this.$emit("userUpdate");
    },
    async screenTransition() {
      await this.modalClose();
      this.$router.push({ path: "/users/" + this.currenUserId + "/requesting", query: { method: "create" } });
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

#user-show-profile {
  background-color: $font-white;
  border-radius: 20px;
  padding: 90px 30px 30px;
  text-align: center;
  margin-top: 130px;
  position: relative;

  #circle-image {
    position: absolute;
    top: -75px;
    left: 50%;
    transform: translateX(-50%);
  }

  .user-reception {
    position: absolute;
    top: 150px;
    right: 10px;
  }

  #title {
    font-size: 23px;

    /deep/ h2 {
      font-weight: 800;
    }
  }

  .user-show-profile-introduction {
    margin: 30px 0;

    p {
      padding: 20px;
      border-radius: 20px;
      background-color: $back-ground-color;
      font-size: 14px;
    }
  }

  #user-items {
    /deep/ span {
      font-size: 20px;
    }
  }

  .user-show-profile-edit-button {
    margin: 30px 0;
  }

  .vue-button {
    min-width: auto;
    padding: 0px 20px;

    /deep/ span {
      font-size: 16px;
    }
  }

  .user-show-profile-request-buttons {
    margin-top: 30px;

    .requested-button {
      margin-bottom: 10px;
      background-color: $accent-color;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
    }

    .requesting-button {
      background-color: $accent-color;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
    }
  }
}
</style>
