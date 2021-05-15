<template>
  <div id="user-requesting">
    <template v-if="$route.name === 'requesting'">
      <div class="user-requesting-title">
        <Title title="依頼中の内容一覧"></Title>
        <span>全{{ requests.length }}件</span>
      </div>
      <div class="user-requesting-items" v-for="(request, index) in requests" :key="request.id">
        <RequestItem :user="request.requested_user" :request="request" @click.native="modalOpen(request, index)"></RequestItem>
      </div>
      <transition name="fade">
        <Modal
          v-if="isModal ? true : false"
          :isShow="isModal"
          :editData="request"
          :modalType="modalType"
          :index="index"
          @modalClose="modalClose"
          @requestModalChenge="modalType = 'リクエストを編集'"
          @successRequestUpdate="successRequestUpdate"
          @requestDelete="requestDelete"
        ></Modal>
      </transition>
    </template>

    <template v-if="$route.name === 'requested'">
      <div class="user-requesting-title">
        <Title title="依頼された内容一覧"></Title>
        <span>全{{ requests.length }}件</span>
      </div>
      <div class="user-requesting-items" v-for="(request, index) in requests" :key="request.id">
        <RequestItem :user="request.requesting_user" :request="request" @click.native="modalOpen(request, index)"></RequestItem>
      </div>
      <transition name="fade">
        <Modal
          v-if="isModal ? true : false"
          :isShow="isModal"
          :editData="request"
          :modalType="modalType"
          :index="index"
          @modalClose="modalClose"
          @requestStatusUpdate="requestStatusUpdate"
        ></Modal>
      </transition>
    </template>

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
      modalType: "",
      requests: [],
      request: {},
      index: 0,
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
    getInfoRequesting() {
      axios.get("/api/v1/users/" + this.$route.params.id + "/requesting").then(
        (response) => {
          this.requests = response.data.requests;
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
    getInfoRequested() {
      axios.get("/api/v1/users/" + this.$route.params.id + "/requested").then(
        (response) => {
          this.requests = response.data.requests;
          console.log(response.data)
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
    modalOpen(value, index) {
      this.isModal = true;
      this.request = value;
      this.index = index;
      this.modalType = "リクエスト詳細"
    },
    modalClose() {
      this.isModal = false;
      this.request = {};
    },
    successRequestUpdate(value) {
      this.request.request_introduction = value.request.request_introduction
      this.request.use = value.request.use
      this.request.file_format = value.request.file_format
      this.request.deadline = value.request.deadline
      this.request.amount = value.request.amount
      this.request.reference_image = value.reference_image
      this.modalType = "リクエスト詳細"
    },
    requestDelete(index) {
      this.modalClose();
      this.requests.splice(index, 1);
      this.index = 0;
    },
    requestStatusUpdate() {
      this.modalClose();
      this.getInfoRequested();
    },
  },
  mounted() {
    if(this.$route.name === "requesting"){
      this.getInfoRequesting();
    }
    else if(this.$route.name === "requested"){
      this.getInfoRequested();
    }
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
