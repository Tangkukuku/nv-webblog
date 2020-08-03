<template>
<div>
    <main-header navsel="back"></main-header>
    <br><br>
    <h1>User Login</h1>
    <center>
        <form v-on:submit.prevent="onLogin" class="blog-list">
            <br>
            <h1>User Login</h1>
            <p>Username: <input type="text" v-model="email" /></p>
            <p>Password: <input type="password" v-model="password" /></p>
            <p><button type="submit" class="btn btn-light">Login</button></p>
            
            <div class="error" v-if="error">{{error}}</div>
            <br>
        </form>
    </center>
</div>

</template>
<script>

import AuthenService from '@/services/AuthenService'
export default {
    data () {
        return {
            email: '',
            password: '',
            error: null
        }
    },
    methods: {
        async onLogin () {
            try {
                const response = await AuthenService.login({
                    email: this.email,
                    password: this.password
                })

                this.$store.dispatch('setToken', response.data.token)
                this.$store.dispatch('setUser', response.data.user)

                this.$router.push({
                    name: 'users'
                })

            } catch (error) {
                console.log(error)
                this.error = error.response.data.error
                this.email = ''
                this.password = ''
            }

        }
    }
}
</script>
<style scoped>
    .error {
    color:red;
    }
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
        max-width: 40%;

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