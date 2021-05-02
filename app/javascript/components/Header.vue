<template>
  <header>
    <div class="container">
      <div class="header-left">
        <img src="~logo.png" />
        <h1>FanNotes</h1>
      </div>
      <div class="header-right" v-if="userLogIn">
        <div
          class="header-link"
          v-for="logInUserLink in logInUserLinks"
          :key="logInUserLink.id"
          :class="{ hover: logInUserLink.hover }"
          @mouseover="onAccent(logInUserLink)"
          @mouseleave="outAccent(logInUserLink)"
        >
          <div v-if="logInUserLink.name === 'マイページ'">
            <router-link :to="logInUserLink.path">
              {{ logInUserLink.name }}
              <i :class="logInUserLink.icon"></i>
            </router-link>
          </div>
          <div v-else @click="modalOpen(logInUserLink.name)">
            <router-link :to="logInUserLink.path">
              {{ logInUserLink.name }}
              <i :class="logInUserLink.icon"></i>
            </router-link>
          </div>
        </div>
        <div 
          class="header-link"
          :class="{ hover: logOut.hover }"
          @mouseover="onAccent(logOut)"
          @mouseleave="outAccent(logOut)"
        >
          <a href="/users/sign_out" data-method="delete">
            ログアウト
            <i class="fas fa-sign-out-alt"></i>
          </a>
        </div>
      </div>
      <div class="header-right" v-else>
        <div
          class="header-link"
          v-for="routerLink in routerLinks"
          :key="routerLink.id"
          :class="{ hover: routerLink.hover }"
          @mouseover="onAccent(routerLink)"
          @mouseleave="outAccent(routerLink)"
        >
          <router-link :to="routerLink.path" active-class="link--active" exact>
            {{ routerLink.name }}
          </router-link>
        </div>
        <div 
          class="header-link" 
          v-for="normalLink in normalLinks" 
          :key="normalLink.id" 
          :class="{ hover: normalLink.hover }" 
          @mouseover="onAccent(normalLink)"
          @mouseleave="outAccent(normalLink)" 
        >
          <a :href="normalLink.path">{{ normalLink.name }}</a>
        </div>
      </div>
    </div>
    <transition name="fade">
      <Modal
        v-if="isModal ? true : false"
        :isShow="isModal"
        :modalType="modalType"
        @modalClose="modalClose" >
      </Modal>
    </transition>
  </header>
</template>

<script>
import 'logo.png';
import Modal from './Modal.vue'

export default {
  props: {
    userLogIn: {
      type: Boolean,
      required: true,
    }
  },
  data() {
    return {
      logOut: {
        hover: false,
      },
      modalType: "",
      isModal: false,
      logInUserLinks: [
        {
          name: "投稿する",
          path: "",
          hover: false,
          method: "get",
          icon: "far fa-plus-square",
          click: this.modalOpen
        },
        {
          name: "マイページ",
          path: "",
          hover: false,
          method: "get",
          icon: "far fa-user",
          click: this.modalOpen
        },
        {
          name: "通知",
          path: "",
          hover: false,
          method: "get",
          icon: "far fa-bell",
          click: this.modalOpen
        },
        {
          name: "メニュー",
          path: "",
          hover: false,
          method: "get",
          icon: "fas fa-caret-down",
          click: this.modalOpen
        },
      ],
      routerLinks: [
        {
          name: "Top",
          path: "/",
          hover: false,
        },
        {
          name: "About",
          path: "/about",
          hover: false,
        },
        {
          name: "How to Use",
          path: "/use",
          hover: false,
        }
      ],
      normalLinks: [
        {
          name: "Log In",
          path: "/users/sign_in",
          hover: false,
        },
        {
          name: "Sign Up",
          path: "/users/sign_up",
          hover: false,
        }
      ]
    }
  },
  methods: {
    onAccent(link) {
      link.hover = true;
    },
    outAccent(link) {
      link.hover = false;
    },
    modalOpen(modalType) {
      this.isModal = true;
      this.modalType = modalType;
    },
    modalClose(value) {
      this.isModal = value;
    }
  },
  components: {
    Modal,
  }
}
</script>

<style lang="scss" scoped>
  $accent-color: #e65b20;
  $back-ground-color: #f7f4f2;
  $font-color: #3e1300;

  header {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1050;
    width: 100%;
    height: 80px;
    background-color: $back-ground-color;

    .container {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .header-left {
      display: flex;
      align-items: center;

      img {
        height: 80px;
        width: 80px;
      }
      h1 {
        font-family: 'Akaya Telivigala', cursive, 'Nunito', sans-serif;
        font-weight: bold;
        font-size: 30px;
      }
    }

    .header-right {
      display: flex;
      align-items: center;

      .header-link {
        font-size: 13px;
        margin-left: 20px;
        padding: 5px 13px;
        transition: all .5s;
        border-radius: 20px;

        a {
          transition: all .5s;
        }
      }
    }

    .link--active {
      font-size: 18px;

      &:after {
        background-color: $accent-color;
        border-radius: 5px;
        content: "";
        display: block;
        height: 4px;
      }
    }
  }
</style>