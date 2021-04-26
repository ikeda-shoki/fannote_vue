<template>
  <div class="button">
    <slot>
      <a href="/" class="top-button">
        <span>Button</span>
      </a>
    </slot>
  </div>
</template>

<script>
export default {
}
</script>

<style lang="scss" scoped>
  $accent-color: #e65b20;
  $back-ground-color: #f7f4f2;
  $font-color: #3e1300;
  $font-white: #FFFFFE;

  .button {
    border: none;
    text-align: center;
    display: inline-block;
    min-width: 180px;
    font-size: 20px;
    font-weight: bold;
    text-decoration: none;
    margin: 0;
    padding: 15px 16px;
    background: $back-ground-color;
    color: $font-white;
    border-radius: 3px;
    box-shadow: 0 3px 5px rgba(0,0,0,.4);
    transition: .8s;
    -webkit-transition: .8s;
    position: relative;

    a {
      span {
        transition: .8s;
        -webkit-transition: .8s;
      }
    }

    &:hover {
      background-color: $accent-color;
      a {
        span {
          color: $font-white;
        }
      }

      .top-button {
        &::after {
          background-color: $font-color;
          right: -45px;
        }
      }
    }

    .top-button {

      &::after {
        position: absolute;
        top: 50%;
        right: -35px;
        transform: translateY(-50%);
        background-color: $accent-color;
        border-radius: 5px;
        content: "";
        display: block;
        width: 50px;
        height: 2px;
        transition: .8s;
        -webkit-transition: .8s;
      }
    }
  }
</style>