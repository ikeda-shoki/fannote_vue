<template>
  <div class="sp-header-modal" @click.self="modalClose">
    <div class="container">
      <div class="sp-header-menu">
        <h2 class="animate__animated animate__bounce sp-header-modal-title">Menu</h2>
        <ul class="sp-header-lists">
          <template v-if="userLogIn">
            <div :class="['sp-header-list-' + index]" v-for="(list, index) in logInLists" :key="list.title"
                @mouseover="mouseOverAction({ type: 'logIn', index: index })"
                @mouseout="mouseLeaveAction({ type: 'logIn', index: index })"
                @click="modalClose">
              <template v-if="list.router">
                <router-link :to="list.path" class="sp-header-list-link" active-class="sp-link--active" exact>
                  <div class="sp-header-list">
                    <li>
                      {{ list.title }}
                    </li>
                    <span class="sp-header-list-line" :class="{ 'sp-line-hover': list.hover }"></span>
                    <span class="sp-header-list-circle" :class="{ 'sp-circle-hover': list.hover }"></span>
                  </div>
                </router-link>
              </template>
              <template v-else>
                <span @click="openConfirm">
                  <div class="sp-header-list-link">
                    <div class="sp-header-list">
                      <li>
                        {{ list.title }}
                      </li>
                      <span class="sp-header-list-line" :class="{ 'sp-line-hover': list.hover }"></span>
                      <span class="sp-header-list-circle" :class="{ 'sp-circle-hover': list.hover }"></span>
                    </div>
                  </div>
                </span>
              </template>
            </div>
          </template>
          <template v-else>
            <div :class="['sp-header-list-' + index]" v-for="(list, index) in logOutLists" :key="list.title"
                @mouseover="mouseOverAction({ type: 'logOut', index: index })"
                @mouseout="mouseLeaveAction({ type: 'logOut', index: index })"
                @click="modalClose">
              <template v-if="list.router">
                <router-link to="/" class="sp-header-list-link" active-class="sp-link--active" exact>
                  <div class="sp-header-list">
                    <li>
                      {{ list.title }}
                    </li>
                    <span class="sp-header-list-line" :class="{ 'sp-line-hover': list.hover }"></span>
                    <span class="sp-header-list-circle" :class="{ 'sp-circle-hover': list.hover }"></span>
                  </div>
                </router-link>
              </template>
              <template v-else>
                <a :href="list.path" :data-method="list.method">
                  <div class="sp-header-list-link">
                    <div class="sp-header-list">
                      <li>
                        {{ list.title }}
                      </li>
                      <span class="sp-header-list-line" :class="{ 'sp-line-hover': list.hover }"></span>
                      <span class="sp-header-list-circle" :class="{ 'sp-circle-hover': list.hover }"></span>
                    </div>
                  </div>
                </a>
              </template>
            </div>
          </template>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      logOutLists: [{
        title: "Home",
        hover: false,
        path: "/",
        router: true,
      },
      {
        title: "Log In",
        hover: false,
        path: "/users/sign_in",
        method: "get",
      }, {
        title: "Sign In",
        hover: false,
        path: "/users/sign_up",
        method: "get",
      }, {
        title: "Guest Log In",
        hover: false,
        path: "/users/new_guest",
        method: "post"
      }],
      logInLists: [{
        title: "Main",
        hover: false,
        path: "/post_images/main",
        router: true,
      },
      {
        title: "Illust",
        hover: false,
        path: "/post_images",
        router: true,
      },
      {
        title: "User",
        hover: false,
        path: "/users",
        router: true,
      },
      {
        title: "Log Out",
        hover: false,
        path: "/",
        router: false,
        method: "delete",
      }]
    };
  },
  props: {
    isModal: {
      type: Boolean,
    },
    userLogIn: {
      type: Boolean
    }
  },
  methods: {
    modalClose() {
      this.$emit("modalClose");
    },
    mouseOverAction({ type: type, index: index }){
      if(type === "logOut") {
        this.logOutLists[index].hover = !this.logOutLists[index].hover
      }
      else {
        this.logInLists[index].hover = !this.logInLists[index].hover
      }
    },
    mouseLeaveAction({ type: type, index: index }){
      if(type === "logOut") {
        this.logOutLists[index].hover = !this.logOutLists[index].hover
      }
      else {
        this.logInLists[index].hover = !this.logInLists[index].hover
      }
    },
    openConfirm() {
      this.$emit("openConfirm");
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

.sp-header-modal {
  z-index: 1;
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(22, 22, 21, 0.9);
  justify-content: center;
}

.sp-header-menu {
  margin: 0 auto;
  width: 300px;
  position: absolute;
  top: 200px;
  left: 50%;
  transform: translateX(-50%);

  h2 {
    color: $font-white;
    font-size: 48px;
    animation-delay: .8s;
    text-align: center;
    font-weight: 900;
    margin-bottom: 40px;
  }
  li {
    font-size: 23px;
    color: $font-white;
    width: 80px;
  }
  a {
    color: $font-white;
  }
  .sp-header-list-link {
    cursor: pointer;
  }
  .sp-header-list {
    display: flex;
    align-items: center;
    margin-bottom: 15px;

    .sp-header-list-line {
      height: 1px;
      width: 30%;
      background-color: $font-white;
      margin-left: 30px;
      transition: all 1s;
    }
    .sp-line-hover {
      width: 60%;
    }
    .sp-header-list-circle {
      border: 1px solid $font-white;
      width: 20px;
      height: 20px;
      margin-left: auto;
      border-radius: 50%;
      transition: all .8s .5s;
    }
    .sp-circle-hover {
      background-color: $accent-color;
    }
  }
}
.sp-link--active {
  .sp-header-list-circle {
    background-color: $accent-color;
  }
}
</style>
