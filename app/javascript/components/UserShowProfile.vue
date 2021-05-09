<template>
  <div id="user-show-profile">
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
      @click="modalOpen"
    >
      <p class="button">編集する</p>
    </div>

    <template v-if="user.is_reception">
      <Button>
        <a href="/" class="top-button" @click.prevent="modalOpen">
          <span>作品を依頼する</span>
        </a>
      </Button>
    </template>
    <template v-else>
      <p>依頼不可</p>
    </template>

    <div class="user-show-profile-request-buttons">
      <button class="button">依頼された内容</button>
      <button class="button">依頼した内容</button>
    </div>

    <transition name="fade">
      <Modal
        v-if="isModal ? true : false"
        :isShow="isModal"
        :editData="user"
        modalType="ユーザーを編集する"
        @modalClose="modalClose"
        @successUser="successUser"
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


export default {
  components: {
    Title,
    UserItems,
    Button,
    Modal,
    CircleImage,
  },
  props: {
    user: { type: Object, required: true },
  },
  data() {
    return {
      isModal: false,
    };
  },
  methods: {
    modalOpen() {
      this.isModal = true;
    },
    modalClose(value) {
      this.isModal = value;
    },
    successUser() {
      this.$emit("userUpdate");
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

  #title {
    font-size: 23px;
    font-weight: 800;

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
  }
}
</style>
