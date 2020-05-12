import $axios from '../api.js'
import Axios from 'axios'

const state = () => ({
    loading: false,

    dispatchData: {
        departure_time: '',
        dest_pool: '',
        destination_pool_pallet_id: '',
        driver_id: '',
        driver_name: '',
        no_dispatch: '',
        packaging: '',
        pallet_quantity: '',
        product_quantity: '',
        tonnage: '',
        transporter_id: '',
        transporter_name: '',
        vehicle_number: '',
    },
    page: 1
})

const mutations = {
    isLoading (state) {
        state.loading = true
      },
      doneLoading (state) {
        state.loading = false
      },
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.dispatchData = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.dispatchData = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.dispatchData = {
            departure_time: '',
            dest_pool: '',
            destination_pool_pallet_id: '',
            driver_id: '',
            driver_name: '',
            no_dispatch: '',
            packaging: '',
            pallet_quantity: '',
            product_quantity: '',
            tonnage: '',
            transporter_id: '',
            transporter_name: '',
            vehicle_number: '',
        }
    }
}

const actions = {
    getSjp({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/sjp?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            })
        })
    },
    getDataDispatch({commit}, payload) {
        return new Promise((resolve, reject) => {
            Axios.get('b2b.indocement.co.id/WSTufpalBridge_TEST/TUFPAL.svc/json/GetDataDispatch/')
            .then((response) => {
                commit('ASSIGN_DATA', response.data)
                resolve(response.data)
            })
        })
    },

    submitGetData({ dispatch ,commit}, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/api/getdispatch`, payload, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            .then((response) => {
                console.log(response)})
            }).catch((error) => {
                alert(error.response.data.message)
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            }).finally(() => {
                commit('doneLoading')
            })
        },

      editSjp({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/sjp/${payload}/edit`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            })
        })
    },
    updateSjp({ state, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.post(`/sjp/adjust`, state.sjp) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            })
            .catch((error) => {
                alert(error.response.data.message)
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    updateSjpchangedest({ state, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.post(`/sjp/changedestination`, state.sjp) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            })
            .catch((error) => {
                alert(error.response.data.message)
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    removeSjp({ dispatch }, payload) {
        return new Promise((resolve, reject) => {
            $axios.delete(`/sjp/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getSjp').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
            })
        })
    }
}

export default {
    namespaced: true,
    state,
    actions,
    mutations
}
