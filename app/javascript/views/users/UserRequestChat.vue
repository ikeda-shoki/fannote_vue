<template>
  <transition-group name="fade">
    <Loading v-if="isLoading === true" key="loader"></Loading>
    <div id="user-request-chat" v-if="isLoading === false" key="noloader">
      <BackButton>
        前の画面に戻る
      </BackButton>
      <div class="container">
        <div class="chats">
          <div class="chats-title">
            <h2 v-if="requestOtherUser.account_name">
              {{ requestOtherUser.account_name }}さんとのチャット
            </h2>
            <h2 v-else>{{ requestOtherUser.user_name }}さんとのチャット</h2>
          </div>

          <transition-group
            name="fade-list-chat"
            mode="out-in"
            tag="div"
            id="chats-middle"
            class="chats-main"
          >
            <template v-for="(chat, index) in chats">
              <div
                v-if="chat.user_id === currentUser.id"
                :key="chat.id"
                class="my-comments"
              >
                <MyComment
                  :chat="chat"
                  :index="index"
                  @chatDelete="chatDelete"
                ></MyComment>
              </div>
              <div v-else :key="chat.id">
                <Fukidasi :chat="chat"></Fukidasi>
              </div>
            </template>
          </transition-group>

          <div class="chat-form">
            <div class="chat-form-main">
              <CommentForm
                v-model="message"
                id="chat"
                type="text"
                name="chat"
                placeholder="メッセージを入力できます"
              ></CommentForm>
              <FormButton
                buttonName="送信"
                @click.native="createChat"
              ></FormButton>
            </div>
            <transition name="fade">
              <div class="chat-form-error" v-show="error">
                <ErrorMessage
                  v-if="errorMessage.message"
                  :message="errorMessage.message"
                ></ErrorMessage>
              </div>
            </transition>
          </div>
        </div>
      </div>
      <Footer></Footer>
    </div>
  </transition-group>
</template>

<script>
import MyComment from "../../components/parts/MyComment.vue";
import Fukidasi from "../../components/parts/Fukidasi.vue";
import CommentForm from "../../components/form/CommetForm.vue";
import FormButton from "../../components/form/FormButton.vue";
import ErrorMessage from "../../components/form/ErrorMessage.vue";
import Loading from "../../components/parts/Loading.vue";
import BackButton from "../../components/parts/BackButton.vue";
import Footer from "../../components/Footer.vue";
import axios from "axios";

export default {
  props: {
    currentUser: { type: Object, required: true },
  },
  data() {
    return {
      chats: [],
      requestOtherUser: {},
      message: "",
      error: false,
      errorMessage: {},
      isLoading: true,
    };
  },
  methods: {
    async getInfo() {
      await axios
        .get(
          "/api/v1/users/" +
            this.$route.params.user_id +
            "/requests/" +
            this.$route.params.request_id +
            "/chats/"
        )
        .then(
          (response) => {
            this.chats = response.data.chats;
            this.requestOtherUser = response.data.request_other_user;
          })
        .catch(
          (error) => {
            this.$router.push("/errors");
          });
      this.isLoading = false;
    },
    createChat() {
      axios({
        url:
          "/api/v1/users/" +
          this.$route.params.user_id +
          "/requests/" +
          this.$route.params.request_id +
          "/chats",
        data: {
          chat: {
            request_id: this.$route.params.request_id,
            message: this.message,
          },
        },
        method: "POST",
      })
        .then((response) => {
          this.chats.push(response.data);
          this.message = "";
          setTimeout(() => {
            this.scrollBottom();
          }, 300);
        })
        .catch((error) => {
          this.errorMessage = error.response.data;
          this.error = true;
        });
    },
    scrollBottom() {
      var chatsMiddle = document.getElementById("chats-middle");
      chatsMiddle.scrollTo({
        top: 99999,
        behavior: "smooth",
      });
    },
    chatDelete(value) {
      this.chats.splice(value, 1);
    },
  },
  created() {
    this.getInfo();
  },
  components: {
    MyComment,
    Fukidasi,
    CommentForm,
    FormButton,
    ErrorMessage,
    Loading,
    Footer,
    BackButton,
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

.fade-list-chat-move {
  transition: all 0.5s;
}

.fade-list-chat-enter {
  opacity: 0;
}

.fade-list-chat-enter-active {
  transition: all 0.5s;
}

.fade-list-chat-leave-active {
  transition: all 0.5s ease;
}

.fade-list-chat-leave-to {
  opacity: 0;
}

#user-request-chat {
  padding: 115px 0;
  height: 100vh;

  @include sp {
    padding: 0;
  }

  .chats {
    max-width: 500px;
    padding: 0px 10px;
    margin: 0px auto;
    text-align: right;
    font-size: 14px;
    position: relative;
  }

  .chats-title {
    h2 {
      text-align: center;
      font-weight: bold;
      font-size: 25px;
      margin-bottom: 30px;

      @include sp {
        font-size: 20px;
      }
    }
  }

  .chats-main {
    height: 500px;
    overflow: scroll;
    -ms-overflow-style: none;
    scrollbar-width: none;

    @include sp {
      height: 536px;
    }

    &::-webkit-scrollbar {
      display: none;
  }
  }

  .chat-form {
    background-color: $font-white;
    padding: 20px;
    border-radius: 20px;
    border: 5px solid $accent-color;
    width: 100%;
    transition: all 0.8s;

    .chat-form-error {
      margin-top: 20px;

      /deep/ #error-message {
        text-align: left;
      }
    }

    .chat-form-main {
      display: flex;
      align-items: center;
      flex-wrap: nowrap;

      /deep/ #comment-form {
        width: 75%;
        margin-right: 20px;

        @include sp {
          width: 70%;
        }
      }

      /deep/ .button {
        min-width: auto;
        padding: 5px 25px;

        @include sp {
          padding: 5px 15px;
        }
      }
    }
  }

  /deep/ .back-button {
    @include sp {
      top: 60px;
      position: static;
      margin: 70px 0 10px 10px;
      width: 40%;
    }
  }
}
</style>
