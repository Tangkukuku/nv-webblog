const UserController = require('./controllers/UserController')
const UserAuthenController = require('./controllers/UserAuthenController')
const isAuthenController = require('./authen/isAuthenController') //ใช้เช็ค token
const BlogController = require('./controllers/BlogController')
const CommentController = require('./controllers/CommentController')

module.exports = (app) => {
    /* RESFUL Api for users management */
    // create user
    app.post('/user',
        UserController.create
    )

    // edit user, suspend, active
    app.put('/user/:userId',
        UserController.put
    )
    // delete user
    app.delete('/user/:userId',
        UserController.remove
    )
    // get user by id
    app.get('/user/:userId',
        UserController.show
    )

    // get last user
    app.get('/lastuser',
        UserController.lastuser
    )

    // get all user
    app.get('/users',
        isAuthenController,// ใช้เช็ค token
        UserController.index
    )
    app.post('/login',
        UserAuthenController.login
    )
    // blog route
    // create blog
    app.post('/blog',
        BlogController.create
    )
    // edit blog, suspend, active
    app.put('/blog/:blogId',
        BlogController.put
    )
    // delete blog
    app.delete('/blog/:blogId',
        BlogController.remove
    )
    // get blog by id
    app.get('/blog/:blogId',
        BlogController.show
    )
    // get all blog
    app.get('/blogs',
        BlogController.index
    )
    // comment route
    // create comment
    app.post('/comment',
        CommentController.create
    )
    // edit comment, suspend, active
    app.put('/comment/:commentId',
        CommentController.put
    )
    // delete comment
    app.delete('/comment/:commentId',
        CommentController.remove
    )
    // get comment by id
    app.get('/comment/:commentId',
        CommentController.show
    )
    // get all comment
    app.get('/comments',
        CommentController.index
    )
}