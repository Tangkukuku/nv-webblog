<template>
    <div class="container">
        <main-header navsel="back"></main-header>
        <div class="blog-header">
            <br><br><br>
            <h2>Get all comments</h2>
            
            <div>
                <form class="form-inline form-search">
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" v-model="search" class="form-control" id="exampleInputAmount" placeholder="Search">
                        <div class="input-group-addon"><i class="fas fa-search"></i></div>
                    </div>
                </div>
                </form>
            </div>
            <div class="create-blog">
                <h4>จํานวน comment {{comments.length}}</h4>
            </div>
        </div>
        <div v-for="comment in comments" v-bind:key="comment.id" class="blog-list">
            <strong>comment:</strong>
            <p>id: {{ comment.id }}</p>
            <p>blog id: {{ comment.blogId }}</p>
            <p>comment: {{ comment.comment }}</p>
            <p>
                <button class="btn btn-sm btn-info" v-on:click="navigateTo('/comment/'+ comment.id)">ดู comment</button>
                <button class="btn btn-sm btn-danger" v-on:click="deleteComment(comment)">ลบข้อมูล</button>
            </p>
        </div>
        
    </div>
</template>
<script>
import CommentsService from '@/services/CommentsService'
export default {
    data () {
        return {
            comments: []
        }
    },
    async created () {
        this.comments = (await CommentsService.index()).data
    },
    methods: {
        navigateTo (route) {
            this.$router.push(route)
        },
        async deleteComment (comment) {
            try {
                await CommentsService.delete(comment)
                this.refreshData()
            } catch (err) {
                console.log(err)
            }
        },
        async refreshData() {
            this.comments = (await CommentsService.index()).data
        }
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