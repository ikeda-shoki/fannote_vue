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
        ></PostImageEditModal>
      </div>
      <div class="modal-main" v-if="modalType === 'ユーザーを編集する'">
        <ModalHeader header="ユーザー 編集画面"></ModalHeader>
        <UserEditModal
          :editData="editData"
          @success="successUser"
        ></UserEditModal>
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
    }
  },
  components: {
    PostImageModal,
    PostImageEditModal,
    ModalHeader,
    CloseButton,
    UserEditModal,
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
