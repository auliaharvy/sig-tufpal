
import $axios from '../api.js'

const state = () => ({
    transactions: [],
    transactionreceive: [],
    globalpallet: [],
    pallet: [],
    pallettransporter: [],
    poolpalletdetail: [],
    transporterdetail: [],
})

const mutations = {
    ASSIGN_DATA_TRANSACTION(state, payload) {
        state.transactions = payload
    },
    ASSIGN_DATA_TRANSACTION_RECEIVE(state, payload) {
        state.transactions_receive = payload
    },
    ASSIGN_DATA_GLOBAL_PALLET(state, payload) {
        state.globalpallet = payload
    },
    ASSIGN_DATA_PALLET(state, payload) {
        state.pallet = payload
    },
    ASSIGN_DATA_PALLET_TRANSPORTER(state, payload) {
        state.pallettransporter = payload
    },
    ASSIGN_DATA_POOL_PALLET_DETAIL(state, payload) {
        state.poolpalletdetail = payload
    },
    ASSIGN_DATA_TRANSPORTER_DETAIL(state, payload) {
        state.transporterdetail = payload
    },
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
    getChartDataGlobalPalllet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/globalpallet`)
            .then((response) => {
                commit('ASSIGN_DATA_GLOBAL_PALLET', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataPallet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/pallet`)
            .then((response) => {
                commit('ASSIGN_DATA_PALLET', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataPalletTransporter({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/pallettransporter`)
            .then((response) => {
                commit('ASSIGN_DATA_PALLET_TRANSPORTER', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataPoolPalletDetail({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/poolpalletdetail`)
            .then((response) => {
                commit('ASSIGN_DATA_POOL_PALLET_DETAIL', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataTransporterDetail({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/transporterdetail`)
            .then((response) => {
                commit('ASSIGN_DATA_TRANSPORTER_DETAIL', response.data)
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
