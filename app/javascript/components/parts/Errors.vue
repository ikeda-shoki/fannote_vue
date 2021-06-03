<template>
  <div id="errors">
    <div class="error-message">
      <h1 class="dialog-logo">FanNotes</h1>
      <h3 class="dialog-access">Not Found</h3>
      <h2 class="dialog-title">お探しのページが見つかりませんでした。</h2>
      <p>大変お手数ですが、下記のボタンからトップページへお戻りください</p>
      <router-link to="/" class="dialog-button button">トップページへ</router-link>
    </div>
    <p>ご迷惑をおかけしますが、何卒よろしくお願い致します。</p>
  </div>
</template>

<script>
import Title from "../parts/Title.vue";

export default {
  components: {
    Title,
  }
}
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

#errors {
  width: 100%;
  height: 100vh;
  text-align: center;

  .error-message {
    width: 95%;
    max-width: 33em;
    margin: 10em auto 0;
    border-radius: 20px;

    .dialog-logo {
      font-family: 'Akaya Telivigala', cursive, 'Nunito', sans-serif;
      font-size: 90px;
      margin-bottom: 20px;
    }

    .dialog-access {
      font-weight: 800;
      color: $accent-color;
      font-size: 30px;
      margin-bottom: 0;
    }

    .dialog-button {
      margin: 20px 0;
    }

    .dialog-title {
      margin-bottom: 50px;
      margin-top: 0;
    }
  }
}

</style>