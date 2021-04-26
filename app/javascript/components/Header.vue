<template>
  <header>
    <div class="container">
      <div class="header-left">
        <img src="~logo.png" />
        <h1>FanNotes</h1>
      </div>
      <div class="header-right">
        <div
          class="header-link"
          v-for="routerLink in routerLinks"
          :key="routerLink.id"
          :class="{ hover: routerLink.hover }"
          @mouseover="onAccent(routerLink)"
          @mouseleave="outAccent(routerLink)"
        >
          <router-link :to="routerLink.path" active-class="link--active" exact>
            {{ routerLink.name }}
          </router-link>
        </div>
        <div 
          class="header-link" 
          v-for="normalLink in normalLinks" 
          :key="normalLink.id" 
          :class="{ hover: normalLink.hover }" 
          @mouseover="onAccent(normalLink)"
          @mouseleave="outAccent(normalLink)" 
        >
            <a :href="normalLink.path">{{ normalLink.name }}</a>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import 'logo.png';

export default {
  data() {
    return {
      routerLinks: [
        {
          name: "Top",
          path: "/",
          hover: false,
        },
        {
          name: "About",
          path: "/about",
          hover: false,
        },
        {
          name: "How to Use",
          path: "use",
          hover: false,
        }
      ],
      normalLinks: [
        {
          name: "Log In",
          path: "",
          hover: false,
        },
        {
          name: "Sign In",
          path: "",
          hover: false,
        }
      ]
    }
  },
  methods: {
    onAccent(link) {
      link.hover = true;
    },
    outAccent(link) {
      link.hover = false;
    }
  }
}
</script>

<style lang="scss" scoped>
  $accent-color: #e65b20;
  $back-ground-color: #f7f4f2;
  $font-color: #3e1300;

  header {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1050;
    width: 100%;
    opacity: 0.8;
    height: 80px;
    background-color: $back-ground-color;

    .container {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .header-left {
      display: flex;
      align-items: center;

      img {
        height: 80px;
        width: 80px;
      }
      h1 {
        font-family: 'Akaya Telivigala', cursive, 'Nunito', sans-serif;
        font-weight: bold;
        font-size: 30px;
      }
    }

    .header-right {
      display: flex;
      align-items: center;

      .header-link {
        margin-left: 20px;
        padding: 5px 13px;
        transition: all .5s;
        border-radius: 20px;

        a {
          transition: all .5s;
        }
      }
    }

    .link--active {
      font-size: 18px;

      &:after {
        background-color: $accent-color;
        border-radius: 5px;
        content: "";
        display: block;
        height: 4px;
      }
    }
  }
</style>