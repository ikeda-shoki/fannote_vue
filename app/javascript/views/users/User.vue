<template>
  <transition-group name="fade">
    <Loading v-if="isLoading === true" key="loader"></Loading>
    <div id="user" v-if="isLoading === false" key="noLoader">
      <transition name="alert">
        <Alert :type="alertType.type" v-if="isAlert === true">
          {{ alertType.message }}
        </Alert>
      </transition>
      <div class="container">
        <div class="user-left">
          <UserShowProfile
            :user="user"
            :currenUserId="currentUser.id"
            @userUpdate="successUserUpdate"
          ></UserShowProfile>
        </div>
        <div class="user-right">
          <router-view :user="user"></router-view>
        </div>
      </div>
    </div>
  </transition-group>
</template>

<script>
import axios from "axios";
import UserShowProfile from "../../components/UserShowProfile.vue";
import Loading from "../../components/parts/Loading.vue";
import Alert from "../../components/parts/Alert.vue";

export default {
  props: {
    currentUser: { required: true },
  },
  data() {
    return {
      user: {},
      isLoading: true,
      isAlert: false,
      alertType: {
        type: "",
        message: "",
      },
    };
  },
  methods: {
    async getInfo() {
      await axios.get("/api/v1/users/" + this.$route.params.id).then(
        (response) => {
          this.user = response.data.user;
        },
        (error) => {
          console.log(error, response);
        }
      );
      this.isLoading = false;
    },
    updateAlert() {
      this.alertType.type = "success";
      this.alertType.message = "ユーザー情報を更新しました！";
      this.isAlert = true;
    },
    async successUpdateAlert(){
      await this.updateAlert();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    async successUserUpdate() {
      await this.getInfo()
      this.successUpdateAlert();
    },
  },
  created() {
    this.getInfo();
  },
  components: {
    UserShowProfile,
    Loading,
    Alert,
  },
  watch: {
    $route: "getInfo",
  },
};
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
