<template>
  <div id="app">
    <Header></Header>
    <router-view></router-view>
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
</style>
