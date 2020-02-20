import $axios from '../api.js'

const state = () => ({
    pools: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    pool: {
        organization_id: '',
        code: '',
        type: '',
        pool_name: '',
        pool_address: '',
        pool_city: "",
        phone_number: "",
        pool_email: "", 
        pallet_quota: "",
        good_pallet: "",
        tbr_pallet: "",
        ber_pallet: "",
        missing_pallet: "", 
        
        
    },
    page: 1
})

const mutations = {
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.pools = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.pool = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.pool = {
            organization_id: '',
            code: '',
            type: '',
            pool_name: '',
            pool_address: '',
            pool_city: "",
            phone_number: "",
            pool_email: "", 
            pallet_quota: "",
            good_pallet: "",
            tbr_pallet: "",
            ber_pallet: "",
            missing_pallet: "",
        }
    }
}

const actions = {
    getPools({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/pool?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            })
        })
    },
    submitPools({ dispatch, commit, state }) {
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/pool`, state.pool)
            .then((response) => {
                //APABILA BERHASIL MAKA LOAD DATA CUSTOMER UNTUK MENGAMBIL DATA TERBARU
                dispatch('getPools').then(() => {
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
      editPools({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/pool/${payload}/edit`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            })
        })
    },
    updatePools({ state, commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.put(`/pool/${payload}`, state.pool) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            })
        })
    },
    removePools({ dispatch }, payload) {
        return new Promise((resolve, reject) => {
            $axios.delete(`/pool/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getPools').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
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