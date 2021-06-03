<template>
  <div id="loading">
    <div class="loading-parts">
      <div class="obj"></div>
      <div class="obj"></div>
      <div class="obj"></div>
      <div class="obj"></div>
      <div class="obj"></div>
      <div class="obj"></div>
      <div class="obj"></div>
      <div class="obj"></div>
    </div>
    <div class="loading-text">
      <p>データの読み込み中です。しばらくお待ちください。</p>
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

#loading {
  position: absolute;
  width: 100vw;
  left: 0;
  top: 0;
  height: 100vh;
  transition: all .5s;
  margin-top: 80px;
  background-color: $back-ground-color;

  .loading-parts {
    position: absolute;
    top: 45%;
    left: 50%;
    transform: translate(-50%,-50%);
    height: 40px;
    display: flex;
    align-items: center;

    .obj {
      width: 5px;
      height: 40px;
      background: $accent-color;
      margin: 0 3px;
      border-radius: 10px;
      animation: loading 0.8s infinite;

      &:nth-child(2) {
        animation-delay: 0.1s;
      }

      &:nth-child(3) {
        animation-delay: 0.2s;
      }

      &:nth-child(4) {
        animation-delay: 0.3s;
      }

      &:nth-child(5) {
        animation-delay: 0.4s;
      }

      &:nth-child(6) {
        animation-delay: 0.5s;
      }

      &:nth-child(7) {
        animation-delay: 0.6s;
      }

      &:nth-child(8) {
        animation-delay: 0.7s;
      }
    }
  }

  .loading-text {
    text-align: center;
    font-size: 13px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);

    @include sp {
      top: 55%;
    }
  }
}

@keyframes loading{
  0%{
      height: 0;
  }
  50%{
      height: 40px;
  }
  100%{
      height: 0;
  }
}

</style>