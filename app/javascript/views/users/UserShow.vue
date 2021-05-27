<template>
  <transition-group name="fade-list">
    <LoadingCompornent v-if="isLoading === true" key="loader"></LoadingCompornent>
    <div id="user-show" v-if="isLoading === false" key="noloader">
      <transition name="alert">
        <Alert :type="alertType.type" v-if="isAlert === true">
          {{ alertType.message }}
        </Alert>
      </transition>
      <div class="user-show-post-images">
        <Title title="投稿一覧"></Title>
        <div class="user-show-post-images-index">
          <template v-if="postImages.length">
            <PostImagesPaginate :postImages="postImages"></PostImagesPaginate>
          </template>
          <template v-else>
            <p class="no-content">現在表示できるコンテンツはありません。</p>
          </template>
        </div>
        <Title title="お気に入りした投稿一覧"></Title>
        <div class="user-show-post-images-favorite">
          <template v-if="favoriteImages.length">
            <PostImagesPaginate :postImages="favoriteImages"></PostImagesPaginate>
          </template>
          <template v-else>
            <p class="no-content">現在表示できるコンテンツはありません。</p>
          </template>
        </div>
        <Title title="フォローユーザーの投稿一覧"></Title>
        <div class="user-show-post-images-follower">
          <template v-if="followerImages.length">
            <PostImagesPaginate :postImages="followerImages"></PostImagesPaginate>
          </template>
          <template v-else>
            <p class="no-content">現在表示できるコンテンツはありません。</p>
          </template>
        </div>
      </div>
    </div>
  </transition-group>
</template>

<script>
import axios from "axios";
import LoadingCompornent from "../../components/parts/LoadingCompornent.vue";
import UserShowProfile from "../../components/UserShowProfile.vue";
import PostImages from "../../components/PostImages.vue";
import PostImagesPaginate from "../../components/PostImagesPaginate.vue";
import Title from "../../components/parts/Title.vue";
import Alert from "../../components/parts/Alert.vue";

export default {
  data() {
    return {
      postImages: [],
      favoriteImages: [],
      followerImages: [],
      isLoading: true,
      isAlert: false,
      alertType: {
        type: "",
        message: "",
      },
    };
  },
  props: {
    user: { type: Object, required: true }
  },
  methods: {
    async getInfo() {
      await axios.get("/api/v1/users/" + this.$route.params.id).then(
        (response) => {
          this.postImages = response.data.post_images;
          this.favoriteImages = response.data.favorite_images;
          this.followerImages = response.data.follower_images;
        },
        (error) => {
          console.log(error, response);
        }
      );
      this.isLoading = false;
    },
    deletePostImage() {
      this.alertType.type = "danger";
      this.alertType.message = "投稿を削除しました。";
      this.isAlert = true;
    },
    async deleteAlert() {
      await this.deletePostImage();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    async deletePostImageAfterGetInfo() {
      await this.getInfo();
      this.deleteAlert();
    }
  },
  mounted() {
    if(this.$route.query.method === "delete"){
      this.deletePostImageAfterGetInfo();
    }
    else{
      this.getInfo();
    }
  },
  components: {
    LoadingCompornent,
    PostImages,
    PostImagesPaginate,
    Title,
    Alert,
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

  .no-content {
    font-size: 16px;
    font-weight: bold;
    height: 200px;
    line-height: 200px;
  }
}
</style>
