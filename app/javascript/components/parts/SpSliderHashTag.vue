<template>
  <div class="slider-hash-tags">
    <h2>{{ title }}</h2>
    <hooper
      :ref="refName"
      class="hash-tags-slider"
      @slide="slide"
      :settings="hooperSettings"
    >
      <slide class="hash-tags" v-for="hashTag in hashTags" :key="hashTag.name">
        <router-link
          class="hash-tag"
          :key="hashTag.name"
          :to="'/post_images/hashtag/' + hashTag.hashname"
          >{{ hashTag.hashname }}</router-link
        >
      </slide>
    </hooper>
    <span
      @click.prevent="slidePrev()"
      class="slide-prev-button"
      v-if="!isFirstSlide"
    >
      <i class="fas fa-angle-double-left"></i>
    </span>
    <span
      @click.prevent="slideNext()"
      class="slide-next-button"
      v-if="!isLastSlide"
    >
      <i class="fas fa-angle-double-right"></i>
    </span>
  </div>
</template>

<script>
import { Hooper, Slide } from "hooper";
import "hooper/dist/hooper.css";

export default {
  props: {
    title: { type: String, required: true },
    refName: { type: String, required: true },
    hashTags: { type: Array, required: true, default: [] },
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
      if (this.hashTags.length >= 3) {
        return this.currentSlide === this.hashTags.length - 3;
      } else {
        return true;
      }
    },
    isFirstSlide() {
      return this.currentSlide === 0;
    },
  },
  methods: {
    slidePrev() {
      this.$refs[this.refName].slidePrev();
    },
    slideNext() {
      this.$refs[this.refName].slideNext();
    },
    slide({ currentSlide }) {
      this.currentSlide = currentSlide;
    },
  },
  components: {
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

.slider-hash-tags {
  margin: 20px auto 0;
  width: 90%;
  position: relative;

  h2 {
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 20px;
  }

  .slide-prev-button {
    position: absolute;
    top: 75px;
    left: -30px;
  }

  .slide-next-button {
    position: absolute;
    top: 75px;
    right: -30px;
  }

  .hash-tag {
    display: block;
    text-align: center;
    padding: 5px 10px;
    font-size: 10px;
    margin: 0 10px;
    border-radius: 20px;
    background-color: $font-white;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
    transition: all 0.5s;
    -moz-transition: all 0.5s;
  }
}

.hooper {
  height: 60px;
}
</style>
