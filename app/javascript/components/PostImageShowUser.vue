<template>
  <div id="post-image-show-user">
    <div class="post-image-show-user-top">
      <CircleImage :image="user.profile_image"></CircleImage>
      <h3 v-if="user.account_name">
        {{ user.account_name }}
      </h3>
      <h3 v-else>
        {{ user.user_name }}
      </h3>
      <UserItems :user="user"></UserItems>
    </div>

    <div class="post-image-show-user-middle">
      <FollowButton
        v-if="!user.current_user_same_as"
        :user="user"
        @follow="follow"
        @unfollow="unfollow"
      ></FollowButton>
      <router-link :to="'/users/' + user.id">
        <button class="button">プロフィールへ</button>
      </router-link>
    </div>

    <div class="post-image-show-user-bottom">
      <h5>New</h5>
      <div class="post-image-show-profile-images">
        <div
          class="post-image-show-profile-image"
          v-for="postImage in user.post_images"
          :key="postImage.id"
        >
          <router-link :to="'/post_images/' + postImage.id">
            <img :src="postImage.post_image" alt="投稿画像" />
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import UserItems from "./parts/UserItems.vue";
import CircleImage from "./parts/CircleImage.vue";
import FollowButton from "./parts/FollowButton.vue";

export default {
  props: {
    user: { type: Object, required: true },
    currentUser: { type: Object },
  },
  components: {
    UserItems,
    CircleImage,
    FollowButton,
  },
  methods: {
    follow(value) {
      this.$emit("follow", value);
    },
    unfollow(value) {
      this.$emit("unfollow", value);
    }
  }
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#post-image-show-user {
  background-color: $font-white;
  text-align: center;
  border-radius: 20px;
  padding: 50px 20px;

  .post-image-show-user-top {
    padding-bottom: 30px;
    border-bottom: 3px dashed;

    #circle-image {
      /deep/ img {
        width: 180px;
        height: 180px;
      }
    }

    h3 {
      margin: 10px 0 30px;
    }
  }

  .post-image-show-user-middle {
    margin-top: 30px;
    padding-bottom: 30px;
    border-bottom: 3px dashed;
    display: flex;
    align-items: center;
    justify-content: center;

    #follow-button {
      margin-right: 10px;
    }

    .button {
      min-width: auto;
      font-size: 10px;
    }
  }

  .post-image-show-user-bottom {
    margin: 30px 0 0;

    .post-image-show-profile-images {
      display: flex;
      align-items: center;
      justify-content: space-around;
      flex-wrap: wrap;
      height: 220px;
      overflow: scroll;
      -ms-overflow-style: none;
      scrollbar-width: none;

      &::-webkit-scrollbar {
        display: none;
      }

      .post-image-show-profile-image {
        img {
          border-radius: 10px;
          width: 100px;
          height: 100px;
          object-fit: cover;
        }
      }
    }
  }
}
</style>
