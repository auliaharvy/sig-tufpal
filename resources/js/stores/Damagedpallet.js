import $axios from '../api.js'

const state = () => ({
    damagedpallets: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    damagedpallet: {
        reporter_user_id: '',
        pool_pallet_id: '',
        dp_number   : '',
        tbr_pallet: '',
        note: '',
      
    },
    page: 1
})

const mutations = {
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.damagedpallets = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.damagedpallet = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.damagedpallet = {
            reporter_user_id: '',
            pool_pallet_id: '',
            dp_number   : '',
            tbr_pallet: '',
            note: '',
        }
    }
}

const actions = {
    getDamagedpallet({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/damagedpallet?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            })
        })
    },
    submitDamagedpallet({ dispatch, commit, state }) {
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/damagedpallet`, state.damagedpallet)
            .then((response) => {
                //APABILA BERHASIL MAKA LOAD DATA CUSTOMER UNTUK MENGAMBIL DATA TERBARU
                dispatch('getDamagedpallet').then(() => {
                    resolve(response.data)
                })
            })
            .catch((error) => {
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            })
        })
      },
      editDamagedpallet({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/damagedpallet/${payload}/edit`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            })
        })
    },
    updateDamagedpallet({ state, commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.put(`/damagedpallet/${payload}`, state.pool) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            })
        })
    },
    removeDamagedpallet({ dispatch }, payload) {
        return new Promise((resolve, reject) => {
            $axios.delete(`/damagedpallet/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getDamagedpallet').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
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