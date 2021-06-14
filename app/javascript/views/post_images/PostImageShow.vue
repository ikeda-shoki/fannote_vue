<template>
  <transition-group name="fade">
    <Loading v-if="isLoading === true" key="loader"></Loading>
    <div id="post-image-show" v-if="isLoading === false" key="noloader">
      <transition name="alert">
        <Alert :type="alertType.type" v-if="isAlert === true">
          {{ alertType.message }}
        </Alert>
      </transition>
      <div class="container">
        <div class="post-image-show-left">
          <PostImageDetail
            :postImage="postImage"
            :user="postImage.user"
            @chengeFavorite="chengeFavorite"
            @postImageUpdate="updatePostImage"
          >
          </PostImageDetail>
          <form
            class="post-image-comment"
            v-on:submit.prevent="postImageComment"
          >
            <div class="post-image-comment-form">
              <CommentForm
                v-model="post_comment.comment"
                id="post-image-comment"
                type="text"
                name="post-image-comment"
                placeholder="コメントを入力できます"
              ></CommentForm>
              <FormButton buttonName="送信"></FormButton>
            </div>
            <div class="post-image-comment-error">
              <ErrorMessage
                v-if="errorMessage.comment"
                :message="errorMessage.comment"
              ></ErrorMessage>
            </div>
          </form>
          <PostImageComments
            :postComments="post_comments"
            @postCommentDelete="postCommentDelete"
          ></PostImageComments>
        </div>
        <div class="post-image-show-right">
          <PostImageShowUser
            :user="postImage.user"
            :currentUser="currentUser"
            @follow="followUp"
            @unfollow="followDown"
          ></PostImageShowUser>
        </div>
      </div>
      <Footer></Footer>
    </div>
  </transition-group>
</template>

<script>
import axios from "axios";
import PostImageDetail from "../../components/PostImageDetail.vue";
import CommentForm from "../../components/form/CommetForm.vue";
import FormButton from "../../components/form/FormButton.vue";
import PostImageComments from "../../components/PostImageComments.vue";
import PostImageShowUser from "../../components/PostImageShowUser.vue";
import Loading from "../../components/parts/Loading.vue";
import Alert from "../../components/parts/Alert.vue";
import ErrorMessage from "../../components/form/ErrorMessage.vue";
import Footer from "../../components/Footer.vue";

export default {
  data() {
    return {
      postImage: {},
      post_comment: {
        comment: "",
      },
      post_comments: [],
      isLoading: true,
      isAlert: false,
      alertType: {
        type: "",
        message: "",
      },
      errorMessage: {},
    };
  },
  props: {
    userLogIn: { type: Boolean },
    currentUser: { type: Object },
  },
  mounted() {
    this.getInfo();
  },
  components: {
    PostImageDetail,
    CommentForm,
    FormButton,
    PostImageComments,
    PostImageShowUser,
    Loading,
    Alert,
    ErrorMessage,
    Footer,
  },
  methods: {
    upFavorite() {
      this.postImage.favorite_count += 1;
      this.alertType.type = "success";
      this.alertType.message = "いいねを押しました！";
      this.isAlert = true;
    },
    deleteFavorite() {
      this.postImage.favorite_count -= 1;
      this.alertType.type = "danger";
      this.alertType.message = "いいねを取り消しました。";
      this.isAlert = true;
    },
    async chengeFavorite(value) {
      this.postImage.check_favorite = value[0];
      if (value[1] === "up") {
        await this.upFavorite();
        setTimeout(() => {
          this.isAlert = false;
        }, 3000);
      } else if (value[1] === "down") {
        await this.deleteFavorite();
        setTimeout(() => {
          this.isAlert = false;
        }, 3000);
      }
    },
    async getInfo() {
      await axios.get("/api/v1/post_images/" + this.$route.params.id)
        .then((response) => {
          this.postImage = response.data.post_image;
          this.post_comments = response.data.post_comments;
        })
        .catch((error) => {
          this.$router.push("/errors");
        });
      this.isLoading = false;
    },
    createComment(response) {
      this.post_comment.comment = "";
      this.post_comments.unshift(response.data);
      this.alertType.type = "success";
      this.alertType.message = "メッセージを送信しました！";
      this.isAlert = true;
    },
    postImageComment() {
      axios({
        url: "/api/v1/post_images/" + this.$route.params.id + "/post_comments",
        data: {
          post_comment: this.post_comment,
        },
        method: "POST",
      })
        .then(async (response) => {
          await this.createComment(response);
          this.getInfo();
          setTimeout(() => {
            this.isAlert = false;
          }, 3000);
        })
        .catch((error) => {
          this.errorMessage = error.response.data;
          console.log(error.response.data);
        });
    },
    commentDelete() {
      this.alertType.type = "danger";
      this.alertType.message = "メッセージを削除しました。";
      this.isAlert = true;
    },
    async postCommentDelete(value) {
      await this.commentDelete();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    follow(value) {
      this.postImage.user.followed_count = value;
      this.postImage.user.follower = true;
      this.alertType.type = "success";
      if(this.postImage.user.account_name){
        this.alertType.message = this.postImage.user.account_name + "さんをフォローしました！";
      }
      else {
        this.alertType.message = this.postImage.user.user_name + "さんをフォローしました！";
      }
      this.isAlert = true;
    },
    async followUp(value) {
      await this.follow(value);
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    unfollow(value) {
      this.postImage.user.followed_count = value;
      this.postImage.user.follower = false;
      this.alertType.type = "danger";
      if(this.postImage.user.account_name){
        this.alertType.message = this.postImage.user.account_name + "さんのフォローを外しました。";
      }
      else {
        this.alertType.message = this.postImage.user.user_name + "さんのフォローを外しました。";
      }
      this.isAlert = true;
    },
    async followDown(value) {
      await this.unfollow(value);
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    alertUpdate() {
      this.alertType.type = "success";
      this.alertType.message = "投稿を更新しました！";
      this.isAlert = true;
      this.getInfo();
    },
    async updatePostImage() {
      await this.alertUpdate();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    }
  },
  watch: {
    $route: "getInfo",
  },
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

#post-image-show {
  margin: 80px 0 0;

  .container {
    display: flex;
    padding-bottom: 50px;
  }

  .post-image-comment {
    margin: 50px 0;
    background-color: $font-white;
    border-radius: 20px;
    padding-bottom: 30px;

    .post-image-comment-form {
      padding: 30px 30px 20px 30px;
      display: flex;
      align-items: center;
      justify-content: space-between;

      @include sp {
        flex-direction: column;

        /deep/ #form-button {
          width: auto;

          .button {
            width: 100%;
            margin-top: 10px;
          }
        }
      }
    }

    #error-message {
      width: 80%;
      margin-left: 30px;
    }

    #comment-form {
      width: 80%;

      @include sp {
        width: 100%;
      }
    }

    #form-button {
      width: 20%;
      text-align: right;

      /deep/ .button {
        min-width: auto;
        padding: 8px 25px;
      }
    }
  }

  .post-image-show-left {
    width: 65%;

    @include sp {
      width: 100%;
    }
  }

  .post-image-show-right {
    width: 30%;
    margin-left: auto;

    @include sp {
      display: none;
    }
  }
}
</style>
