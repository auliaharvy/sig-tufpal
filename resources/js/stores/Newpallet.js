import $axios from '../api.js'

const state = () => ({
    loading: false,
    newpallets: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    newpallet: {
        adder_user_id: '',
        pool_pallet_id: '',
        np_number   : '',
        good_pallet: '',
        vendor: '',
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
        state.newpallets = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.newpallet = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.newpallet = {
            adder_user_id: '',
            pool_pallet_id: '',
            np_number   : '',
            good_pallet: '',
            vendor: '',
            note: '',
        }
    }
}

const actions = {
    getNewpallet({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/newpallet?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    submitNewpallet({ dispatch, commit, state }) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/newpallet`, state.newpallet)
            .then((response) => {
                //APABILA BERHASIL MAKA LOAD DATA CUSTOMER UNTUK MENGAMBIL DATA TERBARU
                dispatch('getNewpallet').then(() => {
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
      editNewpallet({ commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.get(`/newpallet/${payload}/edit`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    updateNewpallet({ state, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.put(`/newpallet/${payload}`, state.pool) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    removeNewpallet({ dispatch }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.delete(`/newpallet/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getNewpallet').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
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
