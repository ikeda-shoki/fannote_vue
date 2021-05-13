<template>
  <div id="request-detail-modal">
    <div class="request-detail-modal-contents">
      <div class="request-detail-modal-content" v-for="requestContent in requestContents" :key="requestContent.id">
        <div class="request-detail-modal-left">
          <h6>{{ requestContent.title }}</h6>
        </div>
        <div class="request-detail-modal-right">
          <template v-if="requestContent.title === '参考画像'">
            <img :src="requestContent.content" alt="参考画像" v-if="requestContent.reference_image">
            <img src="~no_image.jpg" alt="NoImage" v-else />
          </template>
          <template v-else-if="requestContent.title === '受付状況'">
            <RequestStatus :requestStatus="requestContent.content"></RequestStatus>
          </template>
          <h5 v-else>{{ requestContent.content }}</h5>
        </div>
      </div>
      <div class="request-detail-modal-buttons">
        <button class="button" @click="modalChenge">依頼を変更する</button>
        <button class="button">依頼を削除する</button>
      </div>
    </div>
  </div>
</template>

<script>
import "no_image.jpg";
import RequestStatus from "../parts/RequestStatus.vue"

export default {
  props: {
    request: { type: Object, required: true }
  },
  data() {
    return {
      requestContents: [
        { title: "内容詳細", content: this.request.request_introduction },
        { title: "参考画像", content: this.request.reference_image },
        { title: "ファイル形式", content: this.request.file_format },
        { title: "用途", content: this.request.use },
        { title: "枚数", content: this.request.amount + '枚' },
        { title: "納期", content: this.request.deadline },
        { title: "受付状況", content: this.request.request_status },
      ]
    }
  },
  components: {
    RequestStatus,
  },
  methods: {
    modalChenge() {
      this.$emit("modalChenge");
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

#request-detail-modal {
  height: 94%;
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;
  text-align: left;

  .request-detail-modal-contents {
    .request-detail-modal-content {
      margin-bottom: 20px;
      display: flex;
      flex-direction: row;
      align-items: center;
      flex-wrap: wrap;
      width: 100%;
    }

    .request-detail-modal-buttons {
      margin-top: 70px;
      text-align: center;
    }
  }

  .request-detail-modal-left {
    width: 30%;
  }

  .request-detail-modal-right {
    margin-left: auto;
    width: 65%;

    img {
      width: 50%;
    }

    h5 {
      font-size: 25px;
      font-weight: bold;
    }
  }
}
</style>