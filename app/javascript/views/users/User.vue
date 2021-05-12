<template>
  <div id="user">
    <div class="container">
      <div class="user-left">
        <UserShowProfile :user="user" :currenUserId="currentUser.id" @userUpdate="getInfo"></UserShowProfile>
      </div>
      <div class="user-right">
        <router-view :user="user"></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import UserShowProfile from "../../components/UserShowProfile.vue";

export default {
  props: {
    currentUser: { required: true }
  },
  data() {
    return {
      user: {},
    };
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/users/" + this.$route.params.id).then(
        (response) => {
          this.user = response.data.user;
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
  watch: {
    $route: "getInfo",
  },
}
</script>

<style lang="scss" scoped>
#user {
  margin-top: 80px;

  .container {
    display: flex;
  }

  .user-left {
    width: 35%;
    height: 100%;
  }

  .user-right {
    width: 60%;
    margin-left: auto;
    text-align: center;
  }
}
</style>