<template>
 <div>
     <main-header navsel="back"></main-header>
     <br><br><br><br><br><br>
    <div class="blog-list">
        <center><H1>{{ blog.title }}</H1></center>
        <strong> <p>category: {{ blog.category }}</p></strong> 
        <strong> <p>status: {{ blog.status }}</p></strong> 
        <p>content: {{ blog.content }}</p>
        <p>
            <button class="btn btn-sm btn-warning" v-on:click="navigateTo('/blog/edit/'+ blog.id)">แกไข้ blog</button>
            <button class="btn btn-sm btn-info" v-on:click="navigateTo('/blogs')">กลับ</button>
        </p>
    </div>
    
 </div>
</template>
<script>
import BlogsService from '@/services/BlogsService'
export default {
    data () {
        return {
            blog: null
        }
    },
    async created () {
    try {
        let blogId = this.$route.params.blogId
        this.blog = (await BlogsService.show(blogId)).data
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
    .empty-blog {
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
    .blog-info {
        float: left;
    }
    .blog-pic {
        float: left;
    }
    .clearfix {
        clear: both;
    }
    .blog-list {
        border:solid 1px #dfdfdf;
        margin-bottom: 10px;
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
        padding: 5px;
        box-shadow: 0 2px 4px 0 rgba(0,0,0,.1);
    }
    .blog-header {
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
    }

    #blog-list-bottom{
        padding-top:4px;
    }

    #blog-list-bottom{
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
    .create-blog {
        margin-top: 10px;
    }
    .categories li.clear a {
        background: tomato;
        color: white
    }
    .blog-load-finished{
        padding:4px;
        text-align: center;
        background: seagreen;
        color:white;
    }
</style>
