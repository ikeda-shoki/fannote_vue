<template>
  <header>
    <div class="container">
      <router-link :to="'/post_images/main'">
        <div class="header-left">
          <img src="~logo.png" />
          <h1>FanNotes</h1>
        </div>
      </router-link>
      <div class="header-right" v-if="userLogIn">
        <div
          class="header-link"
          v-for="logInUserLink in logInUserLinks"
          :key="logInUserLink.id"
          @mouseover="onAccent(logInUserLink)"
          @mouseleave="outAccent(logInUserLink)"
        >
          <div v-if="logInUserLink.name === 'マイページ'">
            <router-link
              :to="'/users/' + currentUser.id"
              :class="{ hover: logInUserLink.hover }"
            >
              {{ logInUserLink.name }}
              <i :class="logInUserLink.icon"></i>
            </router-link>
          </div>
          <div
            v-else-if="logInUserLink.name === 'メニュー'"
            class="header-menu"
          >
            <a
              href="/"
              @click.prevent="pullDownMenu"
              class="header-menu-button"
            >
              {{ logInUserLink.name }}
              <i :class="logInUserLink.icon"></i>
            </a>
            <transition name=fade>
              <ul
                class="header-menu-lists"
                v-show="isHeaderMenu"
              >
                <li
                  class="header-menu-list"
                  v-for="headerMenu in headerMenus"
                  :key="headerMenu.name"
                >
                  <router-link :to="headerMenu.link">
                    {{ headerMenu.name }}<i :class="headerMenu.class"></i>
                  </router-link>
                </li>
              </ul>
            </transition>
          </div>
          <div v-else @click="modalOpen(logInUserLink.name)">
            <router-link
              :to="logInUserLink.path"
              :class="{ hover: logInUserLink.hover }"
            >
              {{ logInUserLink.name }}
              <i :class="logInUserLink.icon"></i>
            </router-link>
          </div>
        </div>
        <div
          class="header-link"
          @mouseover="onAccent(logOut)"
          @mouseleave="outAccent(logOut)"
        >
          <a
            href="/users/sign_out"
            :class="{ hover: logOut.hover }"
            data-method="delete"
          >
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
          @mouseover="onAccent(routerLink)"
          @mouseleave="outAccent(routerLink)"
        >
          <router-link
            :to="routerLink.path"
            :class="{ hover: routerLink.hover }"
            active-class="link--active"
            exact
          >
            {{ routerLink.name }}
          </router-link>
        </div>
        <div
          class="header-link"
          v-for="normalLink in normalLinks"
          :key="normalLink.id"
          @mouseover="onAccent(normalLink)"
          @mouseleave="outAccent(normalLink)"
        >
          <a :href="normalLink.path" :class="{ hover: normalLink.hover }">{{
            normalLink.name
          }}</a>
        </div>
      </div>
    </div>
    <transition name="fade">
      <Modal
        v-if="isModal ? true : false"
        :isShow="isModal"
        :modalType="modalType"
        @modalClose="modalClose"
        @screenTransition="screenTransition"
      >
      </Modal>
    </transition>
  </header>
</template>

<script>
import "logo.png";
import Modal from "./Modal.vue";

export default {
  props: {
    userLogIn: {
      type: Boolean,
      required: true,
      default: false,
    },
    currentUser: {
      type: Object,
    },
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
          click: this.modalOpen,
        },
        {
          name: "マイページ",
          path: "",
          hover: false,
          method: "get",
          icon: "far fa-user",
          click: this.modalOpen,
        },
        {
          name: "通知",
          path: "",
          hover: false,
          method: "get",
          icon: "far fa-bell",
          click: this.modalOpen,
        },
        {
          name: "メニュー",
          path: "",
          hover: false,
          method: "get",
          icon: "fas fa-caret-down",
          click: this.modalOpen,
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
        },
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
        },
      ],
      headerMenus: [
        { name: "メイン画面", class: "fas fa-home", link: "/post_images/main" },
        { name: "投稿一覧", class: "fas fa-copy", link: "/post_images" },
        { name: "ユーザー一覧", class: "fas fa-users", link: "/users" },
      ],
      isHeaderMenu: false,
    };
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
    },
    async screenTransition(value) {
      await this.modalClose();
      this.$router.push("/post_images/" + value);
    },
    pullDownMenu() {
      this.isHeaderMenu = !this.isHeaderMenu;
    },
  },
  components: {
    Modal,
  },
  watch: {
    $route() {
      this.isHeaderMenu = false;
    },
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;

.slide-top-move {
  transition: all 3s;
}

header {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 1;
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
      font-family: "Akaya Telivigala", cursive, "Nunito", sans-serif;
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
      transition: all 0.5s;

      a {
        display: block;
        border-radius: 20px;
        transition: all 0.5s;
        padding: 5px 13px;
      }
    }

    .header-menu {
      position: relative;

      .header-menu-button {
        &:hover {
          background-color: $accent-color;
          color: $back-ground-color;
          font-weight: bold;
        }
      }

      .header-menu-lists {
        position: absolute;
        left: -18px;
        background-color: $back-ground-color;
        width: 130px;
        box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
        transition: all 0.5s;
        -moz-transition: all 0.5s;

        .header-menu-list {
          font-size: 13px;
          padding: 10px 15px;
          transition: all 0.5s;
          -moz-transition: all 0.5s;

          &:hover {
            background-color: $accent-color;

            a {
              color: $back-ground-color;
            }

            i {
              color: $back-ground-color;
            }
          }

          a {
            padding: 0;
            display: block;
          }

          i {
            margin-left: 5px;
          }
        }
      }
    }
  }

  .link--active {
    font-size: 16px;
    &:after {
      background-color: $accent-color;
      border-radius: 5px;
      content: "";
      display: block;
      height: 2px;
    }
  }
}
</style>
