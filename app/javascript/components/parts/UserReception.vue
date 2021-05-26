<template>
  <div class="user-reception">
    <span v-if="isReception === true" class="reception">受付中</span>
    <span v-if="isReception === false" class="no-reception">受付不可</span>
  </div>
</template>

<script>
export default {
  props: {
    isReception: { type: Boolean, required: true }
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

.user-reception {
  span {
    padding: 10px 25px;
    color: $font-white;
    font-weight: bold;
    border-radius: 10px;
  }
}

.reception {
  background-color: $success-color;
}

.no-reception {
  background-color: $danger-color;
}

</style>