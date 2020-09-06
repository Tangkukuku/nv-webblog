<template>
  <div class="component-wrapper container">
    <main-header navsel="front"></main-header>
    <div v-if="book">
      <div class="hero">
        <img src="@/assets/logo.png" class="logo" style="float:left" />
        <h1>ร้านหนังสือออนไลน์สั่ง ซื้อได้เลยครับ</h1>
        <p>By Gooddev.ME</p>
      </div>
      <div class="book-wrapper" v-if="book != null">
        <h1>{{ book.title }}</h1>
        <p>
          <strong>Category:</strong>:
          <a
            href="#"
            v-on:click.prevent="navigateTo(`/front?search=${book.category}`)"
          >{{book.category }}</a>
        </p>
        <div class="content" v-html="book.content"></div>
        <!-- <p>category: {{ book.category }}</p>
        <p>status: {{ book.status }}</p>-->
      </div>
      <div class="back-nav">
        <button class="btn btn-success" v-on:click="navigateTo('/front-books')">
          <i class="fas fa-arrow-left"></i> Back..
        </button>
      </div>
      <br />
    </div>
  </div>
</template>
<script>
import { mapState } from "vuex";
import BooksService from "@/services/BooksService";
import UsersService from "@/services/UsersService";
import CommentComp from "@/components/Fronts/Comment";

export default {
  data() {
    return {
      book: null,
      resultUpdated: "",
      users: null,
    };
  },
  components: {
    CommentComp,
  },
  async created() {
    // get book
    // check permission first
    try {
      let bookId = this.$route.params.bookId;
      this.book = (await BooksService.show(bookId)).data;
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    navigateTo(route) {
      this.$router.push(route);
    },
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user"]),
  },
};
</script>
<style scoped>
.hero {
  margin-top: 80px;
  max-width: 1150px;
  margin-left: auto;
  margin-right: auto;
  border-radius: 5px;
  background: lightslategray;
  height: 250px;
  color: white;
  padding: 20px;
}
.hero h1 {
  margin-top: 30px;
}
.logo {
  padding-right: 20px;
}
.hero {
  margin-top: 80px;
  border-radius: 5px;
  background: lightslategray;
  height: 250px;
  color: white;
  padding: 20px;
}
.hero h1 {
  margin-top: 30px;
}
.logo {
  padding-right: 20px;
  max-width: 200px;
}
.book-wrapper {
  margin-top: 20px;
  padding: 40px;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2);
}
.back-nav {
  margin-top: 20px;
  text-align: center;
}
.book-wrapper h1 {
  text-align: center;
  font-family: "kanit";
  padding-bottom: 50px;
}
.book-wrapper p {
  font-family: "kanit";
  font-size: 1.4em;
  padding-bottom: 20px;
}
.book-wrapper .content {
  font-family: "kanit";
  font-size: 1.2em;
}

</style>