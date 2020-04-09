import $axios from '../api.js'

const state = () => ({
    loading: false,
    repairedpallets: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    repairedpallet: {
        reporter_user_id: '',
        pool_pallet_id: '',
        rp_number   : '',
        good_pallet: '',
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
        state.repairedpallets = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.repairedpallet = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.repairedpallet = {
            reporter_user_id: '',
            pool_pallet_id: '',
            rp_number   : '',
            good_pallet: '',
            note: '',
        }
    }
}

const actions = {
    getRepairedpallet({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/repairedpallet?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            })
        })
    },
    submitRepairedpallet({ dispatch, commit, state }) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/repairedpallet`, state.repairedpallet)
            .then((response) => {
                //APABILA BERHASIL MAKA LOAD DATA CUSTOMER UNTUK MENGAMBIL DATA TERBARU
                dispatch('getRepairedpallet').then(() => {
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
      editRepairedpallet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/repairedpallet/${payload}/edit`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            })
        })
    },
    updateRepairedpallet({ state, commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.put(`/repairedpallet/${payload}`, state.pool) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            })
        })
    },
    removeRepairedpallet({ dispatch }, payload) {
        return new Promise((resolve, reject) => {
            $axios.delete(`/repairedpallet/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getRepairedpallet').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
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