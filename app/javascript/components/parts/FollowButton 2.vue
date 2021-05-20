<template>
  <div id="follow-button">
    <div>
      <transition-group name="fade-list" type="out-in">
        <button class="button" v-if="!user.follower" @click="follow" key="follow">
          フォローする
        </button>
        <button class="button" v-if="user.follower" @click="unfollow" key="unfollow">
          フォローを外す
        </button>
      </transition-group>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    user: {},
    currentUser: {},
  },
  methods: {
    follow() {
      axios({
        url: "/api/v1/follow/" + this.user.id,
        method: "POST",
      })
        .then((response) => {
          this.$emit("follow", response.data);
        })
        .catch((error) => {
          console.log(error, response);
        });
    },
    unfollow() {
      axios({
        url: "/api/v1/follow/" + this.user.id,
        method: "DELETE",
      })
        .then((response) => {
          this.$emit("unfollow", response.data);
        })
        .catch((error) => {
          console.log(error, response);
        });
    },
  },
};
</script>

<style lang="scss" scoped>
#follow-button {
  .button {
    min-width: auto;
    font-size: 10px;
  }
}
</style>
