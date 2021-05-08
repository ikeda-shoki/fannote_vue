<template>
  <div id="user-show">
    <div class="container">
      <UserShowProfile :user="user" @userUpdate="getInfo"></UserShowProfile>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import UserShowProfile from "../../components/UserShowProfile.vue";

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
}
</style>
