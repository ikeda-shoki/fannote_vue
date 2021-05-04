<template>
  <div id="post-image-show">
    <div class="container">
      <PostImageDetail
        :postImage="postImage"
        :accountName="user.account_name"
        :userName="user.user_name"
        :checkFavorite="postImage.checkFavorite"
        :favoriteCount="postImage.favoriteCount"
        @chengeFavorite="chengeFavorite">
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
      <PostImageComments :postComments="post_comments" :userLogIn="userLogIn" @postCommentDelete="postCommentDelete"></PostImageComments>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import PostImageDetail from '../../components/PostImageDetail.vue'
import CommentForm from '../../components/form/CommetForm.vue'
import FormButton from '../../components/form/FormButton.vue'
import PostImageComments from '../../components/PostImageComments.vue'

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
    userLogIn: { type: Boolean }
  },
  mounted() {
    this.getInfo();
  },
  components: {
    PostImageDetail,
    CommentForm,
    FormButton,
    PostImageComments,
  },
  methods: {
    chengeFavorite(value){
      this.postImage.checkFavorite = value[0];
      if(value[1] === "up") {
        this.postImage.favoriteCount += 1;
      } else if (value[1] === "down") {
        this.postImage.favoriteCount -= 1;
      }
    },
    getInfo(){
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
          post_comment: this.post_comment
        },
        method: "POST",
      }).then(response => {
        this.post_comment.comment = "";
        this.post_comments.push(response.data);
        console.log(response.data)
      }).catch(error => {
        console.log(error, response);
      })
    },
    postCommentDelete(){

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

#post-image-show {
  margin-top: 80px;

  .post-image-comment {
    width: 65%;
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
}
</style>
