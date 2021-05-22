<template>
  <div class="fukidasi">
    <div class="faceicon">
      <CircleImage :image="chat.user.profile_image"></CircleImage>
    </div>
    <div class="chatting">
      <div class="says">
        <p>{{ chat.message }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import CircleImage from "./CircleImage.vue"

export default {
  props: {
    chat: { type: Object, required: true, default: {} }
  },
  components: {
    CircleImage,
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

.fukidasi {
  width: 100%;
  margin: 10px 0;
  overflow: hidden;

  .faceicon {
    float: left;
    margin-right: -50px;
    width: 40px;

    #circle-image {
      /deep/ img {
        width: 40px;
        height: 40px;
        border: solid 2px $accent-color;
        padding: 0;
      }
    }
  }

  .chatting {
    width: 100%;
    text-align: left;

    .says {
      display: inline-block;
      position: relative;
      margin: 0 0 0 50px;
      padding: 10px;
      max-width: 250px;
      border-radius: 12px;
      background: #fff;

      &:after {
        content: "";
        display: inline-block;
        position: absolute;
        top: 3px;
        left: -19px;
        border: 8px solid transparent;
        border-right: 18px solid #fff;
        -webkit-transform: rotate(35deg);
        transform: rotate(35deg);
      }

      p {
        margin: 0;
        padding: 0;
      }
    }
  }
}
</style>