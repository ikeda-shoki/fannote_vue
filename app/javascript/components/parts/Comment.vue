<template>
  <div id="comment">
    <p>{{ comment }}</p>
  </div>
</template>

<script>
export default {
  props: {
    comment: { type: String, required: true }
  }
}

</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#comment {
  position: relative;
  display: inline-block;
  margin: 15px 0 15px 30px;
  padding: 15px 10px;
  min-width: 120px;
  width: 430px;
  font-size: 16px;
  background: $back-ground-color;
  border-radius: 20px;

  &:before {
      content: "";
      position: absolute;
      top: 50%;
      left: -28px;
      margin-top: -15px;
      border: 15px solid transparent;
      border-right: 15px solid $back-ground-color;
    }

    p {
      margin: 0;
      padding: 0;
    }
}
</style>