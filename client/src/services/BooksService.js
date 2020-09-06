import Api from '@/services/Api'
export default {
    index(search) {
        return Api().get('books', {
            params: {
                search: search
            }
        })
    },
    show(bookId) {
        return Api().get('book/' + bookId)
    },
    post(book) {
        return Api().post('book', book)
    },
    put(book) {
        return Api().put('book/' + book.id, book)
    },
    delete(book) {
        return Api().delete('book/' + book.id, book)
    },
    frontIndex(search) {
        return Api().get('books/front', {
            params: {
                search: search
            }
        })
    },
}