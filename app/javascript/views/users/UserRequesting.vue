<template>
  <div id="user-requesting">
    <div class="user-requesting-title">
      <Title title="依頼中の内容一覧"></Title>
      <span>全{{ requests.length }}件</span>
    </div>
    <div class="user-requesting-items" v-for="request in requests" :key="request.id">
      <RequestItem :user="request.requested_user" :request="request" @click.native="modalOpen(request)"></RequestItem>
    </div>
    <transition name="fade">
      <Modal
        v-if="isModal ? true : false"
        :isShow="isModal"
        :editData="request"
        modalType="リクエスト詳細"
        @modalClose="modalClose"
        @requestModalChenge="modalType = 'リクエストを編集する'"
      ></Modal>
    </transition>
  </div>
</template>

<script>
import axios from "axios";
import Title from "../../components/parts/Title.vue";
import RequestItem from "../../components/parts/RequestItem.vue"
import Modal from "../../components/Modal.vue"

export default {
  data() {
    return {
      isModal: false,
      requests: [],
      request: {},
    }
  },
  components: {
    Title,
    RequestItem,
    Modal,
  },
  props: {
    user: { type: Object, required: true },
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/users/" + this.$route.params.id + "/requesting").then(
        (response) => {
          this.requests = response.data.requests;
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
    modalOpen(value) {
      this.isModal = true;
      this.request = value;
    },
    modalClose() {
      this.isModal = false;
      this.request = {};
    }
  },
  created() {
    this.getInfo();
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#user-requesting {
  .user-requesting-title {
    position: relative;
    margin-bottom: 50px;

    #title {
      font-size: 28px;
      /deep/ h2 {
        font-weight: 800;
      }
    }

    span {
      position: absolute;
      top: 28px;
      right: 20%;
    }
  }
}
</style>
