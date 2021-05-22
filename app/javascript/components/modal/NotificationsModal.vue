<template>
  <div id="notifications-modal">
    <template v-if="notifications.length">
      <div class="notifications-all-delete-button">
        <button class="button" @click="notificationsAllDelete">
          全ての通知を削除
        </button>
      </div>
      <div class="notifications-main">
        <transition-group name="fade-list" mode="out-in">
          <template v-for="(notification, index) in notifications">
            <Notification
              :key="notification.id"
              :notification="notification"
              @modalClose="modalClose"
              @notificationDelete="notificationDelete(index)"
            >
            </Notification>
          </template>
        </transition-group>
      </div>
    </template>
    <template v-else>
      <p class="notifications-no-notification">現在の通知はありません。</p>
    </template>
  </div>
</template>

<script>
import axios from "axios";
import Notification from "../parts/Notification.vue";

export default {
  data() {
    return {
      notifications: [],
    };
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/notifications").then(
        (response) => {
          this.notifications = response.data.notifications;
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
    notificationsAllDelete() {
      axios({
        url:
          "/api/v1/notifications/all_destroy",
        method: "DELETE",
      })
        .then((response) => {
          this.notifications.splice(0, this.notifications.length)
        })
        .catch((error) => {
          console.log(error);
        });
    },
    modalClose() {
      this.$emit("modalClose");
    },
    notificationDelete(index) {
      this.notifications.splice(index, 1);
    },
  },
  mounted() {
    this.getInfo();
  },
  components: {
    Notification,
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#notifications-modal {
  margin: 0 auto;
  padding: 10px 40px 30px;
  overflow: scroll;
  height: 94%;

  .notifications-all-delete-button {
    text-align: right;
    margin-bottom: 30px;
    padding-bottom: 10px;
    border-bottom: 1px solid $font-color;

    .button {
      background-color: $danger-color;
      min-width: auto;
      padding: 10px 25px;
    }
  }

  .notifications-no-notification {
    text-align: center;
    font-size: 20px;
    font-weight: bold;
  }
}
</style>
