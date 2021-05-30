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
            @follow="followUp"
            @unfollow="followDown"
          ></UserShowProfile>
        </div>
        <div class="user-right">
          <router-view :user="user"></router-view>
        </div>
      </div>
      <Footer></Footer>
    </div>
  </transition-group>
</template>

<script>
import axios from "axios";
import UserShowProfile from "../../components/UserShowProfile.vue";
import Loading from "../../components/parts/Loading.vue";
import Alert from "../../components/parts/Alert.vue";
import Footer from "../../components/Footer.vue"

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
    follow(value) {
      this.user.followed_count = value;
      this.user.follower = true;
      this.alertType.type = "success";
      if(this.user.account_name){
        this.alertType.message = this.user.account_name + "さんをフォローしました！";
      }
      else {
        this.alertType.message = this.user.user_name + "さんをフォローしました！";
      }
      this.isAlert = true;
    },
    async followUp(value) {
      await this.follow(value);
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    unfollow (value) {
      this.user.followed_count = value;
      this.user.follower = false;
      this.alertType.type = "danger";
      if(this.user.account_name){
        this.alertType.message = this.user.account_name + "さんのフォローを外しました。";
      }
      else {
        this.alertType.message = this.user.user_name + "さんのフォローを外しました。";
      }
      this.isAlert = true;
    },
    async followDown(value) {
      await this.unfollow(value);
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
  },
  created() {
    this.getInfo();
  },
  components: {
    UserShowProfile,
    Loading,
    Alert,
    Footer,
  },
  watch: {
    $route: "getInfo",
  },
};
</script>

<style lang="scss" scoped>
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

#user {
  margin-top: 80px;

  .container {
    display: flex;
    padding-bottom: 50px;

    @include sp {
      flex-direction: column;
    }
  }

  .user-left {
    width: 35%;
    height: 100%;

    @include sp {
      width: 100%;
      margin-bottom: 100px;
    }
  }

  .user-right {
    width: 60%;
    margin-left: auto;
    text-align: center;

    @include sp {
      width: 100%;
    }
  }
}
</style>
