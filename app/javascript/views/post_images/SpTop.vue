<template>
  <div id="sp-top">
    <div class="sp-top-main">
      <div class="sp-top-texts">
        <h3 class="sp-top-title">
          Bringing Your Art<br />
          to More People....
        </h3>
        <p class="sp-top-subtitle">あなたのイラストや写真をもっと身近にお手軽に</p>
      </div>
      <div class="sp-top-buttons">
        <a href="/users/sign_in" class="top-button button">Log In</a>
        <a href="/users/sign_up" class="top-button button">Sign Up</a>
        <a href="/users/new_guest" class="top-button button" data-method="post">Guest Log In(ポートフォリオ用)</a>
      </div>
    </div>
    <div class="container">
      <div class="sp-top-about">
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
      </div>
    </div>
    <div class="sp-top-use">
      <div class="container">
        <Title title="How to Use"></Title>
        <div class="sp-top-messages">
          <div class="sp-top-message" v-for="(message, index) in messages" :key="message.title">
            <h4>
              <span>{{ index + 1 }}</span>
              {{ message.title }}
            </h4>
            <p>{{ message.content }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import 'top.jpg';
import Title from "../../components/parts/Title.vue";

export default {
  components: {
    Title,
  },
  data() {
    return {
      messages: [
        {
          title: "自分の描いた絵や写真を投稿",
          content: `自分の描いた絵や写真を投稿していいねやメッセージをもらおう！ ハッシュタグをつけて投稿することも可能！ 自分の作品をたくさんのユーザーと共有しよう！`,
        },
        {
          title: `イラストや写真を投稿しているユーザーから自分の好きなユーザーを見つけよう`,
          content: `好きな作品を投稿するユーザーをフォローすることも可能！フォローしたユーザーの作品をチェックしていいねやコメントを残そう！`,
        },
        {
          title: `自分の用途に合わせてユーザーに作品の作成をお願いしよう`,
          content: `好きなユーザーに作品を依頼しよう！ 納期や、使用用途、参考画像などを添付してユーザーに依頼を発注
                    依頼はユーザーが承諾した場合のみ製作されます
                    納期や依頼に無理のないような依頼を心がけよう！`,
        },
      ],
    }
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#sp-top {
  .sp-top-main {
    width: 100%;
    height: 600px;
    background-image: url("~top.jpg");
    background-size: cover;
    background-color:rgba(255,255,255,0.5);
    background-blend-mode:lighten;
  }

  .sp-top-texts {
    position: absolute;
    top: 100px;
    left: 20px;

    h3 {
      font-size: 35px;
      font-family: 'Akaya Telivigala', cursive, 'Nunito', sans-serif;
      font-weight: bold;
    }
    p {
      font-weight: bold;
      font-size: 13px;
    }
  }

  .sp-top-buttons {
    position: absolute;
    width: 100%;
    top: 330px;
    text-align: center;

    .top-button {
      margin-bottom: 15px;
      color: $font-white;
      font-weight: bold;
      width: 260px;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
    }
  }

  /deep/ #title {
    width: 100%;
    margin-bottom: 30px;
    h2 {
      text-align: center;
    }
  }

  .sp-top-about {
    padding: 60px 0;

    h4 {
      color: $accent-color;
      font-weight: bold;
      margin-bottom: 20px;
    }

    p {
      font-size: 13px;
    }
  }

  .sp-top-use {
    background-color: $font-white;
    padding: 60px 0;

    .sp-top-messages {
      .sp-top-message {
        background-color: $back-ground-color;
        padding: 30px 20px 20px;
        border-radius: 20px;
        font-size: 12px;
        margin-bottom: 40px;
        position: relative;

        h4 {
          font-weight: bold;
          margin-bottom: 20px;
          font-size: 15px;
          line-height: 1.5;
        }

        span {
          font-size: 40px;
          color: $accent-color;
          font-weight: 800;
          position: absolute;
          top: -40px;
          left: 7%;
        }
      }
    }
  }
}

</style>