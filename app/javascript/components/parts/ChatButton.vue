<template>
  <div id="chat-button">
    <router-link :to="'/users/' + userId + '/requests/' + requestId + '/chats'">
      チャットをはじめる
    </router-link>
  </div>
</template>

<script>
export default {
  props: {
    userId: { type: Number, required: true },
    requestId: { type: Number, required: true },
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#chat-button {
  background-color: $accent-color;
  width: 150px;
  height: 150px;
  border-radius: 50%;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.29);
  border-bottom: solid 3px $accent-color;
  transition: all .5s;
  -moz-transition: all .5s;
  text-align: center;

  a {
    display: block;
    color: $font-white;
    font-weight: bold;
    line-height: 150px;
  }
}

</style>