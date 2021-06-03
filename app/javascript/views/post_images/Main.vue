<template>
  <transition-group name="fade">
    <Loading v-if="isLoading === true" key="loader"></Loading>
    <div id="main" v-if="isLoading === false" key="noloader">
      <div class="container">
        <mq-layout mq="lg">
          <div class="favorite-images">
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
                        <p v-if="postImage.user.account_name">
                          <i class="fas fa-user"></i
                          >{{ postImage.user.account_name }}
                        </p>
                        <p v-else>
                          {{ postImage.user.user_name
                          }}<i class="fas fa-user"></i>
                        </p>
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

          <div class="main-post-images">
            <SliderImages
              title="新着作品"
              refName="new"
              :postImages="postImages"
            ></SliderImages>
          </div>

          <div class="main-post-images">
            <SliderHashTags
              title="人気のタグ"
              refName="hashtag"
              :hashTags="hashTags"
            >
            </SliderHashTags>
          </div>

          <div class="main-post-images">
            <SliderImages
              title="イラストの人気作品"
              refName="iluust"
              :postImages="rankingIllustImages"
            ></SliderImages>
          </div>

          <div class="main-post-images">
            <SliderImages
              title="写真の人気作品"
              refName="photo"
              :postImages="rankingPhotoImages"
            ></SliderImages>
          </div>

          <div class="main-post-images">
            <SliderImages
              title="ロゴの人気作品"
              refName="logo"
              :postImages="rankingLogoImages"
            ></SliderImages>
          </div>

          <div class="main-post-images">
            <SliderImages
              title="フォローユーザーの新着作品"
              refName="follow"
              :postImages="followingUserImages"
            ></SliderImages>
          </div>
        </mq-layout>

        <mq-layout mq="sp">
          <SpFavoriteImages :rankingImages="rankingImages"></SpFavoriteImages>

          <SpSliderImages
            title="新着作品"
            refName="new"
            :postImages="postImages"
          >
          </SpSliderImages>

          <SpSliderHashTags
            title="人気のタグ"
            refName="hashtag"
            :hashTags="hashTags"
          >
          </SpSliderHashTags>

          <SpSliderImages
            title="イラストの人気作品"
            refName="iluust"
            :postImages="rankingIllustImages"
          >
          </SpSliderImages>

          <SpSliderImages
            title="写真の人気作品"
            refName="photo"
            :postImages="rankingPhotoImages"
          >
          </SpSliderImages>

          <SpSliderImages
            title="ロゴの人気作品"
            refName="logo"
            :postImages="rankingLogoImages"
          >
          </SpSliderImages>

          <SpSliderImages
            title="フォローユーザーの新着作品"
            refName="follow"
            :postImages="followingUserImages"
          >
          </SpSliderImages>
        </mq-layout>

      </div>
      <Footer></Footer>
    </div>
  </transition-group>
</template>

<script>
import axios from "axios";
import PostImage from "../../components/parts/PostImage.vue";
import SliderImages from "../../components/parts/SliderImages.vue";
import SliderHashTags from "../../components/parts/SliderHashTags.vue";
import Loading from "../../components/parts/Loading.vue";
import Footer from "../../components/Footer.vue";
import SpFavoriteImages from "../../components/parts/SpFavoriteImages.vue";
import SpSliderImages from "../../components/parts/SpSliderImages.vue";
import SpSliderHashTags from "../../components/parts/SpSliderHashTag.vue";

import {
  Hooper,
  Slide,
  Pagination as HooperPagination,
  Navigation as HooperNavigation,
} from "hooper";
import "hooper/dist/hooper.css";

export default {
  data() {
    return {
      postImages: [],
      followingUserImages: [],
      rankingImages: [],
      rankingIllustImages: [],
      rankingPhotoImages: [],
      rankingLogoImages: [],
      hashTags: [],
      hooperSettings: {
        infiniteScroll: true,
        trimWhiteSpace: true,
        shortDrag: false,
        itemsToShow: 3.5,
        centerMode: true,
      },
      isLoading: true,
    };
  },
  mounted() {
    this.getPostImages();
  },
  methods: {
    async getPostImages() {
      await axios.get("/api/v1/post_images/main").then(
        (response) => {
          this.postImages = response.data.post_images;
          this.followingUserImages = response.data.following_user_images;
          this.rankingImages = response.data.ranking_images;
          this.rankingIllustImages = response.data.ranking_illust_images;
          this.rankingPhotoImages = response.data.ranking_photo_images;
          this.rankingLogoImages = response.data.ranking_logo_images;
          this.hashTags = response.data.hash_tags;
        },
        (error) => {
          console.log(error, response);
          this.$router.push("/errors");
        }
      );
      this.isLoading = false;
    },
  },
  components: {
    PostImage,
    Loading,
    Footer,
    Hooper,
    Slide,
    SliderImages,
    SliderHashTags,
    HooperPagination,
    HooperNavigation,
    SpFavoriteImages,
    SpSliderImages,
    SpSliderHashTags,
  },
  props: {
    userLogIn: { type: Boolean },
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

#main {
  padding-top: 100px;

  @include sp {
    padding-top: 80px;
  }

  .favorite-images {
    width: 90%;
    margin: 0 auto;
    margin-bottom: 50px;

    h2 {
      font-size: 30px;
      margin-bottom: 20px;
      font-weight: bold;
    }
    .favorite-image {
      height: 250px;
      margin: 0 10px;

      &:hover {
        .favorite-image-info {
          opacity: 1;
          right: 0;
        }
      }

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
        top: -220px;
        left: 20px;
        padding: 10px 20px;
        background: $back-ground-color;
        opacity: 0.8;
        border-radius: 50%;
        border: 1px solid $accent-color;
        font-size: 20px;
        font-weight: bold;

        @include sp {
          top: -70px;
          left: 0;
          padding: 0 10px;
          font-size: 20px;
          border: none;
          background-color: rgba(0, 0, 0, 0);
        }
      }

      .favorite-image-info {
        position: absolute;
        width: 60%;
        height: 60px;
        top: -100px;
        right: -60%;
        background-color: $accent-color;
        border-radius: 10px 0 0 10px;
        padding: 5px 10px;
        transition: all 0.3s;
        -moz-transition: all 0.3s;
        opacity: 0;

        @include sp {
          display: none;
        }

        i,
        p {
          color: $back-ground-color;
          overflow: hidden;
          white-space: nowrap;
          text-overflow: ellipsis;
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
  }

  .main-post-images {
    margin-bottom: 30px;
  }

  .post-images-link {
    display: block;
    margin-top: 20px;
    text-align: right;
    transition: all 0.5s;
    -moz-transition: all 0.5s;

    &:hover {
      color: $accent-color;

      i {
        color: $accent-color;
      }
    }

    i {
      margin-left: 10px;
      transition: all 0.5s;
      -moz-transition: all 0.5s;
    }
  }
}
</style>
