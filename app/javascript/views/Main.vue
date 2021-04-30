<template>
  <div id="main">
    <div class="container">
      <h1>Main</h1>
      <h3>投稿一覧</h3>
      <div class="post-image">
        
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      postImages: {},
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
          this.postImages = response.data;
        }, error => {
          console.log(error, response)
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