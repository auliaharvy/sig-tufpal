import $axios from '../api.js'

const state = () => ({
    loading: false,
    pallettransfers: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    pallettransfer: {
        departure_pool_pallet_id: '',
        destination_pool_pallet_id: '',
        sender_user_id: '',
        receiver_user_id: '',
        transporter_id: '',
        driver_id: '',
        vehicle_id: '',
        tp_number: '',
        good_pallet: 0,
        tbr_pallet: 0,
        reason: '',
        status: '',
        note: '',


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
        state.pallettransfers = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.pallettransfer = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.pallettransfer = {
            departure_pool_pallet_id: '',
            destination_pool_pallet_id: '',
            sender_user_id: '',
            receiver_user_id: '',
            transporter_id: '',
            driver_id: '',
            vehicle_id: '',
            tp_number: '',
            good_pallet: 0,
            tbr_pallet: 0,
            reason: '',
            status: '',
            note: '',
        }
    }
}

const actions = {
    getPalletTransfer({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/pallettransfer?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    submitPalletTransfer({ dispatch, commit, state }) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/pallettransfer`, state.pallettransfer)
            .then((response) => {
                //APABILA BERHASIL MAKA LOAD DATA CUSTOMER UNTUK MENGAMBIL DATA TERBARU
                dispatch('getPalletTransfer').then(() => {
                    resolve(response.data)
                })
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
      editPalletTransfer({ commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.get(`/pallettransfer/${payload}`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    updatePalletTransfer({ state, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.post(`/pallettransfer/receive`, state.pallettransfer) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
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
    removePalletTransfer({ dispatch, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.delete(`/pallettransfer/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getPalletTransfer').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
            }).finally(() => {
                commit('doneLoading')
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
