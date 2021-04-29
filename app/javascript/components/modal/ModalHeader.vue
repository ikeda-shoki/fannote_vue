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

  #modal-header {
    background-color: $accent-color;
    border-radius: 20px 20px 0 0;
    text-align: center;
    padding: 10px;

    h1 {
      color: $back-ground-color;
      font-size: 25px;
      font-weight: bold;
    }
  }
</style>