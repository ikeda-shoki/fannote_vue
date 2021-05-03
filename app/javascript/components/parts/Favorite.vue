<template>
  <div id="favorite">
    <div class="on-favorite" @click="offFavorite" v-if="isFavorite">
      <i class="fas fa-heart on-favorite"></i>
    </div>
    <div class="no-favorite" @click="onFavorite" v-else>
      <i class="fas fa-heart"></i>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
    }
  },
  props: {
    isFavorite: { required: true }
  },
  methods: {
    onFavorite(){
      axios({
        url: "/api/v1/post_images/" + this.$route.params.id + "/favorites",
        data: {
          post_image_id: this.$route.params.id
        },
        method: "POST",
      }).then(response => {
        this.$emit('chengeFavorite', [ true, "up"])
      }).catch(error => {
        console.log(error);
      })
    },
    offFavorite() {
      axios({
        url: "/api/v1/post_images/" + this.$route.params.id + "/favorites",
        data: {
          post_image_id: this.$route.params.id
        },
        method: "DELETE",
      }).then(response => {
        this.$emit('chengeFavorite', [ false, "down" ])
      }).catch(error => {
        console.log(error);
      })
    },
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