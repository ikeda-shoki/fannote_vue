<template>
  <div id="user-follow-index">
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
</template>

<script>
import axios from 'axios'
import Title from "../../components/parts/Title.vue";
import UserItem from "../../components/parts/UserItem.vue";

export default {
  data() {
    return {
      followingUser: [],
      followedUser: [],
    }
  },
  components: {
    Title,
    UserItem,
  },
  methods: {
    getInfoFollowing() {
      axios.get("/api/v1/users/" + this.$route.params.id + "/following").then(
        (response) => {
          this.followingUser = response.data.following_users;
        },
        (error) => {
          this.$router.push("/post_images/main");
        }
      );
    },
    getInfoFollowed() {
      axios.get("/api/v1/users/" + this.$route.params.id + "/followed").then(
        (response) => {
          this.followedUser = response.data.followed_users;
        },
        (error) => {
          this.$router.push("/post_images/main");
        }
      );
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
        this.getInfoFollowing();
      }
      if (to.name === "followed") {
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