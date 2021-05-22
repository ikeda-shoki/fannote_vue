<template>
  <div class="mycomment">
    <div class="mycomment-delete-button">
      <i class="fas fa-times-circle" @click="chatDelete(index)"></i>
    </div>
    <p>{{ chat.message }}</p>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  props: {
    chat: { type: Object, required: true, default: {} },
    index: { type: Number, required: true }
  },
  methods: {
    chatDelete(index) {
      axios({
        url:
          "/api/v1/users/" +
          this.$route.params.user_id +
          "/requests/" +
          this.$route.params.request_id +
          "/chats",
        data: {
          id: this.chat.id,
        },
        method: "DELETE",
      })
        .then((response) => {
          this.$emit("chatDelete", index);
        })
        .catch((error) => {
          console.log(error);
        });
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

.mycomment {
  margin: 10px 0;
  display: flex;
  align-items: center;
  justify-content: flex-end;

  i {
    transition: all .5s;
    -moz-transition: all .5s;

    &:hover {
      color: $danger-color;
    }
  }

  p {
    display: inline-block;
    position: relative;
    margin: 0 10px 0 5px;
    padding: 8px;
    max-width: 250px;
    border-radius: 12px;
    background: #30e852;
    font-size: 15px;
    text-align: left;

    &:after {
      content: "";
      position: absolute;
      top: 3px;
      right: -19px;
      border: 8px solid transparent;
      border-left: 18px solid #30e852;
      -webkit-transform: rotate(-35deg);
      transform: rotate(-35deg);
    }
  }
}
</style>