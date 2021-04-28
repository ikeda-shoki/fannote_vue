import Vue from "vue";
import Router from "vue-router";
import Top from "../views/Top.vue";
import About from "../views/About.vue";
import Use from "../views/Use.vue"
import Main from "../views/Main.vue"

Vue.use(Router);

const router = new Router({
  mode: "history",
  routes: [
    {
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
  ],
});
export default router;