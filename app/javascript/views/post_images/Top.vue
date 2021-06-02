<template>
  <div>
    <template v-if="screenWidth === true">
      <div id="top">
        <div class="container">
          <div class="top-text">
            <h3 class="top-title">
              Bringing Your Art<br />
              to More People....
            </h3>
            <p class="top-subtitle">あなたのイラストや写真をもっと身近にお手軽に</p>
          </div>
          <TopButtons></TopButtons>
        </div>
      </div>
    </template>

    <template v-else-if="screenWidth === false">
      <SpTop></SpTop>
    </template>
    <Footer></Footer>
  </div>
</template>

<script>
import 'top.jpg';
import TopButtons from '../../components/TopButtons'
import Footer from "../../components/Footer.vue";
import SpTop from "./SpTop.vue";

export default {
  components: {
    TopButtons,
    Footer,
    SpTop,
  },
  data() {
    return {
      screenWidth: false,
    }
  },
  methods: {
    handleResize: function() {
      if (window.innerWidth <= 500) {
        this.screenWidth = false
      } else {
        this.screenWidth = true
      }
    }
  },
  created() {
    window.addEventListener('resize', this.handleResize)
    this.handleResize()
  },
  destroyed() {
    window.removeEventListener('resize', this.handleResize)
  }
}
</script>

<style lang="scss" scoped>
  $sp: 500px;

  @mixin sp {
    @media screen and (max-width: 767px) {
      @content;
    }
  }

  #top {
    width: 100%;
    height: 100vh;
    background-image: url("~top.jpg");
    background-size: cover;
    background-color:rgba(255,255,255,0.5);
    background-blend-mode:lighten;

    .container {
      position: relative;
    }

    .top-text {
      position: absolute;
      top: 230px;
      left: 20px;

      .top-title {
        font-size: 60px;
        font-family: 'Akaya Telivigala', cursive, 'Nunito', sans-serif;
        font-weight: bold;
      }

      .top-subtitle {
        font-size: 18px;
        font-weight: bold;
      }
    }
  }
</style>