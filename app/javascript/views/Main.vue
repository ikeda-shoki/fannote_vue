<template>
  <div id="main">
    <div class="container">
      <h1>Main</h1>
      <h3>投稿一覧</h3>
      <div class="post-image" v-for="postImage in postImages" :key="postImage.id">
        <img :src="postImage.post_image">
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

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
  }
}
</script>

<style lang="scss" scoped>
  #main {
    padding-top: 10%;
  }
</style>