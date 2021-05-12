<template>
  <div id="user-show">
    <div class="user-show-post-images">
      <Title title="投稿一覧"></Title>
      <div class="user-show-post-images-index">
        <PostImages :postImages="postImages"></PostImages>
      </div>
      <Title title="お気に入りした投稿一覧"></Title>
      <div class="user-show-post-images-favorite">
        <PostImages :postImages="favoriteImages"></PostImages>
      </div>
      <Title title="フォローユーザーの投稿一覧"></Title>
      <div class="user-show-post-images-follower">
        <PostImages :postImages="followerImages"></PostImages>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import UserShowProfile from "../../components/UserShowProfile.vue";
import PostImages from "../../components/PostImages.vue";
import Title from "../../components/parts/Title.vue";

export default {
  data() {
    return {
      postImages: [],
      favoriteImages: [],
      followerImages: [],
    };
  },
  props: {
    user: { type: Object, required: true }
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/users/" + this.$route.params.id).then(
        (response) => {
          this.postImages = response.data.post_images;
          this.favoriteImages = response.data.favorite_images;
          this.followerImages = response.data.follower_images;
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
  },
  created() {
    this.getInfo();
  },
  components: {
    PostImages,
    Title,
  },
};
</script>

<style lang="scss" scoped>
#user-show {
  .user-show-post-images {
    #post-images {
      margin-bottom: 30px;
    }

    /deep/ h2 {
      font-size: 30px;
      font-weight: bold;
    }

    &-index {
      margin-top: 30px;
    }

    &-favorite {
      margin-top: 30px;
    }

    &-follower {
      margin-top: 30px;
    }
  }
}
</style>
