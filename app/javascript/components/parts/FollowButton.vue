<template>
  <div id="follow-button">
    <div>
      <button class="button" v-if="!user.follow_user" @click="follow">
        フォローする
      </button>
      <button class="button" v-if="user.follow_user" @click="unfollow">
        フォローを外す
      </button>
    </div>
  </div>
</template>

<script>
import axios from "axios"

export default {
  props: {
    user: {},
    currentUser: {},
  },
  methods: {
    follow() {
      axios({
        url: "/api/v1/follow/" + this.$route.params.id,
        method: "POST",
      }).then(response => {
        console.log(response.data);
        this.$emit("follow", value);
      }).catch(error => {
        console.log(error, response);
      })
    },
    unfollow() {
      axios({
        url: "/api/v1/follow/" + this.$route.params.id,
        method: "DELETE",
      }).then(response => {
        console.log(response.data);
        this.$emit("follow", value);
      }).catch(error => {
        console.log(error, response);
      })
    }
  }
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
