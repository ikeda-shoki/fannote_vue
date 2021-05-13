<template>
  <div id="request-status">
    <p v-if="requestStatus === '未受付'" class="yet-accepted">未受付</p>
    <p v-else-if="requestStatus === '受付不可'" class="not-accepted">受付不可</p>
    <p v-else-if="requestStatus === '製作中'" class="production">製作中</p>
    <p v-else-if="requestStatus === '製作完了'" class="production-complete">製作完了</p>
  </div>
</template>

<script>
export default {
  props: {
    requestStatus: { type: String, required: true }
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

  #request-status {
    p {
      padding: 10px 40px;
      color: $font-white;
      font-weight: bold;
      border-radius: 5px;
      display: inline-block;
    }
    .yet-accepted {
      background-color: #AACB56;
    }
    .not-accepted {
      background-color: #E15253;
    }
    .production {
      background-color: #6BB8FF;
    }
    .production-complete {
      background-color: #FBC52C;
    }
  }
</style>