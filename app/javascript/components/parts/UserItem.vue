<template>
  <router-link :to="'/users/' + user.id" class="user-item">
    <div class="user-item-left">
      <CircleImage :image="user.profile_image"></CircleImage>
    </div>
    <div class="user-item-right">
      <div class="user-item-right-top">
        <Title v-if="user.account_name" :title="user.account_name"></Title>
        <Title v-else :title="user.user_name"></Title>
      </div>
      <div class="user-item-right-middle">
        <UserItems :user="user"></UserItems>
      </div>
      <div class="user-item-right-bottom">
        <p v-if="user.is_reception === true" class="user-item-right-reception">依頼受付中</p>
        <p v-if="user.is_reception === false" class="user-item-right-noreception">依頼不可</p>
      </div>
    </div>
  </router-link>
</template>

<script>
import Title from "./Title.vue";
import CircleImage from "./CircleImage.vue";
import UserItems from "./UserItems.vue";

export default {
  props: {
    user: { type: Object, required: true, default: {}}
  },
  components: {
    Title,
    CircleImage,
    UserItems
  }
}
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

.user-item {
  padding: 20px;
  border-radius: 20px;
  box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
  background-color: $font-white;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  transition: all .5s;
  -moz-transition: all .5s;

  &:hover {
    background-color: rgba(0, 0, 0, 0.1);
  }

  .user-item-left {
    flex-grow: 0;
    /deep/ #circle-image{
      img {
        width: 130px;
        height: 130px;
        border: solid 3px $accent-color;
      }
    }
  }

  .user-item-right {
    flex-grow: 1;

    .user-item-right-top {
      margin-bottom: 20px;

      #title {
        font-size: 18px;

        /deep/ h2 {
          font-weight: bold;
        }

        &::before {
          bottom: -5px;
          height: 3px;
          width: 45px;
        }
      }
    }

    .user-item-right-middle {
      margin-bottom: 20px;
      width: 100%;

      /deep/ #user-items {
        .user-item {
          width: 30%;
        }
      }
    }

    .user-item-right-bottom {
      p {
        padding: 5px 15px;
        border-radius: 10px;
        color: $font-white;
        font-weight: bold;
      }

      .user-item-right-reception {
        background-color: #88C4C4;
      }

      .user-item-right-noreception {
        background-color: $danger-color;
      }
    }

  }
}
</style>