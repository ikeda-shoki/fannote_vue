<template>
  <div id="post-images">
    <transition-group name="sort-list">
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
    </transition-group>
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
.sort-list-move {
  transition: all .8s;
}

#post-images {
  span {
    display: flex;
    flex-wrap: wrap;

    /deep/ .post-image {
      width: calc(25% - 10px * 3 / 4);
      margin-left: 10px;

      &:first-child {
        margin-left: 0;
      }

      &:nth-child(5n) {
        margin-left: 0;
      }
    }
  }
}

// #post-images {
//   span {
//     display: flex;
//     flex-wrap: wrap;
//     width: 100%;
//   }

//   /deep/ .post-image {
//     width: calc(25% - 10px * 3 / 4);
//     margin-left: 10px;

//     &:first-child {
//       margin-left: 0;
//     }

//     &:nth-child(5n) {
//       margin-left: 0;
//     }

//     #post-image {
//       width: 100%;

//       img {
//         width: 90%;
//       }

//       .post-image-hover {
//         width: 100%;
//       }
//     }
//   }
// }
</style>