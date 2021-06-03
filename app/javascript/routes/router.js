import Vue from "vue";
import Router from "vue-router";
import Top from "../views/post_images/Top.vue";
import About from "../views/post_images/About.vue";
import Use from "../views/post_images/Use.vue";
import Main from "../views/post_images/Main.vue";
import PostImageShow from "../views/post_images/PostImageShow.vue";
import User from "../views/users/User.vue";
import UserShow from "../views/users/UserShow.vue";
import UserRequestIndex from "../views/users/UserRequestIndex.vue"
import UserRequestResult from "../views/users/UserRequestResult.vue";
import PostImages from "../views/post_images/PostImages.vue";
import Users from "../views/users/Users.vue";
import HashTag from "../views/post_images/HashTag.vue";
import UserRequestChat from "../views/users/UserRequestChat.vue";
import UserFollowIndex from "../views/users/UserFollowIndex.vue";
import UserWithdrawal from "../views/users/UserWithdrawal.vue";
import Errors from "../components/parts/Errors.vue"

Vue.use(Router);

const router = new Router({
  mode: "history",
  routes: [{
      path: "/",
      component: Top,
    },
    {
      path: "/about",
      component: About,
    },
    {
      path: "/use",
      component: Use,
    },
    {
      path: "/post_images/main",
      component: Main,
    },
    {
      path: "/post_images",
      component: PostImages,
      name: "postImagesAll",
      children: [{
          path: "/post_images/illust",
          component: PostImages,
          name: "postImagesIllust",
        }, {
          path: "/post_images/photo",
          component: PostImages,
          name: "postImagesPhoto",
        }, {
          path: "/post_images/logo",
          component: PostImages,
          name: "postImagesLogo",
        },
      ]
    },
    {
      path: "/post_images/:id",
      component: PostImageShow,
    },
    {
      path: "/post_images/hashtag/:name",
      component: HashTag,
    },
    {
      path: "/users",
      component: Users,
    },
    {
      path: "/users/withdrawal",
      component: UserWithdrawal,
    },
    {
      path: "/users/:id",
      component: User,
      children: [{
          path: "/users/:id",
          component: UserShow
        },
        {
          path: "/users/:id/requesting",
          component: UserRequestIndex,
          name: "requesting"
        },
        {
          path: "/users/:id/requested",
          component: UserRequestIndex,
          name: "requested"
        },
        {
          path: "/users/:id/following",
          component: UserFollowIndex,
          name: "following"
        },
        {
          path: "/users/:id/followed",
          component: UserFollowIndex,
          name: "followed"
        },
      ]
    },
    {
      path: "/users/:user_id/requests/:id/request_done",
      component: UserRequestResult,
      name: "request_done"
    },
    {
      path: "/users/:user_id/requests/:id/request_complete",
      component: UserRequestResult,
      name: "request_complete"
    },
    {
      path: "/users/:user_id/requests/:request_id/chats",
      component: UserRequestChat,
    },
    {
      path: "/errors",
      component: Errors,
    }
  ],
  scrollBehavior(to, from, savedPosition) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve({
          x: 0,
          y: 0
        })
      }, 1000)
    })
  }
});
export default router;