<template>
<!-- new navbar -->
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand navbar-link" href="#" v-on:click.prevent="navigateTo('/dashboard')">
                <img src="../assets/logo.png" id="logo">
            </a>
            <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcol-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span><span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="navcol-1">
            <ul class="nav navbar-nav navbar-right">
                <li><router-link :to="{name: 'blogs'}" >Blogs</router-link></li>
                <li><router-link :to="{name: 'users'}" >Users</router-link></li>
                <li><router-link :to="{name: 'comments'}" >Comments</router-link></li>
                <li><router-link :to="{name: 'login'}" >Login</router-link></li>
                <li><a href="#" v-on:click="logout">Logout</a></li>
            </ul>
        </div>
    </div>
    <!-- old navbar 
    <div class="nv-navbar">
    <ul class="nav">
    <li><router-link :to="{name: 'blogs'}" >Blogs</router-link></li>
    <li><router-link :to="{name: 'users'}" >Users</router-link></li>
    <li><router-link :to="{name: 'comments'}" >Comments</router-link></li>
    <li><router-link :to="{name: 'login'}" >Login</router-link></li>
    <li><a href="#" v-on:click="logout">Logout</a></li>
    </ul>
    <div class="clearfix"></div>
    </div>-->
</div>

</template>
<script>
export default {
    methods: {
        logout () {
            this.$store.dispatch('setToken', null)
            this.$store.dispatch('setBlog', null)
            this.$router.push({
                name: 'login'
            })
        }
    }
}
</script>
<style scoped>
    .nv-navbar {
        background-color:palegoldenrod;
        width: 100%;
        padding:10px 0px 10px 0px;
    }

    .nv-navbar .nav {
        list-style: none;
        margin:0;
        padding:0;
        float:left;
    }

    .nv-navbar .nav li {
        float:left;
    }

    .nv-navbar .nav li a {
        padding: 10px;
        text-decoration: none;
        color:gray;
        font-weight: bold;
    }

    .nv-navbar .nav li a:hover {
        padding: 10px;
        text-decoration: none;
        color:darkslategrey;
    }

    .nv-navbar .nav li a.router-link-active {
        background-color:gold;
        color:darkslategrey;
    }

    .navbar-brand > img {
        width: 36px;
        padding: 12px 0;
        margin-top: -20px;
    }
    a.router-link-active{
        color:yellowgreen !important;
    } 
    .navbar-inverse {
        background-color: #222;
        border-color: #080808;
    }
 </style>