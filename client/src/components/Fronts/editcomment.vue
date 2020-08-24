<template>
 <div id="edit-comment">
 <h4 v-if="user && compUser.id === user.id" class="comment-user">{{ compUser.name }}</h4>
 <h4 v-else>{{ compUser.name }}</h4>
 <hr>
 <transition name="fade">
 <p v-if="!editable" v-on:click.prevent="editComment(true, comment.id, compUser.id, user.id)" >{{comment.comment}}</p>
 </transition>
 <transition name="fade">
 <div v-if="updateEditable" class="form-edit-wrapper">
 <form v-on:submit.prevent="updateComment">
 <p><textarea rows="5" class="form-control" v-model="comment.comment"></textarea></p>
 <p>
 <button type="submit" class="btn btn-warning btn-xs"><i class="fas fa-save"></i> Update</button>
 <button type="button" v-on:click.prevent="editComment(false,comment.id, compUser.id, user.id)" class="btn btn-success btn-xs"><i class="fas fa-times-circle"></i> Close</button>
 </p>
 </form>
 </div>
 </transition>
 <p v-if="!editable && user != null && compUser.id === user.id"><button v-on:click="deleteComment(comment)" class="btn btn-xs-btn-danger"><i class="fas fa-trash-alt"></i> Delete</button></p>
 <p v-else-if="user.type === 'admin'"><button v-on:click="deleteComment(comment)" class="btn btn-xs btn-danger"><i class="fas fa-trash-alt"></i> Delete</button></p>

 </div>
</template>
<script>
    import CommentsService from '@/services/CommentsService'
    export default {
        props:['comment', 'users', 'user', 'editable'],
        data () {
            return {
                // userName: null,
                compUser:[]
            }
        },
        created () {
            this.getUser()
        },
        methods: {
            getUser () {
            this.users.forEach(user => {
                if (user.id == this.comment.userId) {
                    // this.userName = user.name
                    this.compUser = user
                }
            })
            // console.log('users')
            // console.log(this.users)
        },
        editComment (status, commentId, compId, userId) {
            // check permission first
            if (this.user != null) {
                if(compId == userId) {
                    if (status) {
                        this.$emit('editable-update', commentId)
                    } else {
                        this.$emit('editable-close')
                    }
                }
            }
            },
            async updateComment () {
                try {
                    await CommentsService.put(this.comment)
                    this.editable = false
                    let updateResult = "updated"
                    this.$emit('editable-close')
                    this.$emit('comment-part', updateResult)
                } catch (err) {
                    console.log(err)
                    let updateResult = "error"
                    this.$emit('comment-part', deleteResult)
                }
            },
            async deleteComment (comment) {

                let result = confirm("Want to delete?")
                if (result) {
                    try {
                        await CommentsService.delete(comment)
                        let deleteResult = "deleted"
                        this.$emit('comment-part', deleteResult)
                    } catch (err) {
                    console.log(err)
                        let deleteResult = "error"
                        this.$emit('comment-part', deleteResult)
                    }
                }
                let deleteResult = "deleted"
                this.$emit('comment-part', deleteResult)
            },
            updateEditStatus (commentId) {
                console.log("state update: " + commentId)
                this.editState.map((mState) => {
                    if(mState.id === commentId) {
                        mState.status = true
                    } else {
                        mState.status = false
                    }
                })
            },
        },
        computed: {
            updateEditable () {
            return this.editable
            }
        }
    }
</script>
<style scoped>
    .comment-user {
        background:#888;
        color:white;
        border-radius:4px;
    }
    h4{
        padding: 4px;
    }
</style>