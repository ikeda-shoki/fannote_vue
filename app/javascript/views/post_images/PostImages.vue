<template>
  <transition-group name="fade">
    <Loading v-if="isLoading === true" key="loader"></Loading>
    <div id="post-image-index" v-if="isLoading === false" key="noloader">
      <div class="container">
        <Title title="投稿一覧"></Title>
        <div class="post-image-sort">
          <SelectForm
            :value="selectSort"
            :options="options"
            :checkedValue="selectSort"
            @input="selectSort = $event"
            name="sort_post_image"
          ></SelectForm>
          <button class="button" @click="sortPostImages(selectGenre())">
            並び替える
          </button>
        </div>
        <div class="post-image-search">
          <CommentForm
            v-model="keyword"
            id="search"
            type="text"
            name="search"
            placeholder="キーワードを入力してください"
          ></CommentForm>
          <i class="fas fa-search" @click="searchPostImages(selectGenre())"></i>
        </div>
        <div class="genre-buttons">
          <router-link
            to="/post_images"
            class="genre-button"
            @click="selectGenre"
            exact
          >
            全て
          </router-link>
          <router-link
            to="/post_images/illust"
            class="genre-button"
            @click="selectGenre"
            exact
          >
            イラスト
          </router-link>
          <router-link
            to="/post_images/photo"
            class="genre-button"
            @click="selectGenre"
            exact
          >
            写真
          </router-link>
          <router-link
            to="/post_images/logo"
            class="genre-button"
            @click="selectGenre"
            exact
          >
            ロゴ
          </router-link>
        </div>
        <div class="post-image-contents">
          <div class="post-images-main">
            <template v-if="$route.name === 'postImagesAll'">
              <PostImages :postImages="postImagesSearch"></PostImages>
            </template>
            <template v-if="$route.name === 'postImagesIllust'">
              <PostImages :postImages="postImagesIllustSearch"></PostImages>
            </template>
            <template v-if="$route.name === 'postImagesPhoto'">
              <PostImages :postImages="postImagesPhotoSearch"></PostImages>
            </template>
            <template v-if="$route.name === 'postImagesLogo'">
              <PostImages :postImages="postImagesLogoSearch"></PostImages>
            </template>
          </div>
        </div>
      </div>
      <Footer></Footer>
    </div>
  </transition-group>
</template>

<script>
import Title from "../../components/parts/Title.vue";
import PostImages from "../../components/PostImages.vue";
import SelectForm from "../../components/form/SelectForm.vue";
import CommentForm from "../../components/form/CommetForm.vue";
import Loading from "../../components/parts/Loading.vue";
import Footer from "../../components/Footer.vue";
import axios from "axios";

export default {
  components: {
    Title,
    PostImages,
    SelectForm,
    CommentForm,
    Footer,
    Loading,
  },
  data() {
    return {
      postImages: [],
      postImagesIllust: [],
      postImagesPhoto: [],
      postImagesLogo: [],
      postImagesSearch: [],
      postImagesIllustSearch: [],
      postImagesPhotoSearch: [],
      postImagesLogoSearch: [],
      options: [
        { label: "投稿が新しい順", value: "new" },
        { label: "投稿が古い順", value: "old" },
        { label: "いいねが多い順", value: "many_favorites" },
        { label: "いいねが少ない順", value: "less_favorites" },
      ],
      selectSort: "new",
      keyword: "",
      isLoading: true,
    };
  },
  methods: {
    async getInfo() {
      await axios.get("/api/v1/post_images").then(
        (response) => {
          this.postImages = response.data.post_images;
          this.postImagesSearch = response.data.post_images;
          this.postImagesIllust = response.data.post_images_illust;
          this.postImagesIllustSearch = response.data.post_images_illust;
          this.postImagesPhoto = response.data.post_images_photo;
          this.postImagesPhotoSearch = response.data.post_images_photo;
          this.postImagesLogo = response.data.post_images_logo;
          this.postImagesLogoSearch = response.data.post_images_logo;
        },
        (error) => {
          console.log(error, response);
        }
      );
      this.isLoading = false;
    },
    sortPostImages(postImages) {
      if (this.selectSort === "new") {
        postImages.sort((a, b) => {
          return new Date(b.created_at) - new Date(a.created_at);
        });
      } else if (this.selectSort === "old") {
        postImages.sort((a, b) => {
          return new Date(a.created_at) - new Date(b.created_at);
        });
      } else if (this.selectSort === "many_favorites") {
        postImages.sort((a, b) => {
          return b.favorite_count - a.favorite_count;
        });
      } else if (this.selectSort === "less_favorites") {
        postImages.sort((a, b) => {
          return a.favorite_count - b.favorite_count;
        });
      }
    },
    selectGenre() {
      if (this.$route.name === "postImagesAll") {
        return this.postImagesSearch;
      } else if (this.$route.name === "postImagesIllust") {
        return this.postImagesIllustSearch;
      } else if (this.$route.name === "postImagesPhoto") {
        return this.postImagesPhotoSearch;
      } else if (this.$route.name === "postImagesLogo") {
        return this.postImagesLogoSearch;
      }
    },
    resetSelect() {
      this.selectSort = "new";
      this.postImagesSearch = this.postImages;
      this.postImagesIllustSearch = this.postImagesIllust;
      this.postImagesPhotoSearch = this.postImagesPhoto;
      this.postImagesLogoSearch = this.postImagesLogo;
    },
    searchPostImages() {
      if(this.$route.name === "postImagesAll") {
        this.postImagesSearch = this.postImages;
        var searchPostImages = [];
        for(let i = 0; i < this.postImagesSearch.length; ++i) {
          var postImage = this.postImagesSearch[i];
          if(postImage.title.indexOf(this.keyword) !== -1 || postImage.image_introduction.indexOf(this.keyword) !== -1) {
            searchPostImages.push(postImage);
          }
        }
        this.postImagesSearch = searchPostImages;
      }
      else if(this.$route.name === "postImagesIllust") {
        this.postImagesIllustSearch = this.postImagesIllust;
        var searchPostImages = [];
        for(let i = 0; i < this.postImagesIllustSearch.length; ++i) {
          var postImage = this.postImagesIllustSearch[i];
          if(postImage.title.indexOf(this.keyword) !== -1 || postImage.image_introduction.indexOf(this.keyword) !== -1) {
            searchPostImages.push(postImage);
          }
        }
        this.postImagesIllustSearch = searchPostImages;
      }
      else if(this.$route.name === "postImagesPhoto") {
        this.postImagesPhotoSearch = this.postImagesPhoto;
        var searchPostImages = [];
        for(let i = 0; i < this.postImagesPhotoSearch.length; ++i) {
          var postImage = this.postImagesPhotoSearch[i];
          if(postImage.title.indexOf(this.keyword) !== -1 || postImage.image_introduction.indexOf(this.keyword) !== -1) {
            searchPostImages.push(postImage);
          }
        }
        this.postImagesPhotoSearch = searchPostImages;
      }
      else if(this.$route.name === "postImagesLogo") {
        this.postImagesLogoSearch = this.postImagesLogo;
        var searchPostImages = [];
        for(let i = 0; i < this.postImagesLogoSearch.length; ++i) {
          var postImage = this.postImagesLogoSearch[i];
          if(postImage.title.indexOf(this.keyword) !== -1 || postImage.image_introduction.indexOf(this.keyword) !== -1) {
            searchPostImages.push(postImage);
          }
        }
        this.postImagesLogoSearch = searchPostImages;
      }
    }
  },
  mounted() {
    this.getInfo();
  },
  watch: {
    $route() {
      this.resetSelect();
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

#post-image-index {
  margin-top: 80px;
  text-align: center;

  .container {
    min-height: 100vh;
  }

  #title {
    font-weight: bold;
    font-size: 28px;
  }

  .genre-buttons {
    display: flex;
    justify-content: space-around;
    margin: 50px 0;

    .genre-button {
      padding: 10px 20px;
      border-radius: 15px;
      background-color: $font-white;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
      transition: all 0.3s;
      -moz-transition: all 0.3s;

      &:hover {
        cursor: pointer;
        background-color: $accent-color;
        color: $font-white;
        font-weight: bold;
      }
    }

    .router-link-active {
      background-color: $accent-color;
      color: $font-white;
      font-weight: bold;
    }
  }

  .post-image-contents {
    margin-top: 30px;

    .post-images-main {
      width: 100%;
      margin-bottom: 50px;

      /deep/ .post-image {
        width: calc(19% - 20px * 4 / 5);
        margin: 0 10px;
      }
    }
  }

  .container {
    position: relative;

    .post-image-sort {
      position: absolute;
      top: 15px;
      right: 0;
      display: flex;

      .button {
        min-width: auto;
        margin-left: 10px;
        box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
      }
    }

    .post-image-search {
      display: flex;
      align-items: center;
      position: absolute;
      top: 15px;
      left: 0;
      padding: 8px 15px;
      background-color: $font-white;
      border-radius: 20px;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
      width: 380px;

      /deep/ input {
        border-bottom: 1px solid $font-color;
        border-right: none;
        border-left: none;
        border-top: none;
        transition: 0.5s all;
        -moz-transition: 0.5s all;

        &:focus {
          outline: none;
          border-bottom: 2px solid $accent-color;
        }
      }

      i {
        margin-left: 8px;
        font-size: 23px;
        padding: 10px;
        border-radius: 50%;
        box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
        transition: all .5s;
        -moz-transition: all .5s;

        &:hover {
          background-color: $accent-color;
          color: $font-white;
        }
      }
    }
  }
}
</style>
