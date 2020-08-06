<template>
    <div class="component-wrapper container">
        <main-header navsel="front"></main-header>
        <div v-if="blog" >
            <div class="hero-wrapper">
                <div class="hero">
                    <img src="@/assets/logo.png" class="logo" style="float:left">
                    <h1>Webblot from nodejs + vuejs Ebook</h1>
                    <p>By Gooddev.ME</p>
                </div>
            </div>
            <div class="blog-wrapper" v-if="blog != null">
                <h1>{{ blog.title }}</h1>
                <p><strong>Category: </strong>: <a href="#" v-on:click.prevent="navigateTo(`/front?search=${blog.category}`)">{{blog.category }}</a></p>
                <div class="content" v-html="blog.content"></div>
                <!-- <p>category: {{ blog.category }}</p>
                <p>status: {{ blog.status }}</p> -->
            </div>
            <div class="back-nav"><button class="btn btn-success" v-on:click="navigateTo('/front')"><i class="fas fa-arrow-left"></i> Back..</button></div>
            <comment-comp v-bind:blogid="blog.id" v-bind:user="user"></comment-comp>
            <transition name="fade">
                <div v-if="resultUpdated != ''" class="popup-msg">
                    <p>{{ resultUpdated }}</p>
                </div>
            </transition>
            <br>
        </div>
    </div>
</template>
<script>
    import {mapState} from 'vuex'
    import BlogsService from '@/services/BlogsService'
    import UsersService from '@/services/UsersService'
    import CommentComp from '@/components/Fronts/Comment'

    export default {
        data () {
            return {
                blog: null,
                resultUpdated: '',
                users:null,
            }
        },
        components : {
            CommentComp
        },
        async created () {
            // get blog
            // check permission first
            try {
                let blogId = this.$route.params.blogId
                this.blog = (await BlogsService.show(blogId)).data
            } catch (error) {
                console.log (error)
            }
            },
            methods: {
                navigateTo (route) {
                this.$router.push(route)
                }
            },
            computed: {
                ...mapState([
                    'isUserLoggedIn',
                    'user'
                ])
            }
    }
</script>
<style scoped>
    .hero {
        margin-top: 80px;
        border-radius: 5px;
        background: darkcyan;
        height:250px;
        color:white;
        padding: 20px;
    }
    .hero h1 {
        margin-top: 30px;
    }
    .blog-wrapper {
        margin-top:20px;
        padding: 40px;
        box-shadow: 0 2px 4px 0 rgba(0,0,0,.2);
    }
    .back-nav {
        margin-top: 20px;
        text-align: center;
    }
    .blog-wrapper h1{
        text-align: center;
        font-family: 'kanit';
        padding-bottom: 50px;
    }
    .blog-wrapper p {
        font-family: 'kanit';
        font-size: 1.4em;
        padding-bottom:20px;
    }
    .blog-wrapper .content {
        font-family: 'kanit';
        font-size: 1.2em;
    }
</style>