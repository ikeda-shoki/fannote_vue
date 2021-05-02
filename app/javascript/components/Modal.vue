<template>
  <div id="modal">
    <div class="modal-content">
      <div class="modal-main" v-if="modalType === '投稿する'">
        <ModalHeader header="新規投稿"></ModalHeader>
        <PostImageModal @success="modalClose"></PostImageModal>
      </div>
      <CloseButton @click.native="modalClose"></CloseButton>
    </div>
  </div>
</template>

<script>
import PostImageModal from "./modal/PostImageModal.vue";
import ModalHeader from "./modal/ModalHeader.vue";
import CloseButton from "./parts/CloseButton.vue";

export default {
  props: {
    isShow: {
      type: Boolean,
      required: true,
    },
    modalType: {
      type: String,
    },
  },
  methods: {
    modalClose() {
      this.$emit("modalClose", !this.isShow);
    },
  },
  components: {
    PostImageModal,
    ModalHeader,
    CloseButton,
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
  background-color: rgba(22, 22, 21, .7);

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
