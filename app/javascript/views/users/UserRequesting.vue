<template>
  <div id="user-requesting">
    <div class="user-requesting-title">
      <Title title="依頼中の内容一覧"></Title>
      <span>{{}}件</span>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Title from "../../components/parts/Title.vue";

export default {
  components: {
    Title,
  },
  props: {
    user: { type: Object, required: true },
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#user-requesting {
  .user-requesting-title {
    position: relative;

    #title {
      font-size: 28px;
      /deep/ h2 {
        font-weight: 800;
      }
    }

    span {
      position: absolute;
      top: 28px;
      right: 20%;
    }
  }
}
</style>
