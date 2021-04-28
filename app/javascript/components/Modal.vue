<template>
  <div id="modal" @click.self="modalClose">
    <div class="modal-content" v-if="modalType === '投稿する'">
      <PostImageModal></PostImageModal>
    </div>
  </div>
</template>

<script>
import PostImageModal from './modal/PostImageModal.vue'

export default {
  props: {
    isShow: {
      type: Boolean,
      required: true,
    },
    modalType: {
      type: String
    }
  },
  methods: {
    modalClose(){
      this.$emit("modalClose", !this.isShow)
    }
  },
  components: {
    PostImageModal,
  }
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
    width: 70%;
    padding: 30px 25px;
    margin: 0 auto;
    border-radius: 20px;
    margin-top: 200px;
    min-height: 200px;
  }
}
</style>