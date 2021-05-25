<template>
  <transition-group name="fade">
    <Loading v-if="isLoading === true" key="loader"></Loading>
    <div id="user-follow-index" v-if="isLoading === false" key="noloader">
      <template v-if="$route.name === 'following'">
        <Title title="フォローリスト"></Title>
        <div class="user-following-users">
          <template v-for="user in followingUser">
            <UserItem :user="user" :key="user.id"></UserItem>
          </template>
        </div>
      </template>
      <template v-if="$route.name === 'followed'">
        <Title title="フォロワーリスト"></Title>
        <div class="user-followed-users">
          <template v-for="user in followedUser">
            <UserItem :user="user" :key="user.id"></UserItem>
          </template>
        </div>
      </template>
    </div>
  </transition-group>
</template>

<script>
import axios from 'axios'
import Loading from "../../components/parts/Loading.vue";
import Title from "../../components/parts/Title.vue";
import UserItem from "../../components/parts/UserItem.vue";

export default {
  data() {
    return {
      followingUser: [],
      followedUser: [],
      isLoading: true,
    }
  },
  components: {
    Title,
    UserItem,
    Loading,
  },
  methods: {
    async getInfoFollowing() {
      await axios.get("/api/v1/users/" + this.$route.params.id + "/following").then(
        (response) => {
          this.followingUser = response.data.following_users;
        },
        (error) => {
          this.$router.push("/post_images/main");
        }
      );
      this.isLoading = false;
    },
    async getInfoFollowed() {
      await axios.get("/api/v1/users/" + this.$route.params.id + "/followed").then(
        (response) => {
          this.followedUser = response.data.followed_users;
        },
        (error) => {
          this.$router.push("/post_images/main");
        }
      );
      this.isLoading = false;
    }
  },
  mounted() {
    if (this.$route.name === "following") {
      this.getInfoFollowing();
    }
    if (this.$route.name === "followed") {
      this.getInfoFollowed();
    }
  },
  watch: {
    $route: function(to, from) {
      if (to.name === "following") {
        this.isLoading = true;
        this.getInfoFollowing();
      }
      if (to.name === "followed") {
        this.isLoading = true;
        this.getInfoFollowed();
      }
    },
  },
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#user-follow-index {
  /deep/ #title {
    font-size: 30px;

    margin-bottom: 50px;
    h2 {
      font-weight: bold;
    }
  }

  .user-following-users,
  .user-followed-users {
    .user-item {
      /deep/ #title {
        font-size: 24px;
        margin-bottom: 15px;
      }
    }
  }
}

</style>