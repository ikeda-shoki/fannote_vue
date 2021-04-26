<template>
  <div id="app">
    <Header></Header>
    <transition name="fade" mode="out-in">
      <router-view></router-view>
    </transition>
  </div>
</template>

<script>
import Header from './components/Header.vue'

export default {
  components: {
    Header
  },
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style lang="scss">
  $accent-color: #e65b20;
  $back-ground-color: #f7f4f2;
  $font-color: #3e1300;
  $font-white: #FFFFFE;

  .hover {
    background-color: $accent-color;

    a {
      color: $font-white;
      font-weight: bold;
    }
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

  .slide-enter {
    transform: translate(-100px, 0);
    opacity: 0;
  }

  .slide-enter-active {
    transition: all 1s ease;
  }

  .slide-leave {
    transform: translate( 0, 0);
  }

  .slide-leave-to {
    transform: translate(100px, 0);
    opacity: 0;
  }

  .slide-leave-active {
    transition: all 1s ease;
  }
</style>
