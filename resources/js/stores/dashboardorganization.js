
import $axios from '../api.js'

const state = () => ({
    tonnase_out: [],
    transactions: [],
    transactionreceive: [],
    transactionssendback: [],
    transactionreceivesendback: [],
    globalpallet: [],
    pallet: [],
    pallettransporter: [],
    poolpalletdetail: [],
    warehouseinout: [],
    transportersendsendback: [],
    transporterdetail: [],
    detailpoolpallet: [], //detail pool pallet satu satu
    detailtransporter: [], //detail transporter satu satu
    totalallpallet: '',
})

const mutations = {
    ASSIGN_DATA_TONNASE_OUT(state, payload) {
        state.tonnase_out = payload
    },
    ASSIGN_DATA_TRANSACTION(state, payload) {
        state.transactions = payload
    },
    ASSIGN_DATA_TRANSACTION2(state, payload) {
        state.transactionssendback = payload
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
    ASSIGN_DATA_WAREHOUSE_IN_OUT(state, payload) {
        state.warehouseinout = payload
    },
    ASSIGN_DATA_TRANSPORTER_SEND_SENDBACK(state, payload) {
        state.transportersendsendback = payload
    },
    ASSIGN_DATA_TRANSPORTER_DETAIL(state, payload) {
        state.transporterdetail = payload
    },
    ASSIGN_DATA_DETAIL_POOL_PALLET(state, payload) {
        state.detailpoolpallet = payload
    },
    ASSIGN_DATA_DETAIL_TRANSPORTER(state, payload) {
        state.detailtransporter = payload
    },
    ASSIGN_DATA_TOTAL_ALL_PALLET(state, payload) {
        state.totalallpallet = payload
    },
}

const actions = {
    // getTonnaseOut({ commit }, payload) {
    //     return new Promise((resolve, reject) => {
    //         $axios.get(`/tonnaseout?month=${payload.month}&year=${payload.year}`)
    //         .then((response) => {
    //             commit('ASSIGN_DATA_TONNASE_OUT', response.data)
    //             resolve(response.data)
    //         })
    //     })
    // },
    getChartData({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationchart?month=${payload.month}&year=${payload.year}`)
            .then((response) => {
                commit('ASSIGN_DATA_TRANSACTION', response.data)
                resolve(response.data)
            })
        })
    },
    getChart2Data({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationchart2?month=${payload.month}&year=${payload.year}`)
            .then((response) => {
                commit('ASSIGN_DATA_TRANSACTION2', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataGlobalPalllet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationglobalpallet`)
            .then((response) => {
                commit('ASSIGN_DATA_GLOBAL_PALLET', response.data)
                resolve(response.data)
            })
        })
    },
    getTotalAllPallet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationtotalallpallet`)
            .then((response) => {
                commit('ASSIGN_DATA_TOTAL_ALL_PALLET', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataPallet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationpallet`)
            .then((response) => {
                commit('ASSIGN_DATA_PALLET', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataPalletTransporter({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationpallettransporter`)
            .then((response) => {
                commit('ASSIGN_DATA_PALLET_TRANSPORTER', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataPoolPalletDetail({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationpoolpalletdetail`)
            .then((response) => {
                commit('ASSIGN_DATA_POOL_PALLET_DETAIL', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataWarehouseInOut({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationwarehouseinout`)
            .then((response) => {
                commit('ASSIGN_DATA_WAREHOUSE_IN_OUT', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataTransporterSendSendback({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationtransportersendsendback`)
            .then((response) => {
                commit('ASSIGN_DATA_TRANSPORTER_SEND_SENDBACK', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataTransporterDetail({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationtransporterdetail`)
            .then((response) => {
                commit('ASSIGN_DATA_TRANSPORTER_DETAIL', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataDetailPoolPallet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationdetailpoolpallet?detail_pool_name=${payload.detail_pool_name}`)
            .then((response) => {
                commit('ASSIGN_DATA_DETAIL_POOL_PALLET', response.data)
                resolve(response.data)
            })
        })
    },
    getChartDataDetailTransporter({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/organizationdetailtransporter?detail_transporter_name=${payload.detail_transporter_name}`)
            .then((response) => {
                commit('ASSIGN_DATA_DETAIL_TRANSPORTER', response.data)
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
