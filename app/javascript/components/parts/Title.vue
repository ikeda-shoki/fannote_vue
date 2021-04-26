<template>
  <div id="title">
    <h2>{{ title }}</h2>
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true
    }
  }
}
</script>

<style lang="scss" scoped>
  $accent-color: #e65b20;

  #title {
    position: relative;
    display: inline-block;
    margin-bottom: 10px;
    font-weight: 800;
    font-size: 40px;

    &::before {
      content: '';
      position: absolute;
      bottom: -15px;
      display: inline-block;
      width: 60px;
      height: 5px;
      left: 50%;
      -webkit-transform: translateX(-50%);
      transform: translateX(-50%);
      background-color: $accent-color;
      border-radius: 2px;
    }
  }
</style>