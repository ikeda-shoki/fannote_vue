<template>
  <div id="post-image-index">
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
        <div class="post-images-left">
          <template v-if="$route.name === 'postImagesAll'">
            <PostImages :postImages="postImages"></PostImages>
          </template>
          <template v-if="$route.name === 'postImagesIllust'">
            <PostImages :postImages="postImagesIllust"></PostImages>
          </template>
          <template v-if="$route.name === 'postImagesPhoto'">
            <PostImages :postImages="postImagesPhoto"></PostImages>
          </template>
          <template v-if="$route.name === 'postImagesLogo'">
            <PostImages :postImages="postImagesLogo"></PostImages>
          </template>
        </div>
        <div class="post-images-right"></div>
      </div>
    </div>
  </div>
</template>

<script>
import Title from "../../components/parts/Title.vue";
import PostImages from "../../components/PostImages.vue";
import SelectForm from "../../components/form/SelectForm.vue";
import axios from "axios";

export default {
  components: {
    Title,
    PostImages,
    SelectForm,
  },
  data() {
    return {
      postImages: [],
      postImagesIllust: [],
      postImagesPhoto: [],
      postImagesLogo: [],
      options: [
        { label: "投稿が新しい順", value: "new" },
        { label: "投稿が古い順", value: "old" },
        { label: "いいねが多い順", value: "many_favorites" },
        { label: "いいねが少ない順", value: "less_favorites" },
      ],
      selectSort: "new",
    };
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/post_images").then(
        (response) => {
          this.postImages = response.data.post_images;
          this.postImagesIllust = response.data.post_images_illust;
          this.postImagesPhoto = response.data.post_images_photo;
          this.postImagesLogo = response.data.post_images_logo;
        },
        (error) => {
          console.log(error, response);
        }
      );
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
        return this.postImages;
      } else if (this.$route.name === "postImagesIllust") {
        return this.postImagesIllust;
      } else if (this.$route.name === "postImagesPhoto") {
        return this.postImagesPhoto;
      } else if (this.$route.name === "postImagesLogo") {
        return this.postImagesLogo;
      }
    },
    resetSelect() {
      this.selectSort = "new";
      console.log(this.selectSort);
    },
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
    display: flex;

    .post-images-left {
      width: 70%;

      /deep/ #post-images {
        #post-image {
          height: 170px;

          img {
            height: 83%;
          }

          .post-image-hover {
            height: 170px;

            h3 {
              margin-top: 70px;
            }
          }
        }
      }
    }

    .post-images-right {
      width: 25%;
      background-color: $font-white;
      padding: 20px 15px;
      margin-left: auto;
      border-radius: 20px;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
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
  }
}
</style>
