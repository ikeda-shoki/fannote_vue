<template>
  <div id="modal">
    <div class="modal-content">
      <div class="modal-main" v-if="modalType === '投稿する'">
        <ModalHeader header="新規投稿"></ModalHeader>
        <PostImageModal @success="successPostImage"></PostImageModal>
      </div>

      <div class="modal-main" v-if="modalType === '編集する'">
        <ModalHeader header="投稿 編集画面"></ModalHeader>
        <PostImageEditModal
          :editData="editData"
          @success="successEditPostImage"
          @postImageDeleteSuccess="postImageDeleteSuccess"
        ></PostImageEditModal>
      </div>

      <div class="modal-main" v-if="modalType === 'ユーザーを編集する'">
        <ModalHeader header="ユーザー 編集画面"></ModalHeader>
        <UserEditModal
          :editData="editData"
          @success="successUser"
        ></UserEditModal>
      </div>

      <div class="modal-main" v-if="modalType === 'リクエストを依頼する'">
        <template v-if="editData.account_name">
          <ModalHeader
            :header="editData.account_name + 'へ作品を依頼する'"
          ></ModalHeader>
        </template>
        <template v-else>
          <ModalHeader
            :header="editData.user_name + 'へ作品を依頼する'"
          ></ModalHeader>
        </template>
        <RequestModal :user="editData" @success="successRequest"></RequestModal>
      </div>

      <div class="modal-main" v-if="modalType === 'リクエスト詳細'">
        <template v-if="$route.name === 'requesting'">
          <template v-if="editData.requested_user.account_name">
            <ModalHeader
              :header="editData.requested_user.account_name + 'への依頼'"
            ></ModalHeader>
          </template>
          <template v-else>
            <ModalHeader
              :header="editData.requested_user.user_name + 'への依頼'"
            ></ModalHeader>
          </template>
        </template>
        <template v-if="$route.name === 'requested'">
          <template v-if="editData.requesting_user.account_name">
            <ModalHeader
              :header="editData.requesting_user.account_name + 'からの依頼'"
            ></ModalHeader>
          </template>
          <template v-else>
            <ModalHeader
              :header="editData.requesting_user.user_name + 'からの依頼'"
            ></ModalHeader>
          </template>
        </template>
        <RequestDetailModal
          :request="editData"
          @modalChenge="requestModalChenge"
          @successDelete="requestDelete"
          @successRequestStatusUpdate="requestStatusUpdate"
          @successRequestImageUpdate="requestImageUpdate"
        ></RequestDetailModal>
      </div>

      <div class="modal-main" v-if="modalType === 'リクエストを編集'">
        <template v-if="editData.requested_user.account_name">
          <ModalHeader
            :header="editData.requested_user.account_name + 'への依頼を変更する'"
          ></ModalHeader>
        </template>
        <template v-else>
          <ModalHeader
            :header="editData.requested_user.user_name + 'への依頼を変更する'"
          ></ModalHeader>
        </template>
        <RequestEditModal
          :editData="editData"
          @success="successRequestUpdate"
        ></RequestEditModal>
      </div>

      <div class="modal-main" v-if="modalType === '通知'">
        <ModalHeader header="通知一覧"></ModalHeader>
        <NotificationsModal @modalClose="modalClose"></NotificationsModal>
      </div>

      <CloseButton @click.native="modalClose"></CloseButton>
    </div>
  </div>
</template>

<script>
import PostImageModal from "./modal/PostImageModal.vue";
import ModalHeader from "./modal/ModalHeader.vue";
import CloseButton from "./parts/CloseButton.vue";
import PostImageEditModal from "./modal/PostImageEditModal.vue";
import UserEditModal from "./modal/UserEditModal.vue";
import RequestModal from "./modal/RequestModal.vue";
import RequestDetailModal from "./modal/RequestDetailModal.vue";
import RequestEditModal from "./modal/RequestEditModal.vue";
import NotificationsModal from "./modal/NotificationsModal.vue";
import { disableBodyScroll, enableBodyScroll, clearAllBodyScrollLocks } from 'body-scroll-lock';

export default {
  props: {
    isShow: {
      type: Boolean,
      required: true,
    },
    modalType: {
      type: String,
    },
    editData: {
      type: Object,
    },
    index: { type: Number },
  },
  methods: {
    modalClose() {
      this.$emit("modalClose", false);
      clearAllBodyScrollLocks();
    },
    successPostImage(value) {
      this.$emit("modalClose", false);
      this.$emit("screenTransition", value);
      clearAllBodyScrollLocks();
    },
    successEditPostImage() {
      this.$emit("modalClose", false);
      this.$emit("postImageUpdate", false);
      clearAllBodyScrollLocks();
    },
    postImageDeleteSuccess(value) {
      this.$router.push({ path: "/users/" + value, query: { id: value, method: "delete" } });
      clearAllBodyScrollLocks();
    },
    successUser() {
      this.$emit("modalClose", false);
      this.$emit("successUser");
      clearAllBodyScrollLocks();
    },
    successRequest() {
      this.$emit("screenTransition");
      clearAllBodyScrollLocks();
    },
    requestModalChenge() {
      this.$emit("requestModalChenge");
      clearAllBodyScrollLocks();
    },
    successRequestUpdate(value) {
      this.$emit("successRequestUpdate", value);
      clearAllBodyScrollLocks();
    },
    requestDelete() {
      this.$emit("requestDelete", this.index);
      clearAllBodyScrollLocks();
    },
    requestStatusUpdate(status) {
      this.$emit("requestStatusUpdate", status);
      clearAllBodyScrollLocks();
    },
    requestImageUpdate() {
      this.$emit("requestImageUpdate");
      clearAllBodyScrollLocks();
    }
  },
  components: {
    PostImageModal,
    PostImageEditModal,
    ModalHeader,
    CloseButton,
    UserEditModal,
    RequestModal,
    RequestDetailModal,
    RequestEditModal,
    NotificationsModal,
  },
  mounted() {
    var modal = document.querySelector('#modal');
    disableBodyScroll(modal);
  },
  beforeDestroy() {
    clearAllBodyScrollLocks();
  }
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$sp: 480px;

@mixin sp {
  @media screen and (max-width: 767px) {
    @content;
  }
}

#modal {
  z-index: 10;
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(22, 22, 21, 0.7);

  .modal-content {
    background-color: $back-ground-color;
    width: 60%;
    height: 700px;
    margin: 0 auto;
    border-radius: 20px;
    margin-top: 50px;
    min-height: 200px;
    position: relative;

    @include sp {
      width: 95%;
    }

    .modal-main {
      height: 100%;
    }

    #close-button {
      z-index: 900;
      position: absolute;
      top: -10px;
      right: -15px;
    }
  }
}
</style>
