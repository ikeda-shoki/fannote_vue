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
    user: { type: Object, required: true, default: {} },
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
}
</style>
