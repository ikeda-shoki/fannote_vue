<template>
  <div id="user-withdrawal">
    <div class="container">
      <div class="withdrawal-main">
        <h1>退会が完了しました！</h1>
        <p>また機会があれば是非ご活用ください！</p>

        <a href="/" class="button">トップページへ</a>
      </div>
    </div>
    <Footer></Footer>
  </div>
</template>

<script>
import Footer from "../../components/Footer.vue";

export default {
  components: {
    Footer,
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#user-withdrawal {
  text-align: center;

  .container {
    min-height: 100vh;
  }

  .withdrawal-main {
    padding-top: 300px;

    h1 {
      font-size: 40px;
      font-weight: bold;
    }

    p {
      margin: 10px 0 50px;
    }
  }
}

</style>