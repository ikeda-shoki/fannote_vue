<template>
  <div id="post-image-show">
    <div class="container">
      <PostImageDetail
        :postImage="postImage"
        :accountName="user.account_name"
        :userName="user.user_name"
        :checkFavorite="postImage.checkFavorite"
        :favoriteCount="postImage.favoriteCount"
        @chengeFavorite="chengeFavorite">
      </PostImageDetail>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import PostImageDetail from '../../components/PostImageDetail.vue'

export default {
  data() {
    return {
      postImage: {},
      user: {},
    };
  },
  mounted() {
    axios.get("/api/v1/post_images/" + this.$route.params.id).then(
      (response) => {
        this.postImage = response.data.post_image;
        this.user = response.data.user;
      },
      (error) => {
        console.log(error, response);
      }
    );
  },
  components: {
    PostImageDetail,
  },
  methods: {
    chengeFavorite(value){
      this.postImage.checkFavorite = value[0];
      if(value[1] === "up") {
        this.postImage.favoriteCount += 1;
      } else if (value[1] === "down") {
        this.postImage.favoriteCount -= 1;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
#post-image-show {
  margin-top: 80px;
}
</style>
