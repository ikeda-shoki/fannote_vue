<template>
  <div id="hash-tag">
    <div class="container">
      <div class="hash-tag-title">
        <h2>#{{ hashTagName }}</h2>
        <div class="hash-tag-post-images-count">
          <span class="hash-tag-title-count">{{ hashTagPostImagesCount }}</span><span>作品</span>
        </div>
      </div>
      <div class="hash-tag-post-images">
        <PostImages :postImages="hashTagPostImages"></PostImages>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import PostImages from "../../components/PostImages.vue"

export default {
  data() {
    return {
      hashTagName: "",
      hashTagPostImages: [],
      hashTagPostImagesCount: "",
    }
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/post_images/hashtag/" + this.$route.params.name).then(
        (response) => {
          this.hashTagName = response.data.hash_tag.hashname;
          this.hashTagPostImages = response.data.hash_tag.post_images
          this.hashTagPostImagesCount = response.data.hash_tag.hash_tag_post_images_count
        },
        (error) => {
          this.$router.push("/post_images/main");
        }
      );
    },
  },
  mounted() {
    this.getInfo();
  },
  components: {
    PostImages,
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#hash-tag {
  margin-top: 100px;

  .hash-tag-title {
    margin-bottom: 40px;
    display: flex;
    align-items: flex-end;

    .hash-tag-post-images-count {
      margin: 0 0 5px 8px;

      .hash-tag-title-count {
        font-size: 30px;
        font-weight: bold;
        padding-right: 5px;
      }
    }

    h2 {
      font-size: 40px;
      font-weight: bold;
      margin-right: 20px;
    }
  }

  .hash-tag-post-images {
    /deep/ .post-image {
      width: calc(20% - 20px * 4 / 5);
      margin: 0 10px;
    }
  }
}

</style>