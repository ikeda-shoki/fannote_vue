<template>
  <div id="circle-image">
    <img :src="image" alt="アイコン" v-if="image" />
    <img src="~no_image.jpg" alt="NoImage" v-else />
  </div>
</template>

<script>
import "no_image.jpg";

export default {
  props: {
    image: {}
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

  #circle-image {
    img {
      width: 150px;
      height: 150px;
      object-fit: cover;
      border-radius: 50%;
      padding: 5px;
      border: solid 5px $accent-color;
    }
  }
</style>