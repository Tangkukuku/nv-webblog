const UserController = require('./controllers/UserController')
const UserAuthenController = require('./controllers/UserAuthenController')
const isAuthenController = require('./authen/isAuthenController') //ใช้เช็ค token
const BlogController = require('./controllers/BlogController')
const BookController = require('./controllers/BookController')
const CommentController = require('./controllers/CommentController')
let multer = require("multer")
// upload section
let storage = multer.diskStorage({
    destination: function(req, file, callback) {
        callback(null, "./src/public/uploads");
    },
    filename: function(req, file, callback) {
        // callback(null, file.fieldname + '-' + Date.now());
        console.log(file);
        callback(null, file.originalname);
    }
})

   

module.exports = (app) => {

    let upload = multer({ storage: storage }).array("userPhoto", 10)
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
        isAuthenController,// ใช้เช็ค token
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
        isAuthenController,// ใช้เช็ค token
        CommentController.index
    )
    app.post('/front/login',
        UserAuthenController.clientLogin
    )
    // upload
    app.post("/upload", function(req, res) {
        // isUserAuthenticated,
        upload(req, res, function(err) {
            if (err) {
                return res.end("Error uploading file.");
            }
            res.end("File is uploaded");
        })
    })
    //delete file uploaded function
    app.post('/upload/delete', async function (req, res) {
        try {
            const fs = require('fs');
            console.log(req.body.filename)
            fs.unlink(process.cwd() + '/src/public/uploads/' + req.body.filename,
            (err) => {
                if (err) throw err;
                res.send("Delete sucessful")
                // console.log('successfully deleted material file');
            });
        } catch (err) {
            res.status(500).send({
                error: 'An error has occured trying to delete file the material'
            })
        }
    })
    
    // get comment by id
    app.get('/comment/blog/:blogId',
        CommentController.blog
    )

    // get comment by id
    app.get('/comment/user/:userId',
        CommentController.user
    )
    // users
    // get front
    app.get('/users/front',
        UserController.getFront
    )
    app.get('/blogs/front',
        BlogController.frontIndex
    )
    
    // book route
    // create book
    app.post('/book',
        isAuthenController,
        BookController.create
    )
    // edit book, suspend, active
    app.put('/book/:bookId',
        isAuthenController,
        BookController.put
    )
    // delete book
    app.delete('/book/:bookId',
        isAuthenController,
        BookController.remove
    )
    // get book by id
    app.get('/book/:bookId',
        BookController.show
    )
    // get all book
    app.get('/books',
        isAuthenController,
        BookController.index
    )
    app.get('/books/front',
        BookController.frontIndex
    )
}