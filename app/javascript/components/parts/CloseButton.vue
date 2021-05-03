<template>
  <div id="close-button">
    <i
      class="fas fa-times-circle"
      :class="{ 'delete-hover': isHover }"
      @mouseover="onHover"
      @mouseleave="offHover">
    </i>
  </div>
</template>

<script>
export default {
  methods: {
    onHover() {
      this.isHover = !this.isHover
    },
    offHover() {
      this.isHover = !this.isHover
    }
  },
  data() {
    return {
      isHover: false,
    }
  }
}
</script>

<style lang="scss" scoped>
$danger-color: #E15253;

#close-button {
  i {
    font-size: 30px;
    transition: all .3s;
    -moz-transition: all .3s;
  }

  .delete-hover {
    color: $danger-color;
  }
}

</style>