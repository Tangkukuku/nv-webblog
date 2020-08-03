<template>
    <div>
        <main-header navsel="back"></main-header>
        <br><br><br>
        <center><h1>Create User</h1></center>
        <form v-on:submit.prevent = "createUser">
            <p>name: <input class="form-control center_div" type="text" v-model="user.name"></p>
            <p>lastname: <input class="form-control center_div" type="text" v-model="user.lastname"></p>
            <p>email: <input class="form-control center_div" type="text" v-model="user.email"></p>
            <p>password: <input class="form-control center_div" type="text" v-model="user.password"></p>
            <center><p><button class="btn btn-success btn-sm" type="submit">create user</button></p></center>
        </form>
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
        status: 'active'
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
    }
 }
}
</script>
<style scoped>
    .center_div {
        margin:auto;
        width:50%;
    }
</style>