<template>
  <div id="about">
    <div class="container">
      <Title title="About"></Title>
      <div class="about-text">
        <h4>イラストを描いて欲しい、こんな写真が欲しいをもっと手軽に！</h4>
        <p>
          FanNotesでは登録しているユーザーにイラストや、写真を手軽に発注することが出来ます<br>
          アイコンの作成や、オリジナルキャラクターのリメイク、似顔絵やHPなどで使う素材などを自分が見つけた好きな絵を描くユーザー、写真を撮るユーザーに簡単に依頼しよう<br>
          もちろんイラストや写真を閲覧するだけでも可能！<br>
          お気に入りのユーザーを見つけて自分の為のイラストや写真を製作してもらおう！
        </p>
      </div>
      <TopButtons></TopButtons>
    </div>
  </div>
</template>

<script>
import Title from '../../components/parts/Title.vue'
import TopButtons from '../../components/TopButtons.vue'

export default {
  components: {
    Title,
    TopButtons,
  }
}
</script>

<style lang="scss" scoped>
  $accent-color: #e65b20;

  #about {
    padding-top: 13%;
    text-align: center;

    .about-text {
      margin: 50px 0 100px;

      h4 {
        font-size: 32px;
        color: $accent-color;
        font-weight: bold;
      }
    }

    .top-buttons {
      margin: 0 auto;
      position: static;
      margin-bottom: 100px;
    }
  }
</style>