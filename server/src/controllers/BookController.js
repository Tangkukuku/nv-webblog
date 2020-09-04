const {Book} = require('../models')

module.exports = {
    // indx with serach Book
    async index (req, res) {
        try {
            let books = null
            const search = req.query.search
            // console.log('search key: ' + search)
            if (search) {
                books = await Book.findAll({
                    where: {
                        $or: [
                            'title', 'content', 'category'
                        ].map(key => ({
                            [key]: {
                                $like: `%${search}%`,
                            }
                        })),
                    },
                    order: [['createdAt', 'DESC']]
                })
            } else {
                books = await Book.findAll({
                    order: [['createdAt', 'DESC']]
                })
            }
                res.send(books)
            } catch (err) {
            res.status(500).send({
                error: 'an error has occured trying to fetch the books'
            })
        }
    },
    // create Book
    async create (req, res) {
        // res.send(JSON.stringify(req.body))
        try {
            const book = await Book.create(req.body)
            res.send(book.toJSON())
        } catch (err) {
            res.status(500).send({
                error: 'Create Book incorrect'
            })
        }
    },
    // edit Book, suspend, active
    async put (req, res) {
        try {
            await Book.update(req.body, {
                where: {
                    id: req.params.bookId
                }
            })
        res.send(req.body)
        } catch (err) {
            req.status(500).send({
                error: 'Update Book incorrect'
            })
        }
    },
        // delete Book
    async remove (req, res) {
        try {
            const book = await Book.findOne({
                where: {
                id: req.params.bookId
                }
            })
            if(!book){
                return res.status(403).send({
                    error: 'The Book information was incorrect'
                })
            }
            await book.destroy()
            res.send(book)
        } catch (err) {
            req.status(500).send({
                error: 'The Book information was incorrect'
            })
        }
    },
        // get Book by id
    async show (req, res) {
        try {
            const book = await Book.findById(req.params.bookId)
            res.send(book)
        } catch (err) {
            req.status(500).send({
                error: 'The Book information was incorrect'
            })
        }
    },
    async frontIndex (req, res) {
        try {
            let books = null
            const search = req.query.search
            console.log('----------> search key: ' + search)
            if (search) {
                books = await Book.findAll({
                    where: {
                        $or: [
                            'title', 'content', 'category'
                        ].map(key => ({
                            [key]: {
                                $like: `%${search}%`,
                            }
                        })),
                        $and: [
                            {
                                status:
                                {
                                    $eq: "published"
                                }
                            },
                        ]
                    },
                    order: [['createdAt', 'DESC']]
                })
            } else {
                books = await Book.findAll({
                where: {
                    'status': 'published'
                },
                    order: [['createdAt', 'DESC']]
                })
            }
            res.send(books)
        }catch (err) {
            res.status(500).send({
                error: 'an error has occured trying to fetch the books'
            })
        }
    },

}