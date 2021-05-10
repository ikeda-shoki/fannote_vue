<template>
  <div id="post-image-show">
    <div class="container">
      <div class="post-image-show-left">
        <PostImageDetail
          :postImage="postImage"
          :user="user"
          @chengeFavorite="chengeFavorite"
          @update="getInfo"
        >
        </PostImageDetail>
        <form class="post-image-comment" v-on:submit.prevent="postImageComment">
          <CommentForm
            v-model="post_comment.comment"
            id="post-image-comment"
            type="text"
            name="post-image-comment"
            placeholder="コメントを入力できます"
          ></CommentForm>
          <FormButton buttonName="送信"></FormButton>
        </form>
        <PostImageComments
          :postComments="post_comments"
          :userLogIn="userLogIn"
          @postCommentDelete="postCommentDelete"
        ></PostImageComments>
      </div>
      <div class="post-image-show-right">
        <PostImageShowUser
          :user="user"
          :currentUser="currentUser"
          @follow="followUp"
          @unfollow="followDown"
        ></PostImageShowUser>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import PostImageDetail from "../../components/PostImageDetail.vue";
import CommentForm from "../../components/form/CommetForm.vue";
import FormButton from "../../components/form/FormButton.vue";
import PostImageComments from "../../components/PostImageComments.vue";
import PostImageShowUser from "../../components/PostImageShowUser.vue";

export default {
  data() {
    return {
      postImage: {},
      user: {},
      post_comment: {
        comment: "",
      },
      post_comments: [],
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
  },
  methods: {
    chengeFavorite(value) {
      this.postImage.check_favorite = value[0];
      if (value[1] === "up") {
        this.postImage.favorite_count += 1;
      } else if (value[1] === "down") {
        this.postImage.favorite_count -= 1;
      }
    },
    getInfo() {
      axios.get("/api/v1/post_images/" + this.$route.params.id).then(
        (response) => {
          this.postImage = response.data.post_image;
          this.user = response.data.user;
          this.post_comments = response.data.post_comments;
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
    postImageComment() {
      axios({
        url: "/api/v1/post_images/" + this.$route.params.id + "/post_comments",
        data: {
          post_comment: this.post_comment,
        },
        method: "POST",
      })
        .then((response) => {
          this.post_comment.comment = "";
          this.post_comments.unshift(response.data);
          this.getInfo();
        })
        .catch((error) => {
          console.log(error, response);
        });
    },
    postCommentDelete(value) {
      this.post_comments = value;
    },
    followUp(value) {
      this.user.followed_count = value;
      this.user.follower = true;
    },
    followDown(value) {
      this.user.followed_count = value;
      this.user.follower = false;
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

#post-image-show {
  margin: 80px 0;

  .container {
    display: flex;
  }

  .post-image-comment {
    margin: 50px 0;
    background-color: $font-white;
    border-radius: 20px;
    padding: 30px;
    display: flex;
    align-items: center;
    justify-content: space-between;

    #comment-form {
      width: 80%;
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
  }

  .post-image-show-right {
    width: 30%;
    margin-left: auto;
  }
}
</style>
