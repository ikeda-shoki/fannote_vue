<template>
  <div id="users-index">
    <div class="container">
      <Title title="ユーザー一覧"></Title>
      <div class="users-sort">
        <SelectForm
          :value="selectSort"
          :options="options"
          :checkedValue="selectSort"
          @input="selectSort = $event"
          name="sort_post_image"
        ></SelectForm>
        <button class="button" @click="sortUsers">
          並び替える
        </button>
      </div>
      <div class="users-search">
        <CommentForm
          v-model="keyword"
          id="search"
          type="text"
          name="search"
          placeholder="キーワードを入力してください"
        ></CommentForm>
        <i class="fas fa-search" @click="searchUsers"></i>
      </div>
      <transition-group tag="div" class="users-items" name="sort-user">
        <template v-for="user in usersSearch">
          <UserItem :user="user" :key="user.id"></UserItem>
        </template>
      </transition-group>
    </div>
  </div>
</template>

<script>
import Title from "../../components/parts/Title.vue";
import SelectForm from "../../components/form/SelectForm.vue";
import UserItem from "../../components/parts/UserItem.vue";
import CommentForm from "../../components/form/CommetForm.vue";
import axios from "axios";

export default {
  data() {
    return {
      users: [],
      usersSearch: [],
      options: [
        { label: "登録が新しい順", value: "new" },
        { label: "登録が古い順", value: "old" },
        { label: "投稿が多い順", value: "many_post_images" },
        { label: "依頼達成数が多い順", value: "many_requests" },
      ],
      selectSort: "new",
      keyword: "",
    };
  },
  components: {
    Title,
    SelectForm,
    UserItem,
    CommentForm,
  },
  methods: {
    getInfo() {
      axios.get("/api/v1/users").then(
        (response) => {
          this.users = response.data.users;
          this.usersSearch = response.data.users;
        },
        (error) => {
          this.$router.push("/post_images/main");
        }
      );
    },
    sortUsers() {
      if (this.selectSort === "new") {
        this.usersSearch.sort((a, b) => {
          return new Date(b.created_at) - new Date(a.created_at);
        });
      } else if (this.selectSort === "old") {
        this.usersSearch.sort((a, b) => {
          return new Date(a.created_at) - new Date(b.created_at);
        });
      } else if (this.selectSort === "many_post_images") {
        this.usersSearch.sort((a, b) => {
          return b.user_post_image_count - a.user_post_image_count;
        });
      } else if (this.selectSort === "many_requests") {
        this.usersSearch.sort((a, b) => {
          return b.complete_request_count - a.complete_request_count;
        });
      }
    },
    searchUsers() {
      this.usersSearch = this.users;
      var searchUsers = [];
      for (let i = 0; i < this.usersSearch.length; ++i) {
        var user = this.usersSearch[i];
        if (
          user.user_name.indexOf(this.keyword) !== -1 ||
          user.account_name.indexOf(this.keyword) !== -1
        ) {
          searchUsers.push(user);
        }
      }
      this.usersSearch = searchUsers;
    },
  },
  mounted() {
    this.getInfo();
  },
};
</script>

<style lang="scss" scoped>
$accent-color: #e65b20;
$back-ground-color: #f7f4f2;
$font-color: #3e1300;
$font-white: #fffffe;
$danger-color: #e15253;

.sort-user-move {
  transition: all 0.8s;
}

#users-index {
  margin-top: 80px;
  text-align: center;

  #title {
    font-weight: bold;
    font-size: 28px;
  }

  .container {
    position: relative;

    .users-sort {
      position: absolute;
      top: 15px;
      right: 0;
      display: flex;

      .button {
        min-width: auto;
        margin-left: 10px;
        box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
      }
    }

    .users-search {
      display: flex;
      align-items: center;
      position: absolute;
      top: 15px;
      left: 0;
      padding: 8px 15px;
      background-color: $font-white;
      border-radius: 20px;
      box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
      width: 380px;

      /deep/ input {
        border-bottom: 1px solid $font-color;
        border-right: none;
        border-left: none;
        border-top: none;
        transition: 0.5s all;
        -moz-transition: 0.5s all;

        &:focus {
          outline: none;
          border-bottom: 2px solid $accent-color;
        }
      }

      i {
        margin-left: 8px;
        font-size: 23px;
        padding: 10px;
        border-radius: 50%;
        box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
        transition: all 0.5s;
        -moz-transition: all 0.5s;

        &:hover {
          background-color: $accent-color;
          color: $font-white;
        }
      }
    }

    .users-items {
      margin-top: 40px;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      width: 100%;

      /deep/ .user-item {
        width: 48%;
      }
    }
  }
}
</style>
