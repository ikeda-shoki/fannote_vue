<template>
  <div
    id="post-image-tag"
    :class="{ illust: tagName === 'イラスト', photo: tagName === '写真', logo: tagName === 'ロゴ'}"
    >
    <i class="fas fa-tag"></i>
    <span v-if="tagName === 'イラスト'">イラスト</span>
    <span v-if="tagName === '写真'">写真</span>
    <span v-if="tagName === 'ロゴ'">ロゴ</span>
  </div>
</template>

<script>
export default {
  props: {
    tagName: {
      required: true,
    }
  }
}
</script>

<style lang="scss" scoped>
$back-ground-color: #f7f4f2;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

  #post-image-tag {
    padding: 5px 10px;
    border-radius: 5px;
    display: inline-block;

    @include sp {
      font-size: 10px;
      padding: 5px;
    }

    span {
      color: $back-ground-color;
      font-weight: bold;
    }

    i {
      color: $back-ground-color;
    }
  }

  .illust {
    background-color: #e47863;
  }

  .photo {
    background-color: #53b39a;
  }

  .logo {
    background-color: #f4d650;
  }
</style>