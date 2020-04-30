
import $axios from '../api.js'

const state = () => ({
    transactions: [],
    transactionreceive: [],
})

const mutations = {
    ASSIGN_DATA_TRANSACTION(state, payload) {
        state.transactions = payload
    },
    ASSIGN_DATA_TRANSACTION_RECEIVE(state, payload) {
        state.transactions_receive = payload
    }
}

const actions = {
    getChartData({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/chart?month=${payload.month}&year=${payload.year}`)
            .then((response) => {
                commit('ASSIGN_DATA_TRANSACTION', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataReceive({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/receive?month=${payload.month}&year=${payload.year}`)
            .then((response) => {
                commit('ASSIGN_DATA_TRANSACTION_RECEIVE', response.data)
                resolve(response.data)
            })
        })
    },
}

export default {
    namespaced: true,
    state,
    actions,
    mutations
}