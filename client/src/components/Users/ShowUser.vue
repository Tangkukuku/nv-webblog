<template>
    <div>
        <main-header navsel="back"></main-header>
        <br><br><br>
        <center><h1>Show User</h1>
        <table border="0">
            <tr>
                <th class="d">
                    <center><b>id:</b></center>
                </th>
                <th class ="c">
                    <div class="form-control center_div" readonly>id: {{ user.id }}</div>
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>ชื่อ-นามสกุล:</b></center>
                </th>
                <th class ="c">
                    <div class="form-control center_div" readonly> {{ user.name }} - {{ user.lastname }}</div>
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>email:</b></center>
                </th>
                <th class ="c">
                    <div class="form-control center_div" readonly> {{ user.email }}</div>
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>password:</b></center>
                </th>
                <th class ="c">
                    <div class="form-control center_div" readonly> {{ user.password }}</div>
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>status:</b></center>
                </th>
                <th class ="c">
                    <div class="form-control center_div" readonly> {{ user.status }}</div>
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>type:</b></center>
                </th>
                <th class ="c">
                    <div class="form-control center_div" readonly> {{ user.type }}</div>
                </th>
            </tr>
        </table>
        </center>
        <br>
        
        <center><button class="btn btn-success btn-sm" v-on:click="navigateTo('/users')">Back..</button></center>
    </div>
</template>
<script>
import UsersService from '@/services/UsersService'
export default {
    data () {
        return {
            user: null
        }
    },
    async created () {
        try {
            let userId = this.$route.params.userId
            this.user = (await UsersService.show(userId)).data
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
    .center_div {
        width:100%;
    }
    .c {
        width: 600px ;
    }
    .d{
        width: 100px ;
    }
</style>