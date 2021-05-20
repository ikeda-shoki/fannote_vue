<template>
  <div id="error-message">
    <p>{{ message[0] }}</p>
  </div>
</template>

<script>
export default {
  props: {
    message: { type: Array }
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#error-message {
  position: relative;
  padding: 7px 10px;
  background-color: $font-white;
  border: solid 3px $danger-color;
  border-radius: 5px;

  &::before {
    content: "";
    position: absolute;
    top: -24px;
    left: 20%;
    margin-left: -15px;
    border: 12px solid transparent;
    border-bottom: 12px solid $font-white;
    z-index: 2;
  }

  &::after {
    content: "";
    position: absolute;
    top: -30px;
    left: 20%;
    margin-left: -17px;
    border: 14px solid transparent;
    border-bottom: 14px solid $danger-color;
    z-index: 1;
  }

  p {
    font-size: 14px;
    color: $danger-color;
    font-weight: bold;
  }
}
</style>