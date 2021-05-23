<template>
  <div id="request-detail-modal">
    <div class="request-detail-modal-contents">
      <div
        class="request-detail-modal-content"
        v-for="requestContent in requestContents"
        :key="requestContent.id"
      >
        <div class="request-detail-modal-left">
          <h6>{{ requestContent.title }}</h6>
        </div>
        <div class="request-detail-modal-right">
          <template v-if="requestContent.title === '参考画像'">
            <img
              :src="requestContent.content"
              alt="参考画像"
              v-if="requestContent.content"
            />
            <img src="~no_image.jpg" alt="NoImage" v-else />
          </template>
          <template v-else-if="requestContent.title === '受付状況'">
            <RequestStatus
              :requestStatus="requestContent.content"
            ></RequestStatus>
          </template>
          <h5 v-else>{{ requestContent.content }}</h5>
        </div>
      </div>

      <template v-if="$route.name === 'requesting'">
        <template v-if="request.request_status === '未受付'">
          <div class="request-detail-modal-buttons">
            <button class="button" @click="modalChenge">依頼を変更する</button>
            <button class="button" @click="openConfirm">依頼を削除する</button>
          </div>
        </template>
        <template v-if="request.request_status === '製作完了'">
          <router-link
            :to="
              '/users/' +
                request.requesting_user.id +
                '/requests/' +
                request.id +
                '/request_complete'
            "
          >
            <div class="request-detail-modal-button">
              <button class="button">完成した作品を確認する</button>
            </div>
          </router-link>
        </template>
        <transition name="fade">
          <Confirm
            v-if="isConfirm === true"
            @falseAction="closeConfirm"
            @successAction="requestDelete"
          >
            本当に依頼を取り下げますか？
          </Confirm>
        </transition>
      </template>

      <template v-if="$route.name === 'requested'">
        <template v-if="request.request_status === '未受付'">
          <div class="request-detail-modal-radiobutton">
            <RadioButton
              name="request-status-edit"
              :options="options"
              :required="false"
              :checkedValue="requestStatus"
              labelName="製作ステータス"
              @input="requestStatus = $event"
            >
            </RadioButton>
            <ErrorMessage
              v-if="errorMessage.request_status"
              :message="errorMessage.request_status"
            ></ErrorMessage>
          </div>
          <div class="request-detail-modal-submitbutton">
            <FormButton
              buttonName="登録する"
              @click.native="requestStatusUpdate"
            ></FormButton>
          </div>
        </template>
        <template v-if="request.request_status === '製作中'">
          <p v-if="errors" class="error" key="error">
            入力内容を確認してください
          </p>
          <div class="request-detail-modal-file">
            <FileForms
              id="request-images"
              name="request-images"
              :required="true"
              :images="request.request_images"
              :requesImagesCount="request.amount - 1"
              labelName="完成した作品"
              @imageDelete="imageDelete"
              @input="onFileChange"
            >
            </FileForms>
            <ErrorMessage
              v-if="errorMessage.request_images"
              :message="errorMessage.request_images"
            ></ErrorMessage>
          </div>
          <div class="request-detail-modal-submitbutton">
            <!-- <FormButton
              buttonName="送信する"
              @click.native="requestCompleteImagesUpdate"
            ></FormButton> -->
            <FormButton
              buttonName="送信する"
              @click.native="openConfirm"
            ></FormButton>
          </div>
        </template>
        <template v-if="request.request_status === '製作完了'">
          <router-link
            :to="
              '/users/' + request.requested_user.id + '/requests/' + request.id + '/request_done'">
            <div class="request-detail-modal-button">
              <button class="button">送信した作品を確認する</button>
            </div>
          </router-link>
        </template>
      </template>
    </div>
    <ChatButton
      :userId="Number($route.params.id)"
      :requestId="request.id"
    ></ChatButton>
    <transition name="fade" tag="div" class="requested-confirm">
      <Confirm
        v-if="isConfirm === true"
        @falseAction="closeConfirm"
        @successAction="requestCompleteImagesUpdate"
      >
        作成枚数まで送信してしまうと送信する画像を変更することはできませんが完成した画像を送信していいですか？
      </Confirm>
    </transition>
  </div>
</template>

<script>
import "no_image.jpg";
import axios from "axios";
import RequestStatus from "../parts/RequestStatus.vue";
import RadioButton from "../form/RadioButton.vue";
import FormButton from "../form/FormButton.vue";
import FileForms from "../form/FileForms.vue";
import ErrorMessage from "../form/ErrorMessage.vue";
import ChatButton from "../parts/ChatButton.vue";
import Confirm from "../parts/Confirm.vue";

export default {
  props: {
    request: { type: Object, required: true },
  },
  data() {
    return {
      requestContents: [
        { title: "内容詳細", content: this.request.request_introduction },
        { title: "参考画像", content: this.request.reference_image },
        { title: "ファイル形式", content: this.request.file_format },
        { title: "用途", content: this.request.use },
        { title: "枚数", content: this.request.amount + "枚" },
        { title: "納期", content: this.request.vue_deadline },
        { title: "受付状況", content: this.request.request_status },
      ],
      requestStatus: this.request.request_status,
      requestImages: [],
      options: [
        {
          label: "製作する",
          value: "製作中",
        },
        {
          label: "製作しない",
          value: "受付不可",
        },
      ],
      isConfirm: false,
      errors: false,
      errorMessage: {},
    };
  },
  components: {
    RequestStatus,
    RadioButton,
    FormButton,
    FileForms,
    ErrorMessage,
    ChatButton,
    Confirm,
  },
  methods: {
    modalChenge() {
      this.$emit("modalChenge");
    },
    requestDelete() {
      axios({
        url:
          "/api/v1/users/" +
          this.$route.params.id +
          "/requests/" +
          this.request.id,
        method: "DELETE",
      })
        .then((response) => {
          this.$emit("successDelete");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    requestStatusUpdate() {
      axios({
        url:
          "/api/v1/users/" +
          this.$route.params.id +
          "/requests/" +
          this.request.id +
          "/update_request_status",
        data: {
          request_status: this.requestStatus,
        },
        method: "PATCH",
      })
        .then((response) => {
          this.$emit("successRequestStatusUpdate");
        })
        .catch((error) => {
          this.errorMessage = error.response.data;
          this.errors = true;
          setTimeout(() => {
            this.scrollTop();
          }, 500);
        });
    },
    scrollTop() {
      var modalTop = document.getElementById("request-edit-modal");
      modalTop.scrollTo({
        top: 0,
        behavior: "smooth",
      });
    },
    onFileChange(value) {
      this.requestImages = value;
    },
    imageDelete(value) {
      this.requestImages = value;
    },
    requestCompleteImagesUpdate() {
      this.request.request_images = this.requestImages;
      axios({
        url:
          "/api/v1/users/" +
          this.$route.params.id +
          "/requests/" +
          this.request.id +
          "/update_request_complete_image",
        data: {
          request: { request_images: this.requestImages },
        },
        method: "PATCH",
      })
        .then((response) => {
          this.$emit("successRequestImageUpdate");
        })
        .catch((error) => {
          console.log(error.response.data)
          this.isConfirm = false;
          this.errorMessage = error.response.data;
          this.errors = true;
        });
    },
    openConfirm() {
      this.isConfirm = true;
    },
    closeConfirm() {
      this.isConfirm = false;
    },
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

#request-detail-modal {
  height: 94%;
  margin: 0 auto;
  padding: 30px 40px;
  overflow: scroll;
  text-align: left;

  .request-detail-modal-contents {
    .request-detail-modal-content {
      margin-bottom: 20px;
      display: flex;
      flex-direction: row;
      align-items: center;
      flex-wrap: wrap;
      width: 100%;
    }

    .request-detail-modal-buttons {
      margin-top: 70px;
      text-align: center;
    }
  }

  .request-detail-modal-left {
    width: 30%;
  }

  .request-detail-modal-right {
    margin-left: auto;
    width: 65%;

    img {
      width: 50%;
    }

    h5 {
      font-size: 25px;
      font-weight: bold;
    }
  }

  .request-detail-modal-radiobutton {
    margin: 40px 0 10px 0;
  }

  .request-detail-modal-file {
    margin: 40px 0 10px 0;
  }

  .request-detail-modal-button {
    text-align: center;
    margin-top: 50px;
  }

  #error-message {
    width: 65%;
    margin: 20px 0 30px auto;
  }

  .error {
    font-weight: bold;
    font-size: 20px;
    color: $danger-color;
    margin-top: 60px;
  }

  #chat-button {
    position: fixed;
    top: 600px;
    right: 170px;
  }

  
  #confirm {
    /deep/ p {
      font-size: 14px;
    }
  }
}
</style>
