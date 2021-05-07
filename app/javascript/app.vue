<template>
  <div id="app">
    <Header
      :userLogIn="currentUser.signIn"
      :currentUser="currentUser.curretUser"
    ></Header>
    <transition name="fade" mode="out-in">
      <router-view :userLogIn="currentUser.signIn"></router-view>
    </transition>
  </div>
</template>

<script>
import Header from "./components/Header.vue";
import axios from "axios";

export default {
  components: {
    Header,
  },
  data: function() {
    return {
      currentUser: {},
    };
  },
  mounted() {
    axios.get("/api/v1/users/sign_in").then((response) => {
      this.currentUser = response.data;
    });
  },
};
</script>

<style lang="scss">
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

.hover {
  background-color: $accent-color;
  color: $font-white;
  font-weight: bold;

  i {
    color: $font-white;
  }
}

.require-icon {
  padding: 5px 10px;
  background-color: $danger-color;
  color: $font-white;
  font-size: 10px;
  font-weight: bold;
  border-radius: 5px;
  margin-left: 10px;
}

//transition
.fade-enter {
  opacity: 0;
}

.fade-enter-active {
  transition: opacity 1s;
}

.fade-leave-active {
  transition: opacity 1s;
}

.fade-leave-to {
  opacity: 0;
}

.fade-list-move {
  transition: all 0.6s;
}

.fade-list-enter {
  opacity: 0;
}

.fade-list-enter-active {
  transition: all 0.6s;
}

.fade-list-leave-active {
  transition: all 0.6s;
  position: absolute;
}

.fade-list-leave-to {
  opacity: 0;
}

.slide-enter {
  transform: translate(-100px, 0);
  opacity: 0;
}

.slide-enter-active {
  transition: all 1s ease;
}

.slide-leave {
  transform: translate(0, 0);
}

.slide-leave-to {
  transform: translate(100px, 0);
  opacity: 0;
}

.slide-leave-active {
  transition: all 1s ease;
}
</style>
