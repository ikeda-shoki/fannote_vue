<template>
  <div id="post-image-show">
    <div class="container">
      <PostImageDetail
        :postImage="postImage"
        :accountName="user.account_name"
        :userName="user.user_name">
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
  }
};
</script>

<style lang="scss" scoped>
#post-image-show {
  margin-top: 80px;
}
</style>
