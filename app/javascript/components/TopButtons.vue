<template>
  <div class="top-buttons">
    <Button>
      <a href="" class="top-button"><span>Log In</span></a>
    </Button>
    <Button>
      <a href="" class="top-button"><span>Sign Up</span></a>
    </Button>
    <Button>
      <a href="" class="top-button"><span>Guest Log In(ポートフォリオ用)</span></a>
    </Button>
  </div>
</template>

<script>
import Button from './parts/Button.vue'

export default {
  components: {
    Button,
  }
}
</script>

<style lang="scss" scoped>
  .top-buttons {
      position: absolute;
      top: 400px;
      right: 100px;
      width: 450px;
      display: flex;
      justify-content: space-around;
      flex-wrap: wrap;

      div {
        &:last-child {
          margin-top: 20px;
        }
      }
    }
</style>