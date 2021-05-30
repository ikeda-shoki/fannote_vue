<template>
  <div id="post-image-comments">
    <p v-if="!postComments.length">この投稿にはまだコメントがありません。</p>
    <transition-group
      tag="div"
      name="fade-list"
      mode="out-in"
    >
      <div
        class="post-image-comment"
        v-for="(postComment, index) in getItems"
        :key="postComment.id"
      >
        <div class="post-image-comment-image">
          <CircleImage :image="postComment.user.profile_image"></CircleImage>
          <p v-if="postComment.user.account_name">
            {{ postComment.user.account_name }}
          </p>
          <p v-else>{{ postComment.user.user_name }}</p>
        </div>
        <Comment :comment="postComment.comment"></Comment>
        <template v-if="postComment.user.current_user_same_as === true">
          <CloseButton
            @click.native="commentDelete(postComment.id, index)"
          ></CloseButton>
        </template>
      </div>
      <template v-if="(getPageCount > 1)">
          <paginate
            key="paginate"
            :page-count="getPageCount"
            :prev-text="'<'"
            :next-text="'>'"
            :click-handler="clickCallback"
            :container-class="'pagination'"
            :page-class="'page-item'"
            :page-link-class="'page-link'"
            :prev-class="'page-item'"
            :prev-link-class="'page-link'"
            :next-class="'page-item'"
            :next-link-class="'page-link'"
            :first-last-button="true"
            :first-button-text="'<<'"
            :last-button-text="'>>'"
          >
          </paginate>
        </template>
    </transition-group>
  </div>
</template>

<script>
import Comment from "../components/parts/Comment.vue";
import CloseButton from "../components/parts/CloseButton.vue";
import CircleImage from "./parts/CircleImage.vue"
import axios from "axios";

export default {
  props: {
    postComments: { type: Array, required: true },
  },
  data() {
    return {
      parPage: 5,
      currentPage: 1,
    }
  },
  components: {
    Comment,
    CloseButton,
    CircleImage,
  },
  methods: {
    commentDelete(post_comment_id, index) {
      axios({
        url:
          "/api/v1/post_images/" +
          this.$route.params.id +
          "/post_comments/" +
          post_comment_id,
        data: {
          post_image_id: this.$route.params.id,
          id: post_comment_id,
        },
        method: "DELETE",
      })
        .then((response) => {
          this.postComments.splice(index, 1);
          this.$emit("postCommentDelete", this.postComments);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
    },
  },
  computed: {
    getItems() {
      let current = this.currentPage * this.parPage;
      let start = current - this.parPage;
      return this.postComments.slice(start, current);
    },
    getPageCount() {
      return Math.ceil(this.postComments.length / this.parPage);
    },
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

#post-image-comments {
  background-color: $font-white;
  border-radius: 20px;
  padding: 30px;

  .post-image-comment {
    display: flex;
    align-items: center;

    #circle-image {
      /deep/ img {
        width: 50px;
        height: 50px;
        border: solid 2px $accent-color;
        padding: 0;
      }
    }

    .post-image-comment-image {
      position: relative;

      p {
        width: 70px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
	      -webkit-text-overflow: ellipsis;
        font-size: 10px;
        text-align: center;
        position: absolute;
        top: 50px;
        left: 50%;
        transform: translateX(-50%);
      }
    }
  }

  #close-button {
    margin-left: auto;

    @include sp {
      margin-left: 5px;
    }
  }

  .pagination {
    display: flex;
    justify-content: center;
    margin: 10px 0 30px;

    /deep/ .page-item {
      margin: 0 3px;
      text-align: center;

      .page-link {
        display: block;
        width: 30px;
        height: 30px;
        line-height: 30px;
        border-radius: 5px;
        transition: all 0.5s;
        -moz-transition: all 0.5s;

        &:hover {
          background-color: $accent-color;
          color: $font-white;
          font-weight: bold;
        }
      }
    }
    /deep/ .active {
      .page-link {
        background-color: $accent-color;
        color: $font-white;
        font-weight: bold;
      }
    }
  }
}

.no-comment {
  height: auto!important;
}
</style>
