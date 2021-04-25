<template>
  <header>
    <div class="container">
      <div class="header-left">
        <img src="~logo.png" />
        <h1>FanNotes</h1>
      </div>
      <div class="header-right">
        <div class="header-link" v-for="routerLink in routerLinks" :key="routerLink.id">
          <router-link :to="routerLink.path">{{ routerLink.name }}</router-link>
        </div>
        <div class="header-link" v-for="normalLink in normalLinks" :key="normalLink.id">
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
      message: "Headerです",
      routerLinks: [
        {
          name: "Top",
          path: "/"
        },
        {
          name: "About",
          path: "/about"
        },
        {
          name: "How to Use",
          path: "Use"
        }
      ],
      normalLinks: [
        {
          name: "Log In",
          path: "",
        },
        {
          name: "Sign In",
          path: "",
        }
      ]
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
      }
    }
  }
</style>