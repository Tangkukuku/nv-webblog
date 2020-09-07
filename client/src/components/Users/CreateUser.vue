<template>
    <div>
        <main-header navsel="back"></main-header>
        <br><br><br>
        <center><h1>Create User</h1>
        <form v-on:submit.prevent = "createUser">
            <table border="0">
            <tr>
                <th class="d">
                    <center><b>name:</b></center>
                </th>
                <th class ="c">
                    <input class="form-control center_div" type="text" v-model="user.name">
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>lastname:</b></center>
                </th>
                <th class ="c">
                    <input class="form-control center_div" type="text" v-model="user.lastname">
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>email:</b></center>
                </th>
                <th class ="c">
                    <input class="form-control center_div" type="text" v-model="user.email">
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>password:</b></center>
                </th>
                <th class ="c">
                    <input class="form-control center_div" type="text" v-model="user.password">
                </th>
            </tr>
            <br>
            <tr>
                <th class="d">
                    <center><b>type:</b></center>
                </th>
                <th class ="c">
                    <select class="form-control" v-model="user.type">
                        <option value="admin">Admin</option>
                        <option value="user" >User</option>
                    </select>
                </th>
            </tr>
            </table>
            <br>
                <p>
                    <button class="btn btn-success btn-sm" type="submit">Create user</button>
                    <button class="btn btn-sm secondary" v-on:click="navigateTo('/users')">Back..</button>
                </p>
            
        </form>
        
            
        
        
    </center>
    </div>
</template>
<script>
import UsersService from '@/services/UsersService'
export default {
 data () {
    return {
        user: {
            name: '',
            lastname: '',
            email: '',
            password: '',
            status: 'active',
            type: "admin",
        }
    }
 },
 methods: {
    async createUser () {
        try {
            await UsersService.post(this.user)
            this.$router.push({
                name: 'users'
            })
        } catch (err) {
            console.log(err)
        }
    },
    navigateTo (route) {
        this.$router.push(route)
    },
 }
}
</script>
<style scoped>
    .center_div {
        margin:auto;
        width:50%;
    }
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