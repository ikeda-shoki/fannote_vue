<template>
  <div id="alert">
    <template v-if="type === 'success'">
      <div class="alert-success">
        <p>
          <slot>これはアラートです。</slot>
        </p>
      </div>
    </template>
    <template v-if="type === 'danger'">
      <div class="alert-danger">
        <p>
          <slot>これはアラートです。</slot>
        </p>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    type: { type: String, required: true },
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;
$success-color: #88C4C4;

#alert {
  width: 380px;
  position: fixed;
  z-index: 100;
  top: 130px;
  right: 0;

  p {
    color: $font-white;
    font-weight: bold;
    font-size: 23px;
    padding: 20px 35px;
  }

  .alert-success {
    background-color: $success-color;
    width: 100%;
    height: 100%;
  }

  .alert-danger {
    background-color: $danger-color;
    width: 100%;
    height: 100%;
  }
}

</style>