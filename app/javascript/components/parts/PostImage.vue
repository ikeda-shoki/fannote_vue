<template>
  <div id="post-image">
    <div v-for="postImage in postImages" :key="postImage.id">
      <img :src="postImage.postImage">
    </div>
  </div>
</template>

<script>
export default {
  
}
</script>

<style lang="scss" scoped>
  #post-image {

  }
</style>