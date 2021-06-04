<template>
  <div id="modal-header">
    <h1>{{ header }}</h1>
  </div>
</template>

<script>
export default {
  props: {
    header: { type: String, required: true }
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

  #modal-header {
    background-color: $accent-color;
    border-radius: 20px 20px 0 0;
    text-align: center;
    height: 45px;

    @include sp {
      height: 40px;
    }

    h1 {
      color: $back-ground-color;
      font-size: 23px;
      font-weight: bold;
      line-height: 45px;

      @include sp {
        font-size: 20px;
      }
    }
  }
</style>