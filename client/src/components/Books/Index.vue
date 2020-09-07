<template>
  <div class="container">
    <main-header navsel="back"></main-header>
    <div class="book-header">
      <br />
      <br />
      <h2>ส่วนจัดการหนังสือ</h2>
      <div>
        <form class="form-inline form-search">
          <div class="form-group">
            <div class="input-group">
              <input
                type="text"
                v-model="search"
                class="form-control"
                id="exampleInputAmount"
                placeholder="Search"
              />
              <div class="input-group-addon">
                <i class="fas fa-search"></i>
              </div>
            </div>
          </div>
        </form>
      </div>

      <div class="create-book">
        <button class="btn btn-success btn-sm" v-on:click="navigateTo('/book/create')">Create book</button>
        <strong>จํานวน book:</strong>
        {{results.length}}
      </div>

      <ul class="categories">
        <li v-for="cate in category" v-bind:key="cate.index">
          <a v-on:click.prevent="setCategory(cate)" href="#">{{ cate }}</a>
        </li>
        <li class="clear">
          <a v-on:click.prevent="setCategory(' ')" href="#">Clear</a>
        </li>
      </ul>
      <div class="clearfix"></div>
    </div>
    <transition-group name="fade">
      <div v-for="book in books" v-bind:key="book.id" class="book-list">
        <!-- <p>id: {{ book.id }}</p> -->
        <div class="book-pic">
          <!-- <transition name="fade"> -->
          <div class="thumbnail-pic" v-if="book.thumbnail != 'null'">
            <img :src="BASE_URL+book.thumbnail" alt="thumbnail" />
          </div>
          <!-- </transition> -->
        </div>
        <h3>{{ book.title }}</h3>
        <div v-html="book.content.slice(0,200) + '...'"></div>
        <div class="book-info">
          <p>
            <strong>Category:</strong>
            {{ book.category }}
          </p>
          <p>
            <strong>Create:</strong>
            {{ book.createdAt }}
          </p>
          <p>
            <strong>status:</strong>
            {{ book.status }}
          </p>
          <p>
            <strong>Prices:</strong>
            {{ book.prices | getNumberWithCommas }} บาท
          </p>
          <!-- <p>status: {{ book.status }}</p> -->
          <p>
            <button class="btn btn-sm btn-info" v-on:click="navigateTo('/book/'+ book.id)">View Book</button>
            <button
              class="btn btn-sm btn-warning"
              v-on:click="navigateTo('/book/edit/'+ book.id)"
            >Edit book</button>
            <button class="btn btn-sm btn-danger" v-on:click="deleteBook(book)">Delete</button>
          </p>
          <p>
            <a class="btn btn-danger btn-sm" href="#" v-on:click.prevent="suspend(book.id)">
              <i class="fas fa-pause"></i> Suspend
            </a>&nbsp;
            <a class="btn btn-success btn-sm" href="#" v-on:click.prevent="publish(book.id)">
              <i class="fas fa-check"></i> Published
            </a>&nbsp;
          </p>
        </div>
        <div class="clearfix"></div>
      </div>
    </transition-group>

    <div id="book-list-bottom">
      <div class="empty-book" v-if="books.length === 0 && loading === false">*** ไม่มีข้อมูล***</div>
      <div class="empty-book" v-if="books.length === 0 && loading === true">*** ไม่มีข้อมูล***</div>
      <div
        class="book-load-finished"
        v-if="books.length === results.length && results.length > 0"
      >โหลดข้อมูลครบแล้ว</div>
    </div>
  </div>
</template>
<script>
import BooksService from "@/services/BooksService";
import _ from "lodash";
import ScrollMonitor from "scrollMonitor";

let LOAD_NUM = 5;
let pageWatcher;

export default {
  watch: {
    search: _.debounce(async function (value) {
      const route = {
        name: "books",
      };

      if (this.search !== "") {
        route.query = {
          search: this.search,
        };
      }

      console.log("search: " + this.search);
      this.$router.push(route);
    }, 700),

    "$route.query.search": {
      immediate: true,
      async handler(value) {
        this.books = [];
        this.results = [];
        this.loading = true;
        this.results = (await BooksService.index(value)).data;
        this.appendResults();

        this.results.forEach((book) => {
          if (this.category.length > 0) {
            // console.log(this.category.indexOf(book.category))
            if (this.category.indexOf(book.category) === -1) {
              this.category.push(book.category);
            }
          } else {
            this.category.push(book.category);
          }
        });
        this.loading = false;
        this.search = value;
        //console.log(this.category)
      },
    },
  },
  data() {
    return {
      books: [],
      BASE_URL: "http://localhost:8081/assets/uploads/",
      search: "",
      results: [],
      category: [],
      loading: false,
    };
  },
  async created() {
    this.books = (await BooksService.index()).data;
  },
  methods: {
    wait(ms) {
      return (x) => {
        return new Promise((resolve) => setTimeout(() => resolve(x), ms));
      };
    },
    appendResults: function () {
      if (this.books.length < this.results.length) {
        let toAppend = this.results.slice(
          this.books.length,
          LOAD_NUM + this.books.length // จำกัดการแสดงผล
        );
        this.books = this.books.concat(toAppend);
      }
    },
    navigateTo(route) {
      this.$router.push(route);
    },
    async deleteBook(book) {
      try {
        await BooksService.delete(book);
        this.refreshData();
      } catch (err) {
        console.log(err);
      }
    },
    async refreshData() {
      this.books = (await BooksService.index()).data;
    },
    setCategory(keyword) {
      if (keyword === " ") {
        this.search = "";
        console.log("null");
      } else {
        this.search = keyword;
      }
    },
    updated() {
      let sens = document.querySelector("#book-list-bottom");
      pageWatcher = ScrollMonitor.create(sens);
      pageWatcher.enterViewport(this.appendResults);
    },
    beforeUpdated() {
      if (pageWatcher) {
        pageWatcher.destroy();
        pageWatcher = null;
      }
    },
    async suspend(bookId) {
      let user = {
        id: bookId,
        status: " Suspend",
      };
      try {
        await BooksService.put(user);
        this.refreshData();
      } catch (error) {
        console.log(error);
      }
    },
    async publish(bookId) {
      let user = {
        id: bookId,
        status: "published",
      };
      try {
        await BooksService.put(user);
        this.refreshData();
      } catch (error) {
        console.log(error);
      }
    },
  },
  filters: {
    getNumberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
};
</script>
<style scoped>
.empty-book {
  width: 100%;
  text-align: center;
  padding: 4px;
  background: coral;
  color: white;
}
/* thumbnail */
.thumbnail-pic img {
  width: 200px;
  padding: 5px 10px 0px 0px;
}
.book-info {
  float: left;
}
.book-pic {
  float: left;
}
.clearfix {
  clear: both;
}
.book-list {
  border: solid 1px #dfdfdf;
  margin-bottom: 10px;
  max-width: 900px;
  margin-left: auto;
  margin-right: auto;
  padding: 5px;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.1);
}
.book-header {
  max-width: 900px;
  margin-left: auto;
  margin-right: auto;
}

#book-list-bottom {
  padding-top: 4px;
}

#book-list-bottom {
  padding: 4px;
  text-align: center;
  color: white;
}
.categories {
  margin-top: 10px;
  padding: 0;
  list-style: none;
  float: left;
}
.categories li {
  float: left;
  padding: 2px;
}
.categories li a {
  padding: 5px 10px 5px 10px;
  background: paleturquoise;
  color: black;
  text-decoration: none;
}
.create-book {
  margin-top: 10px;
}
.categories li.clear a {
  background: tomato;
  color: white;
}
.book-load-finished {
  padding: 4px;
  text-align: center;
  background: seagreen;
  color: white;
}
.emptybook {
  background-color: coral;
  border-color: coral;
}
</style>