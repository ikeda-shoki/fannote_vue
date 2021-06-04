<template>
  <div class="notification">
    <div class="notification-top">
      <div class="notification-profile-image">
        <CircleImage :image="notification.visitor.profile_image"></CircleImage>
      </div>

      <div class="notification-content">
        <template v-if="notificationType === 'follow'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{
                notification.visitor.account_name
              }}さんがあなたをフォローしました。
            </p>
          </template>
          <template v-else>
            <p>
              {{
                notification.visitor.user_name
              }}さんがあなたをフォローしました。
            </p>
          </template>
        </template>

        <template v-if="notificationType === 'favorite'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{ notification.visitor.account_name }}さんが
              <router-link :to="'/post_images/' + notification.post_image_id" @click.native="modalClose"
                >あなたの投稿</router-link
              >
              にいいねしました。
            </p>
          </template>
          <template v-else>
            <p>
              {{ notification.visitor.user_name }}さんが
              <router-link :to="'/post_images/' + notification.post_image_id" @click.native="modalClose"
                >あなたの投稿</router-link
              >
              にいいねしました。
            </p>
          </template>
        </template>

        <template v-if="notificationType === 'post_image_comment'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{ notification.visitor.account_name }}さんが
              <router-link :to="'/post_images/' + notification.post_image_id" @click.native="modalClose"
                >あなたの投稿</router-link
              >
              にコメントしました。
            </p>
          </template>
          <template v-else>
            <p>
              {{ notification.visitor.user_name }}さんが
              <router-link :to="'/post_images/' + notification.post_image_id" @click.native="modalClose"
                >あなたの投稿</router-link
              >
              にコメントしました。
            </p>
          </template>
        </template>

        <template v-if="notificationType === 'request'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{ notification.visitor.account_name }}さんからあなたに
              <router-link
                :to="'/users/' + notification.visited.id + '/requested'"
                @click.native="modalClose"
                >イラストの依頼</router-link
              >
              が届きました。
            </p>
          </template>
          <template v-else>
            <p>
              {{ notification.visitor.user_name }}さんからあなたに
              <router-link
                :to="'/users/' + notification.visited.id + '/requested'"
                @click.native="modalClose"
                >イラストの依頼</router-link
              >
              が届きました。
            </p>
          </template>
        </template>

        <template v-if="notificationType === 'request_ok'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{ notification.visitor.account_name }}さんがあなたの
              <router-link
                :to="'/users/' + notification.visited.id + '/requesting'"
                @click.native="modalClose"
                >イラスト依頼</router-link
              >
              の製作を開始しました。
            </p>
          </template>
          <template v-else>
            <p>
              {{ notification.visitor.user_name }}さんがあなたの
              <router-link
                :to="'/users/' + notification.visited.id + '/requesting'"
                @click.native="modalClose"
                >イラスト依頼</router-link
              >
              の製作を開始しました。
            </p>
          </template>
        </template>

        <template v-if="notificationType === 'request_out'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{ notification.visitor.account_name }}さんがあなたの
              <router-link
                :to="'/users/' + notification.visited.id + '/requesting'"
                @click.native="modalClose"
                >イラスト依頼</router-link
              >
              を製作しないが選択されました。
            </p>
          </template>
          <template v-else>
            <p>
              {{ notification.visitor.user_name }}さんがあなたの
              <router-link
                :to="'/users/' + notification.visited.id + '/requesting'"
                @click.native="modalClose"
                >イラスト依頼</router-link
              >
              を製作しないが選択されました。
            </p>
          </template>
        </template>

        <template v-if="notificationType === 'request_complete'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{ notification.visitor.account_name }}さんがあなたの
              <router-link
                :to="'/users/' + notification.visited.id + '/requesting'"
                @click.native="modalClose"
                >イラスト依頼</router-link
              >
              を完了しました。
            </p>
          </template>
          <template v-else>
            <p>
              {{ notification.visitor.user_name }}さんがあなたの
              <router-link
                :to="'/users/' + notification.visited.id + '/requesting'"
                @click.native="modalClose"
                >イラスト依頼</router-link
              >
              を完了しました。
            </p>
          </template>
        </template>

        <template v-if="notificationType === 'chat'">
          <template v-if="notification.visitor.account_name">
            <p>
              {{ notification.visitor.account_name }}さんから
              <router-link
                :to="'/users/' + notification.visited.id + '/requests/' + notification.request_id + '/chats'"
                @click.native="modalClose"
                >メッセージ</router-link
              >
              が届いています。
            </p>
          </template>
          <template v-else>
            <p>
              {{ notification.visitor.user_name }}さんから
              <router-link
                :to="
                  '/users/' + notification.visited.id + '/requests/' + notification.request_id + '/chats'"
                  @click.native="modalClose"
                >メッセージ</router-link
              >
              が届いています。
            </p>
          </template>
        </template>
      </div>

      <div class="notification-delete-botton">
        <i class="fas fa-times-circle" @click="notificationDelete"></i>
      </div>
    </div>


    <div class="notification-bottom">
      <p>{{ notification.time_ago }}前</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import CircleImage from "./CircleImage.vue";

export default {
  props: {
    notification: { type: Object, required: true },
  },
  data() {
    return {
      notificationType: "",
    };
  },
  components: {
    CircleImage,
  },
  methods: {
    notificationDelete() {
      axios({
        url:
          "/api/v1/notifications/" + this.notification.id,
        data: {
          id: this.notification.id,
        },
        method: "DELETE",
      })
        .then((response) => {
          this.$emit("notificationDelete");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    modalClose() {
      this.$emit("modalClose");
    }
  },
  mounted() {
    this.notificationType = this.notification.action;
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

.notification {
  margin-bottom: 10px;

  .notification-top {
    display: flex;
    align-items: center;
    border-bottom: 1px solid $font-color;

    .notification-profile-image {
      margin-right: 10px;

      #circle-image {
        /deep/ img {
          width: 40px;
          height: 40px;
          border: solid 2px $accent-color;
          padding: 0;
        }
      }
    }

    .notification-content {
      margin-right: 10px;
      a {
        color: $accent-color;
      }

      @include sp {
        p {
          font-size: 10px;
        }
      }

    }

    .notification-delete-botton {
      margin-left: auto;

      i {
        font-size: 23px;
        transition: all .5s;

        &:hover {
          color: $danger-color;
        }
      }
    }
  }

  .notification-bottom {
    p {
      font-size: 14px;
      text-align: right;
      opacity: .8;
    }
  }
}
</style>
