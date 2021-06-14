<template>
  <transition-group name="fade">
    <Loading v-if="isLoading === true" key="loader"></Loading>
    <div id="user-request-result" v-if="isLoading === false" key="noloader">
      <transition name="alert">
        <Alert :type="alertType.type" v-if="isAlert === true">
          {{ alertType.message }}
        </Alert>
      </transition>
      <BackButton :link="backLink">
        一覧画面に戻る
      </BackButton>
      <div class="container">
        <template v-if="$route.name === 'request_done'">
          <template v-if="requestingUser.account_name">
            <h3>{{ requestingUser.account_name }}さんへの依頼が完成しました！</h3>
          </template>
          <template v-else>
            <h3>{{ requestingUser.user_name }}さんへの依頼が完成しました！</h3>
          </template>
        </template>

        <template v-if="$route.name === 'request_complete'">
          <template v-if="requestedUser.account_name">
            <h3>{{ requestedUser.account_name }}さんからの作品が到着しました！</h3>
          </template>
          <template v-else>
            <h3>{{ requestedUser.user_name }}さんからの作品が到着しました！</h3>
          </template>
        </template>

        <div class="request-result-images">
          <div
            v-for="requestImage in request.request_images"
            :key="requestImage.id"
            class="request-result-image"
          >
            <img :src="requestImage" alt="完成作品" />
          </div>
        </div>

        <template v-if="$route.name === 'request_complete'">
          <div class="request-result-delete-button">
            <button class="button" @click="openConfirm()">
              依頼を完了して削除する
            </button>
          </div>
        </template>
      </div>
      <Footer></Footer>
      <transition name="fade">
        <Confirm
          v-if="isConfirm === true"
          @falseAction="closeConfirm()"
          @successAction="requestComplete()"
        >
          <template>依頼を完了すると、完成した画像は削除されます。本当に依頼を完了してもいいですか？</template>
        </Confirm>
      </transition>
    </div>
  </transition-group>
</template>

<script>
import axios from "axios";
import Loading from "../../components/parts/Loading.vue";
import Alert from "../../components/parts/Alert.vue";
import BackButton from "../../components/parts/BackButton.vue";
import Confirm from "../../components/parts/Confirm.vue";
import Footer from "../../components/Footer.vue";

export default {
  data() {
    return {
      request: {},
      requestingUser: {},
      requestedUser: {},
      isLoading: true,
      isAlert: false,
      isConfirm: false,
      alertType: {
        type: "",
        message: "",
      },
    };
  },
  components: {
    Loading,
    Alert,
    BackButton,
    Footer,
    Confirm,
  },
  methods: {
    async getInfoRequestDone() {
      await axios
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
            this.$router.push("/errors");
          }
        );
      this.isLoading = false;
    },
    completeAlert() {
      this.alertType.type = "success";
      this.alertType.message = "依頼が完成しました！";
      this.isAlert = true;
    },
    async successcompleteAlert() {
      await this.completeAlert();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    async completeRequestImageGetInfoRequestDone() {
      await this.getInfoRequestDone();
      this.successcompleteAlert();
    },
    async getInfoRequestComplete() {
      await axios
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
          })
        .catch(
          (error) => {
            this.$router.push("/errors");
          });
      this.isLoading = false;
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
          this.$router.push({
            path: "/users/" + this.$route.params.user_id + "/requesting",
            query: { method: "complete" },
          });
        })
        .catch((error) => {
          this.$router.push("/errors");
        });
    },
    openConfirm() {
      this.isConfirm = true;
    },
    closeConfirm() {
      this.isConfirm = false;
    },
  },
  mounted() {
    if (this.$route.name === "request_done") {
      if(this.$route.query.method === "complete") {
        this.completeRequestImageGetInfoRequestDone();
      } else {
        this.isLoading = true;
        this.getInfoRequestDone();
      }
    } else if (this.$route.name === "request_complete") {
      this.isLoading = true;
      this.getInfoRequestComplete();
    }
  },
  computed: {
    backLink() {
      if(this.$route.name === "request_done") {
        return '/users/' + this.$route.params.user_id + '/requested'
      }
      else if(this.$route.name === "request_complete") {
        return '/users/' + this.$route.params.user_id + '/requesting'
      }
    }
  }
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

#user-request-result {
  margin-top: 150px;
  text-align: center;

  @include sp {
    margin-top: 180px;
  }

  .container {
    @include sp {
      min-height: 100vh;
    }
  }

  h3 {
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 50px;

    @include sp {
      font-size: 25px;
      margin-bottom: 30px;
    }
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

      @include sp {
        width: 80%;
      }
    }
  }

  .request-result-delete-button {
    margin-bottom: 50px;
  }
}
</style>
