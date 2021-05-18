<template>
  <div id="user-request-result">
    <div class="container">
      <template v-if="$route.name === 'request_done'">
        <template v-if="requestingUser.account_name">
          <h3>
            {{ requestingUser.account_name }}への依頼が完成しました！
          </h3>
        </template>
        <template v-else>
          <h3>
            {{ requestingUser.user_name }}への依頼が完成しました！
          </h3>
        </template>
      </template>

      <template v-if="$route.name === 'request_complete'">
        <template v-if="requestedUser.account_name">
          <h3>
            {{ requestedUser.account_name }}からの作品が到着しました！
          </h3>
        </template>
        <template v-else>
          <h3>
            {{ requestedUser.user_name }}からの作品が到着しました！
          </h3>
        </template>
      </template>

      <div class="request-result-images">
        <div v-for="requestImage in request.request_images" :key="requestImage.id" class="request-result-image">
          <img :src="requestImage" alt="完成作品">
        </div>
      </div>

      <template v-if="$route.name === 'request_complete'">
        <div class="request-result-delete-button">
          <button class="button" @click="requestComplete()">依頼を完了して削除する</button>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      request: {},
      requestingUser: {},
      requestedUser: {},
    };
  },
  methods: {
    getInfoRequestDone() {
      axios
        .get(
          "/api/v1/users/" +
            this.$route.params.user_id +
            "/requests/" +
            this.$route.params.id +
            "/request_done"
        )
        .then(
          (response) => {
            this.request = response.data.request;
            this.requestingUser = response.data.request.requesting_user;
            this.requestedUser = response.data.request.requested_user;
          },
          (error) => {
            console.log(error, response);
          }
        );
    },
    getInfoRequestComplete() {
      axios
        .get(
          "/api/v1/users/" +
            this.$route.params.user_id +
            "/requests/" +
            this.$route.params.id +
            "/request_complete"
        )
        .then(
          (response) => {
            this.request = response.data.request;
            this.requestingUser = response.data.request.requesting_user;
            this.requestedUser = response.data.request.requested_user;
          },
          (error) => {
            console.log(error, response);
          }
        );
    },
    requestComplete() {
      axios({
        url:
          "/api/v1/users/" +
          this.$route.params.user_id +
          "/requests/" +
          this.$route.params.id,
        method: "DELETE",
      })
        .then((response) => {
          this.$router.push("/users/" + this.$route.params.user_id + "/requesting");
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  mounted() {
    if (this.$route.name === "request_done") {
      this.getInfoRequestDone();
    } else if (this.$route.name === "request_complete") {
      this.getInfoRequestComplete();
    }
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#user-request-result {
  margin-top: 80px;
  text-align: center;

  h3 {
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 50px;
  }

  .request-result-image {
    display: inline-block;
    border: solid 1px $accent-color;
    background-color: $back-ground-color;
    box-shadow: 0 0 8px gray;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;

    img {
      width: 500px;
      height: auto;
    }
  }

  .request-result-delete-button {
    margin-bottom: 50px;
  }
}
</style>
