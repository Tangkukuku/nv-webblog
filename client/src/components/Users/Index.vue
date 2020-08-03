<template>
   <div class="container">
      <main-header navsel="back"></main-header>
      <div class="blog-header">
         <br><br><br>
         <h2>Get all users</h2>
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
            <button class="btn btn-success btn-sm" v-on:click="navigateTo('/user/create')">สร้างผู้ใช้งาน</button>
            <strong>จํานวนผู้ใช้งาน {{users.length}}</strong>
         </div>
         <br>
      </div>
         <transition-group name="fade">
            <div v-for="user in users" v-bind:key="user.id" class="blog-list">
               <div class="blog-info">
                  <p>id: {{ user.id }}</p>
                  <p>ชืEอ-นามสกุล: {{ user.name }} - {{ user.lastname }}</p>
                  <p>email: {{ user.email }}</p>
                  <p>password: {{ user.password }}</p>
                  <p>
                     <button class="btn btn-sm btn-info"  v-on:click="navigateTo('/user/'+ user.id)">ดูข้อมูลผู้ใช้</button>
                     <button class="btn btn-sm btn-warning" v-on:click="navigateTo('/user/edit/'+ user.id)">แก้ไขข้อมูล</button>
                     <button class="btn btn-sm btn-danger" v-on:click="deleteUser(user)">ลบข้อมูล</button>
                     
                  </p>
               </div>
               <div class="clearfix"></div>
            </div>
         </transition-group>
         
      </div>
   </div>
</template>
<script>
import UsersService from '@/services/UsersService'

 export default {
   data () {
      return {
         users: []
      }
   },
   

   async created () {
      try {
         this.users = (await UsersService.index()).data
      } catch (error) {
         console.log (error)
      }
   },
   methods: {
      navigateTo (route) {
         this.$router.push(route)
      },
      async deleteUser (user) {
         await UsersService.delete(user)
         this.refreshData()
      },
      async refreshData() {
         this.users = (await UsersService.index()).data
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