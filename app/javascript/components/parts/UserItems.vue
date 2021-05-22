<template>
  <div id="user-items">
    <div class="user-item-content">
      <div class="user-item">
        <h6>依頼数</h6>
        <span>0</span>
      </div>
      <div class="user-item">
        <h6>依頼達成数</h6>
        <span>{{ user.complete_request_count }}</span>
      </div>
      <div class="user-item">
        <h6>投稿</h6>
        <span>{{ user.user_post_image_count }}</span>
      </div>
      <div class="user-item">
        <router-link :to="'/users/' + this.$route.params.id + '/following'">
          <h6>フォロー</h6>
          <span>{{ user.follower_count }}</span>
        </router-link>
      </div>
      <div class="user-item">
        <router-link :to="'/users/' + this.$route.params.id + '/followed'">
          <h6>フォロワー</h6>
          <transition name="fade-list" type="out-in">
            <span :key="user.followed_count">{{ user.followed_count }}</span>
          </transition>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    user: { required: true },
  },
};
</script>

<style lang="scss" scoped>
#user-items {
  width: 100%;

  .user-item-content {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-around;

    .user-item {
      width: 30%;

      h6 {
        font-size: 11px;
      }
      span {
        font-size: 18px;
      }
    }
  }
}
</style>
