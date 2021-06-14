<template>
  <transition-group name="fade-list">
    <LoadingCompornent
      v-if="isLoading === true"
      key="loader"
    ></LoadingCompornent>
    <div id="user-requesting" v-if="isLoading === false" key="noloader">
      <transition name="alert">
        <Alert :type="alertType.type" v-if="isAlert === true">
          {{ alertType.message }}
        </Alert>
      </transition>
      <template v-if="$route.name === 'requesting'">
        <div class="user-requesting-title">
          <Title title="依頼中の内容一覧"></Title>
          <span>全{{ requests.length }}件</span>
        </div>
        <div
          class="user-requesting-items"
          v-for="(request, index) in getItems"
          :key="request.id"
        >
          <RequestItem
            :user="request.requested_user"
            :request="request"
            v-if="request.requested_user"
            @click.native="modalOpen(request, index)"
          ></RequestItem>
        </div>
        <template v-if="(getPageCount > 1)">
          <paginate
            :page-count="getPageCount"
            :prev-text="'<'"
            :next-text="'>'"
            :click-handler="clickCallback"
            :container-class="'pagination'"
            :page-class="'page-item'"
            :page-link-class="'page-link'"
            :prev-class="'page-item'"
            :prev-link-class="'page-link'"
            :next-class="'page-item'"
            :next-link-class="'page-link'"
            :first-last-button="true"
            :first-button-text="'<<'"
            :last-button-text="'>>'"
          >
          </paginate>
        </template>
      </template>

      <template v-if="$route.name === 'requested'">
        <div class="user-requesting-title">
          <Title title="依頼された内容一覧"></Title>
          <span>全{{ requests.length }}件</span>
        </div>
        <div
          class="user-requesting-items"
          v-for="(request, index) in getItems"
          :key="request.id"
        >
          <RequestItem
            :user="request.requesting_user"
            :request="request"
            v-if="request.requesting_user"
            @click.native="modalOpen(request, index)"
          ></RequestItem>
        </div>
        <template v-if="(getPageCount > 1)">
          <paginate
            :page-count="getPageCount"
            :prev-text="'<'"
            :next-text="'>'"
            :click-handler="clickCallback"
            :container-class="'pagination'"
            :page-class="'page-item'"
            :page-link-class="'page-link'"
            :prev-class="'page-item'"
            :prev-link-class="'page-link'"
            :next-class="'page-item'"
            :next-link-class="'page-link'"
            :first-last-button="true"
            :first-button-text="'<<'"
            :last-button-text="'>>'"
          >
          </paginate>
        </template>
      </template>
    </div>
    <Modal
      key="modal"
      v-if="isModal ? true : false"
      :isShow="isModal"
      :editData="request"
      :modalType="modalType"
      :index="index"
      @modalClose="modalClose"
      @requestStatusUpdate="successRequestStatusUpdate"
      @requestImageUpdate="requestImageUpdate"
      @requestModalChenge="modalType = 'リクエストを編集'"
      @successRequestUpdate="successRequestUpdate"
      @requestDelete="successRequestDelete"
    ></Modal>
  </transition-group>
</template>

<script>
import axios from "axios";
import LoadingCompornent from "../../components/parts/LoadingCompornent.vue";
import Title from "../../components/parts/Title.vue";
import RequestItem from "../../components/parts/RequestItem.vue";
import Modal from "../../components/Modal.vue";
import Alert from "../../components/parts/Alert.vue";


export default {
  data() {
    return {
      isModal: false,
      isLoading: true,
      modalType: "",
      requests: [],
      request: {},
      index: 0,
      isAlert: false,
      alertType: {
        type: "",
        message: "",
      },
      parPage: 5,
      currentPage: 1,
    };
  },
  components: {
    Title,
    RequestItem,
    Modal,
    LoadingCompornent,
    Alert,
  },
  props: {
    user: { type: Object, required: true },
  },
  methods: {
    async getInfoRequesting() {
      await axios
        .get("/api/v1/users/" + this.$route.params.id + "/requesting")
        .then(
          (response) => {
            this.requests = response.data.requests;
          })
        .catch(
          (error) => {
            console.log(error)
            this.$router.push("/errors");
          });
      this.isLoading = false;
    },
    async getInfoRequested() {
      await axios
        .get("/api/v1/users/" + this.$route.params.id + "/requested")
        .then(
          (response) => {
            this.requests = response.data.requests;
          })
        .catch(
          (error) => {
            this.$router.push("/errors");
          });
      this.isLoading = false;
    },
    modalOpen(value, index) {
      this.isModal = true;
      this.request = value;
      this.index = index;
      this.modalType = "リクエスト詳細";
    },
    modalClose() {
      this.isModal = false;
      this.request = {};
    },
    updateAlert() {
      this.alertType.type = "success";
      this.alertType.message = "依頼を変更しました！";
      this.isAlert = true;
    },
    async successUpdateAlert() {
      await this.updateAlert();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    requestUpdate(value) {
      this.request.request_introduction = value.request.request_introduction;
      this.request.use = value.request.use;
      this.request.file_format = value.request.file_format;
      this.request.deadline = value.request.deadline;
      this.request.amount = value.request.amount;
      this.request.reference_image = value.reference_image;
    },
    async chengeModal(value) {
      await this.requestUpdate(value);
      this.modalType = "リクエスト詳細";
    },
    async successRequestUpdate(value) {
      await this.chengeModal(value);
      this.successUpdateAlert();
    },
    deleteAlert() {
      this.alertType.type = "danger";
      this.alertType.message = "依頼を削除しました。";
      this.isAlert = true;
    },
    async successDeleteAlert() {
      await this.deleteAlert();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    requestDelete(index) {
      this.modalClose();
      this.requests.splice(index, 1);
      this.index = 0;
    },
    async successRequestDelete(index) {
      await this.requestDelete(index);
      this.successDeleteAlert();
    },
    updateStatusAlert(status) {
      if (status === "製作中") {
        this.alertType.type = "success";
        this.alertType.message = "依頼を承諾しました！";
        this.isAlert = true;
      } else if (status === "受付不可") {
        this.alertType.type = "danger";
        this.alertType.message = "依頼の製作を中止しました。";
        this.isAlert = true;
      }
    },
    async successUpdateStatusAlert(status) {
      await this.updateStatusAlert(status);
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    requestStatusUpdate() {
      this.modalClose();
      this.getInfoRequested();
    },
    async successRequestStatusUpdate(status) {
      await this.requestStatusUpdate();
      this.successUpdateStatusAlert(status);
    },
    requestImageUpdate() {
      this.modalClose();
      this.getInfoRequested();
    },
    createAlert() {
      this.alertType.type = "success";
      this.alertType.message = "依頼を送信しました！";
      this.isAlert = true;
    },
    async successCreateAlert() {
      await this.createAlert();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    async createRequestGetInfoRequesting() {
      await this.getInfoRequesting();
      this.successCreateAlert();
    },
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
    },
    completeAlert() {
      this.alertType.type = "success";
      this.alertType.message = "依頼を完了して履歴を削除しました！";
      this.isAlert = true;
    },
    async successCompleteAlert() {
      await this.completeAlert();
      setTimeout(() => {
        this.isAlert = false;
      }, 3000);
    },
    async completeRequestGetInfoRequesting() {
      await this.getInfoRequesting();
      this.successCompleteAlert();
    },
  },
  mounted() {
    if (this.$route.name === "requesting") {
      if (this.$route.query.method === "create") {
        this.createRequestGetInfoRequesting();
      }
      else if(this.$route.query.method === "complete") {
        this.completeRequestGetInfoRequesting();
      }
      else {
        this.isLoading = true;
        this.getInfoRequesting();
      }
    }
    if (this.$route.name === "requested") {
      this.isLoading = true;
      this.getInfoRequested();
    }
  },
  watch: {
    $route: function(to, from) {
      if (to.name === "requesting") {
        this.isLoading = true;
        this.getInfoRequesting();
      }
      if (to.name === "requested") {
        this.isLoading = true;
        this.getInfoRequested();
      }
    },
  },
  computed: {
    getItems() {
      let current = this.currentPage * this.parPage;
      let start = current - this.parPage;
      return this.requests.slice(start, current);
    },
    getPageCount() {
      return Math.ceil(this.requests.length / this.parPage);
    },
  },
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

      @include sp {
        top: 40px;
        right: 5%;
      }
    }
  }

  .pagination {
    display: flex;
    justify-content: center;
    margin: 10px 0 30px;

    /deep/ .page-item {
      margin: 0 3px;

      .page-link {
        display: block;
        width: 30px;
        height: 30px;
        line-height: 30px;
        border-radius: 5px;
        transition: all 0.5s;
        -moz-transition: all 0.5s;

        &:hover {
          background-color: $accent-color;
          color: $font-white;
          font-weight: bold;
        }
      }
    }
    /deep/ .active {
      .page-link {
        background-color: $accent-color;
        color: $font-white;
        font-weight: bold;
      }
    }
  }
}
</style>
