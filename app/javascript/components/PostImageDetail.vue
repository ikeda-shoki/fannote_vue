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
      <template v-for="imageIntroduction in postImage.part_image_introductions">
        <span :key="imageIntroduction.index">{{ imageIntroduction }} </span>
      </template>
      <div class="post-image-detail-hahstags">
        <template v-for="hashTag in postImage.hash_tags">
          <router-link :to="'/post_images/hashtag/' + hashTag.hashname" :key="hashTag.hashname" class="post-image-detail-hashtag">
            #{{ hashTag.hashname }}
          </router-link>
        </template>
      </div>
    </div>
    <div class="post-image-detail-etc">
      <span class="post-image-detail-username" v-if="user.account_name">
        <i class="far fa-user"></i>{{ user.account_name }}
      </span>
      <span class="post-image-detail-username" v-else>
        <i class="far fa-user"></i>{{ user.user_name }}
      </span>
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
    <div class="post_image_edit_button" v-if="user.current_user_same_as">
      <Button>
        <a href="/" class="top-button" @click.prevent="modalOpen">
          <span>編集する</span>
        </a>
      </Button>
    </div>
    <transition name="fade">
      <Modal
        v-if="isModal ? true : false"
        :isShow="isModal"
        :editData="postImage"
        modalType="編集する"
        @modalClose="modalClose"
      ></Modal>
    </transition>
  </div>
</template>

<script>
import PostImageTag from "../components/parts/PostImageTag.vue";
import Favorite from "../components/parts/Favorite.vue";
import Button from "../components/parts/Button.vue";
import Modal from "./Modal.vue";

export default {
  props: {
    postImage: { type: Object, required: true },
    user: { type: Object, required: true },
  },
  components: {
    PostImageTag,
    Favorite,
    Button,
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
    modalClose(value) {
      this.isModal = value;
      this.$emit("update");
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
    margin-bottom: 10px;

    h1 {
      font-size: 25px;
      font-weight: bold;
      width: 70%;
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

    .post-image-detail-hashtag {
      font-weight: bold;
      transition: all .3s;
      -moz-transition: all .3s;

      &:hover {
        color: $accent-color;
      }
    }
  }

  .post-image-detail-etc {
    span {
      margin-right: 10px;
    }

    i {
      margin-right: 5px;
    }
  }

  .post_image_edit_button {
    margin-top: 40px;
    text-align: center;
  }
}
</style>
