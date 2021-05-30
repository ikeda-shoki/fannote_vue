<template>
  <div id="slider-images">
    <h2>{{ title }}</h2>
    <hooper
      :ref="refName"
      class="post-images-slider"
      @slide="slide"
      :settings="hooperSettings"
    >
      <slide
        class="post-image"
        v-for="postImage in postImages"
        :key="postImage.id"
      >
        <PostImage
          :id="postImage.id"
          :image="postImage.post_image"
          :title="postImage.title"
          :userName="postImage.user.user_name"
          :accountName="postImage.user.account_name"
        ></PostImage>
      </slide>
    </hooper>
    <router-link :to="'/post_images'" class="post-images-link">作品一覧へ<i class="fas fa-angle-right"></i></router-link>
    <span @click.prevent="slidePrev()" class="slide-prev-button" v-if="!isFirstSlide">
      <i class="fas fa-angle-double-left"></i>
    </span>
    <span @click.prevent="slideNext()" class="slide-next-button" v-if="!isLastSlide">
      <i class="fas fa-angle-double-right"></i>
    </span>
  </div>
</template>

<script>
import { Hooper, Slide } from "hooper";
import "hooper/dist/hooper.css";
import PostImage from "../../components/parts/PostImage.vue";

export default {
  props: {
    title: { type: String, required: true },
    refName: { type: String, required: true },
    postImages: { type: Array, required: true, default: [] },
  },
  data() {
    return {
      hooperSettings: {
        itemsToShow: 3,
        trimWhiteSpace: true,
        shortDrag: false,
      },
      carouselData: 0,
      currentSlide: 0,
    };
  },
  watch: {
    carouselData() {
      this.$refs[this.refName].slideTo(this.carouselData);
    },
  },
  computed: {
    isLastSlide() {
      if(this.postImages.length >= 3){
        return this.currentSlide === (this.postImages.length - 3);
      }
      else {
        return true
      }
    },
    isFirstSlide() {
      return this.currentSlide === 0;
    }
  },
  methods: {
    slidePrev() {
      this.$refs[this.refName].slidePrev();
    },
    slideNext() {
      this.$refs[this.refName].slideNext();
    },
    slide({currentSlide}) {
      this.currentSlide = currentSlide;
    }
  },
  components: {
    PostImage,
    Hooper,
    Slide,
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#slider-images {
  margin: 10px auto 30px;
  width: 90%;
  position: relative;

  h2 {
    font-size: 20px;
    margin-bottom: 20px;
    font-weight: bold;
  }

  .slide-prev-button {
    position: absolute;
    top: 50%;
    left: -30px;
    transform: translateY(-50%);
  }

  .slide-next-button {
    position: absolute;
    top: 50%;
    right: -30px;
    transform: translateY(-50%);
  }

  .post-images-link {
    display: block;
    margin-top: 20px;
    text-align: right;
    transition: all 0.5s;
    -moz-transition: all 0.5s;
    color: $accent-color;

    i {
      margin-left: 10px;
      transition: all 0.5s;
      -moz-transition: all 0.5s;
    }
  }

  .hooper {
    height: 100px;
  }
}
</style>
