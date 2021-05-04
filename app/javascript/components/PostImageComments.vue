<template>
  <div id="post-image-comments">
    <div class="post-image-comment" v-for="postComment in postComments" :key="postComment.id">
      <div class="post-image-comment-image">
        <img src="" alt="">
        <p v-if="postComment.user.account_name">{{ postComment.user.account_name }}</p>
        <p v-else>{{ postComment.user.user_name }}</p>
      </div>
      <Comment :comment="postComment.comment"></Comment>
      <template v-if="userLogIn">
        <CloseButton @click.native="commentDelete(postComment.id)"></CloseButton>
      </template>
    </div>
  </div>
</template>

<script>
import Comment from '../components/parts/Comment.vue'
import CloseButton from '../components/parts/CloseButton.vue'
import axios from 'axios'

export default {
  props: {
    postComments: { type: Array, required: true },
    userLogIn: { type: Boolean, default: false },
  },
  components: {
    Comment,
    CloseButton,
  },
  methods: {
    commentDelete(post_comment_id) {
      axios({
        url: "/api/v1/post_images/" + this.$route.params.id + "/post_comments/" + post_comment_id,
        data: {
          post_image_id: this.$route.params.id,
          id: post_comment_id,
        },
        method: "DELETE",
      })
        .then((response) => {
          this.$emit("postCommentDelete", post_comment_id);
        })
        .catch((error) => {
          console.log(error);
        });
    }
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

  #post-image-comments {
    background-color: $font-white;
    border-radius: 20px;
    width: 65%;
    padding: 30px;

    .post-image-comment {
      display: flex;
      align-items: center;
      justify-content: space-between;

      .post-image-comment-image {
        p {
          font-size: 10px;
        }
      }
    }

    #close-button {
      margin-left: 10px;
    }
  }
</style>