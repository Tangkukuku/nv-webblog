import Api from '@/services/Api'
export default {
    index(search) {
        return Api().get('buys', {
            params: {
                search: search
            }
        })
    },
    post(buy) {
        return Api().post('buy', buy)
    },
    put(buy) {
        return Api().put('buy/' + buy.id, buy)
    },
    user(buy) {
        return Api().get('buy/'+ buy)
    }
}