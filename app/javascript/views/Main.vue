<template>
  <div id="main">
    <div class="container">
      <h1>Main</h1>
      <h3>投稿一覧</h3>
      <div class="post-image" v-for="postImage in postImages" :key="postImage.id">
        <PostImage
          :image="postImage.post_image" 
          :title="postImage.title" 
          :userName="postImage.user_name"
          :accountName="postImage.account_name"></PostImage>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import PostImage from '../components/parts/PostImage.vue'

export default {
  data() {
    return {
      postImages: [],
    }
  },
  mounted() {
    console.log(this.postImages)
    this.getPostImages();
  },
  methods: {
    getPostImages() {
      axios.get('/api/v1/post_images/main')
        .then(response => {
          for(let i = 0; i < response.data.post_images.length; i++) {
            this.postImages.push(response.data.post_images[i]);
          }
        }, error => {
          console.log(error, response);
        })
    }
  },
  components: {
    PostImage,
  }
}
</script>

<style lang="scss" scoped>
  #main {
    padding-top: 10%;
  }
</style>