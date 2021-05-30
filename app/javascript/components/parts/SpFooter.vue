<template>
  <div id="sp-footer">
    <div v-for="link in footerLinks" :key="link.name" class="sp-footer-links">
      <template v-if="link.router === true">
        <router-link :to="link.path" class="sp-footer-link">
          <i :class="link.class"></i>
        </router-link>
      </template>
      <template v-else-if="link.router === 'user'">
        <router-link :to="'/users/' + currentUserId" class="sp-footer-link">
          <i :class="link.class"></i>
        </router-link>
      </template>
      <template v-else>
        <span class="sp-footer-link" @click="modalOpen">
          <i :class="link.class"></i>
        </span>
      </template>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    currentUserId: {
      required: true,
    }
  },
  data() {
    return {
      footerLinks: [
        {
          name: "メインページ",
          path: "/post_images/main",
          class: "fas fa-home",
          router: true,
        },
        {
          name: "新規投稿",
          class: "fas fa-plus-circle",
          router: false,
        },
        {
          name: "マイページ",
          path: this.userPath,
          class: "fas fa-user",
          router: "user",
        },
      ]
    }
  },
  methods: {
    modalOpen() {
      this.$emit("modalOpen", "投稿する");
    }
  },
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#sp-footer {
  width: 100%;
  height: 50px;
  display: flex;
  align-items: center;
  background-color: $accent-color;
  justify-content: space-around;
  position: fixed;
  bottom: 0;

  .sp-footer-links {
    width: 100%;
    .sp-footer-link {
      display: block;
      margin: 0 auto;
      text-align: center;
      width: 80%;
      i {
        color: $font-white;
        font-size: 20px;
      }
    }
  }
}

</style>