<template>
 <div>
 <h1>Get All Users</h1>
 <div v-if="users.length">
 <div>จํานวนผู้ใช้งาน {{ users.length }}</div>
 <div>id: {{ users[0].id }}</div>
 <div>ชืEอ-นามสกุล: {{ users[0].name }} - {{ users[0].lastname }}</div>
 <div>email: {{ users[0].email }}</div>
 <div>password: {{ users[0].password }}</div>
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
 this.users = (await UsersService.index()).data
 }
}
</script>
<style scoped>
</style> 