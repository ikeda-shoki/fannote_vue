<template>
  <div id="user-show">
    <div class="container">
      <UserShowProfile :user="user" @userUpdate="getInfo"></UserShowProfile>
      <div class="user-show-post-images">
        <Title title="投稿一覧"></Title>
        <div class="user-show-post-images-index">
          <PostImages :user="user" :postImages="postImages"></PostImages>
        </div>
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
      user: {},
      postImages: [],
    };
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/users/" + this.$route.params.id).then(
        (response) => {
          this.user = response.data.user;
          this.postImages = response.data.post_images;
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
    UserShowProfile,
    PostImages,
    Title,
  },
  watch: {
    $route: "getInfo",
  },
};
</script>

<style lang="scss" scoped>
#user-show {
  margin-top: 80px;

  .container {
    display: flex;
  }

  #user-show-profile {
    width: 35%;
  }

  .user-show-post-images {
    width: 60%;
    margin-left: auto;
    text-align: center;

    /deep/ h2 {
      font-size: 30px;
      font-weight: bold;
    }

    &-index {
      margin-top: 40px;
    }
  }
}
</style>
