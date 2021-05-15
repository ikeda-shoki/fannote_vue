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
          @success="successPostImage"
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
        <template v-if="editData.requested_user">
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
        <template v-if="editData.requesting_user">
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
        ></RequestDetailModal>
      </div>
      <div class="modal-main" v-if="modalType === 'リクエストを編集'">
        <template v-if="editData.requested_user.account_name">
          <ModalHeader
            :header="
              editData.requested_user.account_name + 'への依頼を変更する'
            "
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
    },
    successPostImage(value) {
      this.$emit("modalClose", false);
      this.$emit("screenTransition", value);
    },
    successUser() {
      this.$emit("modalClose", false);
      this.$emit("successUser");
    },
    postImageDeleteSuccess(value) {
      this.$router.push("/users/" + value);
    },
    successRequest() {
      this.$emit("screenTransition");
    },
    requestModalChenge() {
      this.$emit("requestModalChenge");
    },
    successRequestUpdate(value) {
      this.$emit("successRequestUpdate", value);
    },
    requestDelete() {
      this.$emit("requestDelete", this.index);
    },
    requestStatusUpdate() {
      this.$emit("requestStatusUpdate");
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
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;

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
    height: 87%;
    margin: 0 auto;
    border-radius: 20px;
    margin-top: 50px;
    min-height: 200px;
    position: relative;

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
