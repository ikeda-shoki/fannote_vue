<template>
  <div id="post-image-detail">
    <img :src="postImage.post_image" alt="投稿画像" />
    <div class="post-image-detail-title">
      <h1>{{ postImage.title }}</h1>
      <div class="post-image-detail-icons">
        <PostImageTag :tagName="postImage.post_image_genre"></PostImageTag>
        <Favorite
          :isFavorite="postImage.check_favorite"
          @chengeFavorite="chengeFavorite"
        ></Favorite>
      </div>
    </div>
    <div class="post-image-detail-introduction">
      <p>{{ postImage.image_introduction }}</p>
      <div class="post-image-detail-hashtags">
        <template v-for="hashTag in postImage.hash_tags">
          <router-link
            :to="'/post_images/hashtag/' + hashTag.hashname"
            :key="hashTag.hashname"
            class="post-image-detail-hashtag"
          >
            #{{ hashTag.hashname }}
          </router-link>
        </template>
      </div>
    </div>
    <div class="post-image-detail-etc">
      <router-link :to="'/users/' + user.id" class="post-image-detail-username">
        <span class="post-image-detail-username" v-if="user.account_name">
          <i class="far fa-user"></i>{{ user.account_name }}
        </span>
        <span class="post-image-detail-username" v-else>
          <i class="far fa-user"></i>{{ user.user_name }}
        </span>
      </router-link>
      <span class="post-image-detail-create-at"
        ><i class="fas fa-pen"></i>{{ postImage.vue_created_at }}</span
      >
      <span class="post-image-detail-uploat-at"
        ><i class="far fa-arrow-alt-circle-up"></i
        >{{ postImage.vue_updated_at }}</span
      >
      <span class="post-image-detail-favorite"
        ><i class="far fa-heart"></i>{{ postImage.favorite_count }}</span
      >
    </div>
    <div class="post-image-detail-edit-button" v-if="user.current_user_same_as">
      <p class="button post-image-edit-button" @click="modalOpen">編集する</p>
    </div>
    <transition name="fade">
      <Modal
        v-if="isModal ? true : false"
        :isShow="isModal"
        :editData="postImage"
        modalType="編集する"
        @modalClose="modalClose"
        @postImageUpdate="postImageUpdate"
      ></Modal>
    </transition>
  </div>
</template>

<script>
import PostImageTag from "../components/parts/PostImageTag.vue";
import Favorite from "../components/parts/Favorite.vue";
import Modal from "./Modal.vue";

export default {
  props: {
    postImage: { type: Object, required: true },
    user: { type: Object, required: true },
  },
  components: {
    PostImageTag,
    Favorite,
    Modal,
  },
  data() {
    return {
      isModal: false,
    };
  },
  methods: {
    chengeFavorite(value) {
      this.$emit("chengeFavorite", value);
    },
    modalOpen() {
      this.isModal = true;
    },
    modalClose() {
      this.isModal = false;
    },
    postImageUpdate() {
      this.isModal = false;
      this.$emit("postImageUpdate");
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

#post-image-detail {
  background-color: $font-white;
  border-radius: 20px;
  padding: 50px 30px 30px;

  img {
    width: 100%;
  }

  .post-image-detail-title {
    display: flex;
    align-items: center;
    margin: 10px 0;

    h1 {
      font-size: 25px;
      font-weight: bold;
      width: 70%;
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;

      @include sp {
        font-size: 20px;
        width: 60%;
      }
    }

    .post-image-detail-icons {
      margin-left: auto;
      display: flex;
      align-items: center;

      #favorite {
        margin-left: 10px;
      }
    }
  }

  .post-image-detail-introduction {
    margin-bottom: 10px;

    @include sp {
      font-size: 13px;
    }

    .post-image-detail-hashtags {
      margin-top: 50px;

      @include sp {
        margin-top: 30px;

        a {
          color: $accent-color;
        }
      }
    }

    .post-image-detail-hashtag {
      font-weight: bold;
      transition: all 0.3s;
      -moz-transition: all 0.3s;

      &:hover {
        color: $accent-color;
      }
    }
  }

  .post-image-detail-etc {
    @include sp {
      display: flex;
      flex-direction: column;
      font-size: 13px;

      .post-image-detail-username {
        font-size: 15px;
        font-weight: bold;
      }
    }

    span {
      margin-right: 10px;
    }

    i {
      margin-right: 5px;
    }
  }

  .post-image-detail-edit-button {
    margin-top: 40px;
    text-align: center;
    .post-image-edit-button {
      border-radius: 30px;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
    }
  }
}
</style>
