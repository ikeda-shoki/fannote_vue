<template>
  <div id="main">
    <div class="container">
      <h2>人気の作品</h2>
      <div class="favorite-images">
        <div
          class="ranking-post-image"
          v-for="rankingImage in rankingImages"
          :key="rankingImage.id"
        >
          <PostImage
            :id="rankingImage.id"
            :image="rankingImage.post_image"
            :title="rankingImage.title"
            :userName="rankingImage.user.user_name"
            :accountName="rankingImage.user.account_name"
          ></PostImage>
        </div>
      </div>

      <h2>新着作品</h2>
      <div class="new-post-images">
        <div
          class="post-image"
          v-for="postImage in postImages"
          :key="postImage.id"
        >
          <PostImage
            :id="postImage.id"
            :image="postImage.post_image"
            :title="postImage.title"
            :userName="postImage.user.user_name"
            :accountName="postImage.user.account_name"
          ></PostImage>
        </div>
      </div>

      <h2>イラストの人気作品</h2>
      <div class="new-post-images">
        <div
          class="post-image"
          v-for="rankingIllustImage in rankingIllustImages"
          :key="rankingIllustImage.id"
        >
          <PostImage
            :id="rankingIllustImage.id"
            :image="rankingIllustImage.post_image"
            :title="rankingIllustImage.title"
            :userName="rankingIllustImage.user.user_name"
            :accountName="rankingIllustImage.user.account_name"
          ></PostImage>
        </div>
      </div>

      <h2>写真の人気作品</h2>
      <div class="new-post-images">
        <div
          class="post-image"
          v-for="rankingPhotoImage in rankingPhotoImages"
          :key="rankingPhotoImage.id"
        >
          <PostImage
            :id="rankingPhotoImage.id"
            :image="rankingPhotoImage.post_image"
            :title="rankingPhotoImage.title"
            :userName="rankingPhotoImage.user.user_name"
            :accountName="rankingPhotoImage.user.account_name"
          ></PostImage>
        </div>
      </div>

      <h2>ロゴの人気作品</h2>
      <div class="new-post-images">
        <div
          class="post-image"
          v-for="rankingLogoImage in rankingLogoImages"
          :key="rankingLogoImage.id"
        >
          <PostImage
            :id="rankingLogoImage.id"
            :image="rankingLogoImage.post_image"
            :title="rankingLogoImage.title"
            :userName="rankingLogoImage.user.user_name"
            :accountName="rankingLogoImage.user.account_name"
          ></PostImage>
        </div>
      </div>

      <h2>フォローユーザーの新着作品</h2>
      <div class="new-post-images">
        <div
          class="post-image"
          v-for="followingUserImage in followingUserImages"
          :key="followingUserImage.id"
        >
          <PostImage
            :id="followingUserImage.id"
            :image="followingUserImage.post_image"
            :title="followingUserImage.title"
            :userName="followingUserImage.user.user_name"
            :accountName="followingUserImage.user.account_name"
          ></PostImage>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import PostImage from "../../components/parts/PostImage.vue";

export default {
  data() {
    return {
      postImages: [],
      followingUserImages: [],
      rankingImages: [],
      rankingIllustImages: [],
      rankingPhotoImages: [],
      rankingLogoImages: [],
    };
  },
  mounted() {
    this.getPostImages();
  },
  methods: {
    getPostImages() {
      axios.get("/api/v1/post_images/main").then(
        (response) => {
          this.postImages = response.data.post_images;
          this.followingUserImages = response.data.following_user_images;
          this.rankingImages = response.data.ranking_images;
          this.rankingIllustImages = response.data.ranking_illust_images;
          this.rankingPhotoImages = response.data.ranking_photo_images;
          this.rankingLogoImages = response.data.ranking_logo_images;
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
  },
  components: {
    PostImage,
  },
  props: {
    userLogIn: { type: Boolean },
  },
};
</script>

<style lang="scss" scoped>
#main {
  padding-top: 10%;

  h2 {
    font-size: 30px;
    font-weight: bold;
  }

  .favorite-images,
  .new-post-images {
    display: flex;
    flex-wrap: wrap;
    width: 95%;
    margin: 0 auto;
    flex-wrap: nowrap;
    overflow: hidden;

    /deep/ #post-image {
      margin-right: 15px;
    }
  }
}
</style>
