<template>
  <div id="post-images">
    <template v-for="postImage in postImages">
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
</template>

<script>
import PostImage from "./parts/PostImage.vue";

export default {
  props: {
    postImages: { type: Array, required: true, default: [] },
  },
  components: {
    PostImage,
  },
};
</script>

<style lang="scss" scoped>
#post-images {
  display: flex;
  flex-wrap: wrap;
  width: 100%;

  /deep/ .post-image {
    width: calc(25% - 10px * 3 / 4);
    margin-left: 10px;

    &:first-child {
      margin-left: 0;
    }

    &:nth-child(5n){
      margin-left: 0;
    }

    #post-image {
      width: 100%;

      img {
        width: 90%;
      }

      .post-image-hover {
        width: 100%;
      }
    }
  }
}
</style>
