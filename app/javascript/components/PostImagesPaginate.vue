<template>
  <div class="post-images-paginate">
    <div class="post-images">
      <template v-for="postImage in getItems">
        <PostImage
          :key="postImage.id"
          :id="postImage.id"
          :image="postImage.post_image"
          :title="postImage.title"
          :userName="postImage.user.user_name"
          :accountName="postImage.user.account_name"
        ></PostImage>
      </template>
    </div>
    <template v-if="(getPageCount > 1)">
      <paginate
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
  </div>
</template>

<script>
import PostImage from "./parts/PostImage.vue";

export default {
  props: {
    postImages: { type: Array, required: true, default: [] },
  },
  data() {
    return {
      items: this.postImages,
      parPage: 6,
      currentPage: 1,
    };
  },
  components: {
    PostImage,
  },
  methods: {
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
    },
  },
  computed: {
    getItems() {
      let current = this.currentPage * this.parPage;
      let start = current - this.parPage;
      return this.items.slice(start, current);
    },
    getPageCount() {
      return Math.ceil(this.items.length / this.parPage);
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

.post-images-paginate {
  .post-images {
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    height: 380px;

    &::after {
      display: block;
      content: "";
      width: 33%;
    }

    .post-image {
      display: block;
      width: 33%;

      &:nth-child(7n) {
        margin-right: auto;
      }
    }
  }

  .pagination {
    display: flex;
    justify-content: center;
    margin: 10px 0 30px;

    /deep/ .page-item {
      margin: 0 5px;

      .page-link {
        display: block;
        width: 30px;
        height: 30px;
        line-height: 30px;
        border-radius: 50%;
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
</style>
