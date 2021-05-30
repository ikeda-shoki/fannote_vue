<template>
  <div id="hamburger-menu" :class="{ active: isHamburgerMenu }" @click="crossOpen">
    <span></span>
    <span></span>
    <span></span>
  </div>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  methods: {
    crossOpen() {
      this.isActive = !this.isActive
      this.$emit("isFade", !this.show)
    }
  },
  props: {
    isModal: {
      type: Boolean,
      required: true,
    },
    isHamburgerMenu: {
      type: Boolean,
      required: true,
    },
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#hamburger-menu {
  position: relative;
  width: 30px;
  height: 22px;
  cursor: pointer;
  span {
    position: absolute;
    left: 0;
    width: 100%;
    height: 4px;
    background-color: $font-color;
    border-radius: 4px;
    display: inline-block;
    transition: all .5s;
    box-sizing: border-box;
  }
  span:nth-of-type(1) {
    top: 0;
    :active {
      -webkit-transform: translateY(20px) rotate(-45deg);
      transform: translateY(20px) rotate(-45deg);
    }
  }
  span:nth-of-type(2) {
    top: 9px;
    :active {
      opacity: 0;
    }
  }
  span:nth-of-type(3) {
    bottom: 0;
    :active {
      -webkit-transform: translateY(-20px) rotate(45deg);
      transform: translateY(-20px) rotate(45deg);
    }
  }
}
#hamburger-menu.active {
  span:nth-of-type(1) {
    -webkit-transform: translateY(20px) rotate(-45deg);
    transform: translateY(11px) rotate(-45deg);
  }
  span:nth-of-type(2) {
    opacity: 0;
  }
  span:nth-of-type(3) {
    -webkit-transform: translateY(-20px) rotate(45deg);
    transform: translateY(-8px) rotate(45deg);
  }
}
</style>