<template>
 <div>
     <main-header navsel="back"></main-header>
     <br><br><br><br><br><br>
    <div class="book-list">
        <center><H1>{{ book.title }}</H1></center>
        <strong> <p>category: {{ book.category }}</p></strong> 
        <strong> <p>status: {{ book.status }}</p></strong> 
        <p>content: {{ book.content }}</p>
        <p>
            <button class="btn btn-sm btn-warning" v-on:click="navigateTo('/book/edit/'+ book.id)">แกไข้ book</button>
            <button class="btn btn-sm btn-info" v-on:click="navigateTo('/books')">กลับ</button>
        </p>
    </div>
    
 </div>
</template>
<script>
import BooksService from '@/services/BooksService'
export default {
    data () {
        return {
            book: null
        }
    },
    async created () {
    try {
        let bookId = this.$route.params.bookId
        this.book = (await BooksService.show(bookId)).data
    } catch (error) {
        console.log (error)
    }
    },
    methods : {
        navigateTo (route) {
            this.$router.push(route)
        },
    }
}
</script>
<style scoped>
    .empty-book {
        width: 100%;
        text-align: center;
        padding:10px;
        background:darksalmon;
        color:white;
    }
    /* thumbnail */
    .thumbnail-pic img{
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
        border:solid 1px #dfdfdf;
        margin-bottom: 10px;
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
        padding: 5px;
        box-shadow: 0 2px 4px 0 rgba(0,0,0,.1);
    }
    .book-header {
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
    }

    #book-list-bottom{
        padding-top:4px;
    }

    #book-list-bottom{
        padding:4px;
        text-align: center;
        background: seagreen;
        color:white;
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
        background:paleturquoise;
        color: black;
        text-decoration: none;
    }
    .create-book {
        margin-top: 10px;
    }
    .categories li.clear a {
        background: tomato;
        color: white
    }
    .book-load-finished{
        padding:4px;
        text-align: center;
        background: seagreen;
        color:white;
    }
</style>
