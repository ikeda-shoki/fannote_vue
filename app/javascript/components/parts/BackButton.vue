<template>
  <div class="back-button">
    <template v-if="link">
      <router-link :to="link" class="back-button-link">
        <i class="fas fa-chevron-circle-left"></i><slot>前の画面に戻る</slot>
      </router-link>
    </template>
    <template v-else>
      <p class="back-button-link" @click="backPage">
        <i class="fas fa-chevron-circle-left"></i><slot>前の画面に戻る</slot>
      </p>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    link: {
      type: String,
    },
  },
  methods: {
    backPage() {
      this.$router.go(-1);
    }
  }
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

.back-button {
  position: absolute;
  top: 110px;
  left: 40px;
  border-radius: 20px;
  transition: all 1s;
  -moz-transition: all 1s;

  @include sp {
    background-color: $accent-color;

    .back-button-link {
      color: $font-white;
      font-weight: bold;
    }

    i {
      color: $font-white;
    }
  }

  .back-button-link {
    padding: 10px 20px;
    display: block;
  }

  &:hover {
    background-color: $accent-color;

    .back-button-link {
      color: $font-white;
      font-weight: bold;
    }

    i {
      color: $font-white;
    }
  }
}
</style>
