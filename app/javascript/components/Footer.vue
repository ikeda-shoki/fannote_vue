<template>
  <div id="footer">
    <p>@ikechan.com</p>
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

#footer {
  background-color: $accent-color;
  width: 100%;
  height: 60px;
  position: fixed;
  bottom: 0;

  p {
    text-align: center;
    line-height: 60px;
    color: $font-white;
    font-size: 13px;
    font-weight: bold;
  }
}
</style>