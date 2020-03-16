import $axios from '../api.js'

const state = () => ({
    loading: false,
    bermissings: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    bermissing: {
        bmp_number: '',
        reporter_user_id: '',
        approver_user_id: '',
        pool_pallet_id: '',
        transporter_id: '',
        reference_sjp_status_id: '',
        ber_pallet: '',
        missing_pallet: '',
        reporter_prove: '',
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
        state.bermissings = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.bermissing = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.bermissing = {
            bmp_number: '',
            reporter_user_id: '',
            approver_user_id: '',
            pool_pallet_id: '',
            transporter_id: '',
            reference_sjp_status_id: '',
            ber_pallet: '',
            missing_pallet: '',
            reporter_prove: '',
            status: '',
            note: '',
        }
    }
}

const actions = {
    getBermissing({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/bermissing?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            })
        })
    },
    submitBermissing({ dispatch, commit}, payload ) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/bermissing`, payload,{
            headers: {
                'Content-Type': 'multipart/form-data'
            }
            })
            .then((response) => {
                //APABILA BERHASIL MAKA LOAD DATA CUSTOMER UNTUK MENGAMBIL DATA TERBARU
                dispatch('getBermissing').then(() => {
                    resolve(response.data)
                })
            })
            .catch((error) => {
                alert("Input Error!")
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            }).finally(() => {
                commit('doneLoading')
            })
        })
      },
      editBermissing({ commit }, payload) {
        return new Promise((resolve, reject) => {
            $axios.get(`/bermissing/${payload}/edit`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            })
        })
    },
    updateBermissing({ state, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.post(`/bermissing/approve`, state.bermissing) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            })
            .catch((error) => {
                alert("Input Error!")
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    updateBermissingDisapprove({ state, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.post(`/bermissing/disapprove`, state.bermissing) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            })
            .catch((error) => {
                alert("Input Error!")
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    removeBermissing({ dispatch }, payload) {
        return new Promise((resolve, reject) => {
            $axios.delete(`/bermissing/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getBermissing').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
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