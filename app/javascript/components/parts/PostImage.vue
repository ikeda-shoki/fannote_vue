<template>
  <div id="post-image" @mouseover="onImageDetail" @mouseleave="offImageDetail">
    <img :src="image" alt="投稿画像" />
    <div class='post-image-hover' :class="{ 'post-image-detail': isHover }">
      <h3 v-if="accountName"><i class="fas fa-user"></i>{{ accountName }}</h3>
      <h3 v-else><i class="fas fa-user"></i>{{ userName }}</h3>
      <p>{{ title }}</p>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    image: { required: true },
    title: { required: true, type: String },
    userName: { type: String },
    accountName: { type: String },
  },
  data() {
    return {
      isHover: false
    };
  },
  methods: {
    onImageDetail(){
      this.isHover = true
    },
    offImageDetail() {
      this.isHover = false
    }
  }
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#post-image {
  width: 230px;
  height: 230px;
  border-radius: 20px;
  background-color: $font-white;
  margin-bottom: 30px;
  box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
  text-align: center;
  position: relative;

  img {
    width: 200px;
    height: 200px;
    border-radius: 20px;
    object-fit: cover;
    object-position: center center;
    margin-top: 15px;
  }

  .post-image-hover {
    width: 230px;
    height: 230px;
    background-color: rgba(0, 0, 0, 0.6);
    border-radius: 20px;
    position: absolute;
    top: 0;
    left: 0;
    opacity: 0;
    transition: all .8s;
    transform-origin: all .8s;

    &:hover {
      cursor: pointer;
    }

    i {
      margin-right: 8px;
      color: $font-white;
    }

    h3 {
      margin: 0 auto;
      font-size: 20px;
      width: 200px;
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
      color: $font-white;
      margin-top: 80px;
    }
    p {
      margin: 0 auto;
      width: 200px;
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
      color: $font-white;
    }
  }

  .post-image-detail {
    opacity: 1;
  }
}
</style>
