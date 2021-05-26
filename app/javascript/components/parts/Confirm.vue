<template>
  <div id="confirm" @click.self="falseAction">
    <div class="confirm-main">
      <div class="confirm-top">
        <p><slot>※これは確認です。</slot></p>
      </div>
      <div class="confirm-bottom">
        <button class="button" @click="falseAction">キャンセル</button>
        <slot name="okButton">
          <button class="button" @click="successAction">OK</button>
        </slot>
      </div>
    </div>
  </div>
</template>

<script>
import { disableBodyScroll, enableBodyScroll, clearAllBodyScrollLocks } from 'body-scroll-lock';

export default {
  methods: {
    falseAction() {
      this.$emit("falseAction", false);
      clearAllBodyScrollLocks();
    },
    successAction() {
      this.$emit("successAction");
      clearAllBodyScrollLocks();
    },
  },
  mounted() {
    var confirm = document.querySelector('#confirm');
    disableBodyScroll(confirm);
  },
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#confirm {
  z-index: 500;
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(22, 22, 21, 0.7);

  .confirm-main {
    background-color: $back-ground-color;
    width: 60%;
    height: 200px;
    margin: 200px auto 0;
    border-radius: 20px;

    .confirm-top {
      margin: 0 20px;
      border-bottom: 1px solid $font-color;
      height: 120px;
      text-align: center;
      padding-top: 50px;

      p {
        font-weight: bold;
        font-size: 20px;
      }
    }

    .confirm-bottom {
      padding: 10px 40px 10px;
      display: flex;
      justify-content: space-between;
    }

    .button {
      min-width: auto;
      padding: 10px 25px;
    }
  }

}

</style>