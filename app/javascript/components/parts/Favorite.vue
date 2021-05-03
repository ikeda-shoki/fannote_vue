<template>
  <div id="favorite" @click="favorite">
    <i
      class="fas fa-heart"
      :class="{ 'on-favorite': isFavorite }">
    </i>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isFavorite: false,
    }
  },
  methods: {
    favorite(){
      this.isFavorite = !this.isFavorite
    }
  }
}
</script>

<style lang="scss" scoped>
$danger-color: #E15253;

  #favorite {

    i {
      font-size: 26px;
    }

    .on-favorite {
      color: $danger-color;
    }
  }
</style>