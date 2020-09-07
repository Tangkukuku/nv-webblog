<template>
  <div>
    <div class="user-wrapper">
      <div class="container">
        <div class="row">
          <div class="con-md-12">
            <div class="login-wrapper">
              <h1>Login</h1>
              <form v-on:submit.prevent="onLogin" class="form-horizontal">
                <div class="form-group">
                  <label for="" class="control-label col-md-3">Username: </label>
                  <div class="col-md-8">
                    <input type="text" v-model="email" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label for="" class="control-label col-md-3">Password: </label>
                  <div class="col-md-8">
                    <input type="password" v-model="password" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-md-offset-3 col-md-8">                    
                    <button class="btn btn-default" type="submit"><i class="fas fa-sign-in-alt"></i> Sign In</button>
                    <p class="error" v-if="error">{{error}}</p>
                  </div>
                </div>
                <!-- <p>username: <input type="text" v-model="email" /></p>
                <p>password: <input type="password" v-model="password"></p> -->
                <!-- <p><button type="submit">Sign In</button></p> -->
              </form>
              <!-- <div class="error" v-if="error">{{error}}</div> -->
            </div>
          </div>
        </div>
      </div>
    </div> 
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
          name: 'blogs'
        })
        console.log(response.data)
        
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
  margin-top: 10px;
}

.login-wrapper {
  /* border: solid 1px red; */
  width: 400px;
  margin-left: auto;
  margin-right: auto;
  margin-top: 80px;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.30);
  border: 1px solid #f3f3f3;
  border-radius: 3px;
  padding: 20px;
}

.login-wrapper h1 {
  text-align: center;
  padding-bottom: 20px;
  margin-top: 0px;
  font-family: Kanit;
}
</style>

