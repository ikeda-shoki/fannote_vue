import Vue from "vue";
import Router from "vue-router";
import Top from "../views/post_images/Top.vue";
import About from "../views/post_images/About.vue";
import Use from "../views/post_images/Use.vue";
import Main from "../views/post_images/Main.vue";
import PostImageShow from "../views/post_images/PostImageShow.vue";

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
      path: "/post_images/:id",
      component: PostImageShow,
    },
  ],
});
export default router;