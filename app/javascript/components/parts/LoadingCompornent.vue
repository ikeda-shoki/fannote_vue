<template>
  <div id="loading-compornent">
    <div class="loading-compornent-parts">
      <div class="loading-dots">Loading...</div>
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

#loading-compornent {
  width: 100%;
  height: auto;
  transition: all .5s;
  background-color: $back-ground-color;

  .loading-compornent-parts {
    margin: 47% auto;

    .loading-dots,
    .loading-dots::before,
    .loading-dots::after {
      border-radius: 50%;
      width: 2.5em;
      height: 2.5em;
      -webkit-animation-fill-mode: both;
      animation-fill-mode: both;
      -webkit-animation: load7 1.8s infinite ease-in-out;
      animation: load7 1.8s infinite ease-in-out;
    }

    .loading-dots {
      color: $accent-color;
      font-size: 10px;
      margin: 80px auto;
      position: relative;
      text-indent: -9999em;
      -webkit-transform: translateZ(0);
      -ms-transform: translateZ(0);
      transform: translateZ(0);
      -webkit-animation-delay: -0.16s;
      animation-delay: -0.16s;
    }

    .loading-dots::after,
    .loading-dots::before {
      content: '';
      position: absolute;
      top: 0;
    }

    .loading-dots:before {
      left: -3.5em;
      -webkit-animation-delay: -0.32s;
      animation-delay: -0.32s;
    }
    .loading-dots:after {
      left: 3.5em;
    }
  }

  @-webkit-keyframes load7 {
    0%,
    80%,
    100% {
      box-shadow: 0 2.5em 0 -1.3em;
    }
    40% {
      box-shadow: 0 2.5em 0 0;
    }
  }
  @keyframes load7 {
    0%,
    80%,
    100% {
      box-shadow: 0 2.5em 0 -1.3em;
    }
    40% {
      box-shadow: 0 2.5em 0 0;
    }
  }
}
</style>