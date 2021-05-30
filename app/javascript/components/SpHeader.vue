<template>
  <div class="sp-header">
    <div class="sp-header-main">
      <div class="container">

        <template v-if="userLogIn === true">
          <router-link :to="'/post_images/main'">
            <div class="sp-header-left">
              <img src="~logo.png" />
              <h1>FanNotes</h1>
            </div>
          </router-link>
          <div class="sp-header-right">
            <div class="sp-header-notification" @click="modalOpen">
              <i class="far fa-bell"></i>
              <div
                  v-if="currentUser.unchecked_notifications"
                  class="is-unchecked"
                ></div>
            </div>
            <HumburgerMenu :isModal="isSpModal" :isHamburgerMenu="isHumburgerMenu" @click.native="openSpModal"></HumburgerMenu>
          </div>
        </template>

        <template v-else>
          <div class="sp-header-left">
            <img src="~logo.png" />
            <h1>FanNotes</h1>
          </div>
          <div class="sp-header-right">
            <HumburgerMenu :isModal="isModal" :isHamburgerMenu="isHumburgerMenu" @click.native="openSpModal"></HumburgerMenu>
          </div>
        </template>
      </div>
    </div>
    <transition name="right-slide">
      <SpHeaderModal :isModal="isSpModal" :userLogIn="userLogIn" @modalClose="closeSpModal" v-if="isSpModal" @openConfirm="openConfirm"></SpHeaderModal>
    </transition>
  </div>
</template>

<script>
import "logo.png";
import HumburgerMenu from "./parts/HumburgerMenu.vue";
import SpHeaderModal from "./parts/SpHeaderModal.vue";

export default {
  props: {
    userLogIn: {
      type: Boolean,
      required: true,
    },
    currentUser: {
      type: Object,
      required: true,
    },
    isModal: {
      type: Boolean,
      required: true,
    }
  },
  data() {
    return {
      isSpModal: false,
      isHumburgerMenu: false,
    }
  },
  components: {
    HumburgerMenu,
    SpHeaderModal,
  },
  methods: {
    openSpModal() {
      this.isSpModal = true;
      this.isHumburgerMenu = true;
    },
    closeSpModal() {
      this.isSpModal = false;
      this.isHumburgerMenu = false;
    },
    modalOpen() {
      this.$emit("modalOpen", "通知")
      this.$emit("isUnchecked");
    },
    openConfirm() {
      this.$emit("openConfirm")
    }
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

.right-slide-enter-active, .right-slide-leave-active {
  transform: translate(0px, 0px);
  transition: transform .8s;
}

.right-slide-enter, .right-slide-leave-to {
  transform: translateX(100vh);
}

.sp-header {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 1;
  width: 100%;
  height: 60px;

  .sp-header-main {
    opacity: 0.8;
    background-color: $back-ground-color;
  }

  .container {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .sp-header-left {
    display: flex;
    align-items: center;

    img {
      height: 60px;
      width: 60px;
    }
    h1 {
      font-family: "Akaya Telivigala", cursive, "Nunito", sans-serif;
      font-weight: bold;
      font-size: 28px;
    }
  }

  .sp-header-right {
    display: flex;
    align-items: center;

    .sp-header-notification {
      margin: 5px 15px 0px;
      position: relative;

      i {
        font-size: 25px;
      }

      .is-unchecked {
        position: absolute;
        background-color: #efa04c;
        display: block;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        top: -1px;
        right: -5px;
      }
    }
  }
}
</style>