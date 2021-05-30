<template>
  <div class="request-item">
    <div class="request-item-image">
      <CircleImage :image="user.profile_image"></CircleImage>
    </div>
    <div class="request-item-right">
      <div class="request-item-info">
        <div class="request-item-info-user-name">
          <h3 v-if="user.account_name">
            <i class="fas fa-user"></i>{{ user.account_name }}
          </h3>
          <h3 v-else><i class="fas fa-user"></i>{{ user.user_name }}</h3>
        </div>
        <div class="request-item-info-date">
          <p>依頼日</p>
          <h5>{{ request.created_at }}</h5>
          <p>納期</p>
          <h5>{{ request.vue_deadline }}</h5>
        </div>
      </div>
      <div class="request-item-status">
        <p>受付状況</p>
        <RequestStatus :requestStatus="request.request_status"></RequestStatus>
      </div>
    </div>
  </div>
</template>

<script>
import CircleImage from "./CircleImage.vue";
import RequestStatus from "./RequestStatus.vue";

export default {
  props: {
    user: { type: Object, required: true },
    request: { type: Object, required: true },
  },
  components: {
    CircleImage,
    RequestStatus,
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

.request-item {
  background-color: $font-white;
  border-radius: 20px;
  box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
  padding: 10px 30px;
  display: flex;
  align-items: center;
  transition: 0.5s;
  -webkit-transition: 0.5s;
  margin-bottom: 30px;

  &:hover {
    background-color: rgba(0, 0, 0, 0.1);
  }

  .request-item-image {
    #circle-image {
      /deep/ img {
        width: 100px;
        height: 100px;
        border: solid 2px $accent-color;
      }
    }
  }

  .request-item-right {
    flex-grow: 1;
    display: flex;
    align-items: center;

    @include sp {
      flex-direction: column;
    }
  }

  .request-item-info {
    margin-left: 30px;
    text-align: left;

    h3 {
      font-weight: bold;
      font-size: 20px;
      margin-bottom: 8px;

      @include sp {
        font-size: 16px;
      }

      i {
        margin-right: 6px;
      }
    }

    p {
      font-size: 13px;
    }

    h5 {
      font-weight: bold;
      font-size: 18px;

      @include sp {
        font-size: 14px;
      }
    }

    @include sp {
      margin-bottom: 20px;
    }
  }

  .request-item-status {
    flex-grow: 1;
    text-align: center;
    p {
      font-size: 13px;
    }
  }
}
</style>
