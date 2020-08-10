<template>
    <div id="comment">
        <div class="comments-wrapper">
            <div class="comment-form-wrapper">
                <h4>Comments</h4>
                <form v-on:submit.prevent="sendComment">
                    <p><textarea rows="5" class="form-control" v-model="comment"></textarea></p>
                    <p v-if="user == null">Login / Register for commented.</p>
                    <p v-else ><button type="submit" class="btn btn-primary"><i class="fas fa-comment"></i> Send Comment</button></p>
                </form>
            </div>
            <transition-group tag="ul" name="fade" class="comment-list">
                <li v-for="comment in comments" :key="comment.id">
                    <edit-comment
                    :editable="editState.find(status => status.id === comment.id).status"
                    :comment="comment"
                    v-on:comment-part="updatedResult"
                    v-on:editable-update="updateEditStatus"
                    v-on:editable-close="closeEditor"
                    :user="user"
                    :users="users"
                    ></edit-comment> 
                </li>
            </transition-group>
        </div>
        <transition name="fade">
            <div v-if="resultUpdated != ''" class="popup-msg">
                <p>{{ resultUpdated }}</p>
            </div>
        </transition>
    </div>
</template>
<script>
    import CommentsService from '@/services/CommentsService'
    import EditComment from '@/components/Fronts/EditComment'
    import UsersService from '@/services/UsersService'
    export default {
        props:['blogid', 'user'],
        data () {
            return {
                comment: null,
                comments: '',
                resultUpdated: '',
                editState:[] 
            }
        },
        components: {
            EditComment
        },
        methods: {
            closeEditor(){
                this.editState.map((mState) => {mState.status = false})
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
            async reloadComment () {
                try {
                    this.comments = (await CommentsService.blog(this.blogid)).data
                    this.comments.map((comment) => {this.editState.push({id:comment.id, status:false})})
                } catch (error) {
                    console.log (error)
                } 
            },
            async sendComment () {
                // console.log(`comment: ${this.comment}`)
                try {
                    let comment = {
                        blogId:this.blogid,
                        comment:this.comment,
                        userId:this.user.id
                    }
                    console.log(comment)
                    await CommentsService.post(comment)
                    this.comment = ''
                    this.resultUpdated = "We are recieved"
                    setTimeout(() => this.resultUpdated = '', 3000)
                    this.reloadComment()
                } catch (err) {
                    console.log(err)
                }
            },
            updatedResult (result) {
                // console.log('Hello result:')
                // console.log(result)
                // console.log(result)
                if (result === "updated") {
                    this.resultUpdated = "Updated successful."
                    this.reloadComment()
                } else if (result === "deleted") {
                    this.resultUpdated = "Deleted successful."
                    this.reloadComment()
                } else {
                    this.resultUpdated = "System have some error."
                }
                setTimeout(() => this.resultUpdated = '', 3000)
            },
        },
        async created () {
            // get all users
            try {
                this.users = (await UsersService.getFront()).data
                // console.log(this.users)
            } catch (error) {
                console.log (error)
            }
            this.reloadComment()
        }
    }

</script>
<style scoped>
.blog-wrapper {
 margin-top:80px;
}
/* thumbnail */
.thumbnail-pic img{
 width:200px;
 margin-bottom: 10px;
}
/* display uploaded pic */
ul.pictures {
 list-style: none;
 padding: 0;
 margin: 0;
 float: left;
 padding-top: 10px;
 padding-bottom: 10px;
}
ul.pictures li {
 float: left;
}
ul.pictures li img {
 max-width: 180px;
 margin-right: 20px;
}
.clearfix {
 clear: both;
}
/* uplaod */
.dropbox {
 outline: 2px dashed grey; /* the dash box */
 outline-offset: -10px;
 background:lemonchiffon;
 color: dimgray;
 padding: 10px 10px;
 min-height: 200px; /* minimum height */
 position: relative;
 cursor: pointer;
}
.input-file {
 opacity: 0; /* invisible but it's there! */
 width: 100%;
 height: 200px;
 position: absolute;
 cursor: pointer;
}
.dropbox:hover {
 background:khaki; /* when mouse over to the drop zone, change color */
}
.dropbox p {
 font-size: 1.2em;
 text-align: center;
 padding: 50px 0;
}
</style>