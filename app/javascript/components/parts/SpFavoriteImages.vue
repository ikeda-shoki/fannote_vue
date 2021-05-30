<template>
  <div id="sp-favorite-images">
    <h2>人気の作品</h2>
    <hooper :settings="hooperSettings">
      <slide
        class="post-image"
        v-for="(postImage, index) in rankingImages"
        :key="postImage.id"
      >
        <div class="favorite-image">
          <router-link :to="'/post_images/' + postImage.id">
            <span class="image-score">{{ index + 1 }}</span>
            <img :src="postImage.post_image" />
            <div class="favorite-image-info">
              <div class="favorite-image-info-user">
                <p v-if="postImage.user.account_name"
                  ><i class="fas fa-user"></i
                  >{{ postImage.user.account_name }}</p
                >
                <p v-else
                  >{{ postImage.user.user_name }}<i class="fas fa-user"></i
                ></p>
              </div>
              <p>{{ postImage.title }}</p>
            </div>
          </router-link>
        </div>
      </slide>
      <hooper-pagination slot="hooper-addons" />
      <hooper-navigation slot="hooper-addons" />
    </hooper>
    <router-link :to="'/post_images'" class="post-images-link"
      >作品一覧へ<i class="fas fa-angle-right"></i
    ></router-link>
  </div>
</template>

<script>
import {
  Hooper,
  Slide,
  Pagination as HooperPagination,
  Navigation as HooperNavigation,
} from "hooper";
import "hooper/dist/hooper.css";

export default {
  props: {
    rankingImages: {
      type: Array,
      required: true,
    }
  },
  components: {
    Hooper,
    Slide,
    HooperPagination,
    HooperNavigation,
  },
  data() {
    return {
      hooperSettings: {
        infiniteScroll: true,
        trimWhiteSpace: true,
        shortDrag: false,
        itemsToShow: 1.5,
        centerMode: true,
      },
    };
  },
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#sp-favorite-images {
  width: 90%;
  margin: 0 auto;
  margin-bottom: 50px;

  h2 {
    font-size: 20px;
    margin-bottom: 20px;
    font-weight: bold;
  }
  .favorite-image {
    height: 200px;
    margin: 0 10px;

    a {
      position: relative;
    }

    img {
      border-radius: 20px;
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: center center;
    }

    .image-score {
      position: absolute;
      top: -180px;
      left: 20px;
      padding: 10px 20px;
      background: $back-ground-color;
      opacity: 0.8;
      border-radius: 50%;
      border: 1px solid $accent-color;
      font-size: 20px;
      font-weight: bold;
    }

    .favorite-image-info {
      position: absolute;
      width: 60%;
      height: 60px;
      top: -80px;
      right: 0;
      background-color: $accent-color;
      border-radius: 10px 0 0 10px;
      padding: 10px 10px;
      transition: all 0.3s;
      -moz-transition: all 0.3s;

      i,
      p {
        color: $back-ground-color;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        font-size: 13px;
      }

      i {
        margin-right: 5px;
      }
    }
  }
  .hooper {
    height: auto;
  }

  /deep/ .hooper-indicator {
    background-color: $back-ground-color;
    &:hover {
      background-color: $accent-color;
    }
  }
  /deep/ .hooper-indicator.is-active {
    background-color: $accent-color;
  }

  .post-images-link {
    display: block;
    margin-top: 20px;
    text-align: right;
    transition: all 0.5s;
    -moz-transition: all 0.5s;
    color: $accent-color;

    i {
      margin-left: 10px;
      transition: all 0.5s;
      -moz-transition: all 0.5s;
    }
  }
}

</style>