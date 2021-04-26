<template>
  <div id="use">
    <div class="container">
      <Title title="How to Use"></Title>
      <div class="top-messages">
        <div class="top-message" v-for="message in messages" :key="message.id">
          <div class="top-message-left">
            <h4>
              <span>{{ message.number }}</span>
              {{ message.title }}
            </h4>
            <p>{{ message.content }}</p>
          </div>
          <div class="top-message-right">
            <img :src="message.image" :class="{ visible: positionY > message.scroll }">
          </div>
        </div>
      </div>
      <TopButtons></TopButtons>
    </div>
  </div>
</template>

<script>
import Title from "../components/parts/Title.vue";
import TopButtons from "../components/TopButtons.vue";
import "top-message-1.png";
import "top-message-2.png";
import "top-message-3.png";

export default {
  components: {
    Title,
    TopButtons,
  },
  mounted() {
    window.addEventListener('scroll', this.checkScroll)
  },
  methods: {
    checkScroll() {
      this.positionY = window.scrollY
    }
  },
  data() {
    return {
      positionY: 0,
      messages: [
        {
          number: "01",
          title: "自分の描いた絵や写真を投稿",
          content: `自分の描いた絵や写真を投稿していいねやメッセージをもらおう！ ハッシュタグをつけて投稿することも可能！ 自分の作品をたくさんのユーザーと共有しよう！`,
          image: "/packs/media/images/top-message-1-d8859a03.png",
          scroll: 0,
        },
        {
          number: "02",
          title: `イラストや写真を投稿しているユーザーから自分の好きなユーザーを見つけよう`,
          content: `好きな作品を投稿するユーザーをフォローすることも可能！フォローしたユーザーの作品をチェックしていいねやコメントを残そう！`,
          image: "/packs/media/images/top-message-2-c583d0c3.png",
          scroll: 300,
        },
        {
          number: "03",
          title: `自分の用途に合わせてユーザーに作品の作成をお願いしよう`,
          content: `好きなユーザーに作品を依頼しよう！ 納期や、使用用途、参考画像などを添付してユーザーに依頼を発注
                    依頼はユーザーが承諾した場合のみ製作されます
                    納期や依頼に無理のないような依頼を心がけよう！`,
          image: "/packs/media/images/top-message-3-6c41965b.png",
          scroll: 600,
        },
      ],
    };
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;

#use {
  padding-top: 13%;
  text-align: center;
  background-color: $font-white;

  .top-messages {
    margin: 50px 0 100px;
  }

  .top-message {
    display: flex;
    justify-content: center;
    margin: 15px 0;
    align-items: center;
    text-align: left;

    &:nth-child(2) {
      flex-direction: row-reverse;
    }

    &:nth-child(odd) {
      margin-left: 30px;
    }

    &-left {
      width: 500px;
      background-color: $font-white;
      padding: 50px 40px 30px;
      border-radius: 20px;
      position: relative;

      h4 {
        font-weight: bold;
        margin-bottom: 20px;
        font-size: 20px;
        line-height: 1.5;
      }

      span {
        font-size: 60px;
        color: $accent-color;
        font-weight: 800;
        position: absolute;
        top: -30px;
        left: -10%;
      }
    }

    &-right {
      mix-blend-mode: multiply;
      width: 400px;
      height: 310px;

      img {
        width: 100%;
        height: auto;
        transition: all 1s;
        -moz-transition: all 1s;
        opacity: 0;
      }

      .visible {
        opacity: 1;
      }
    }
  }

  .top-buttons {
    position: static;
    margin: 0 auto;
    padding-bottom: 100px;
  }
}
</style>