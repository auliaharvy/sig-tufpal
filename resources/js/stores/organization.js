import $axios from '../api.js'

const state = () => ({
    loading: false,
    organizations: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    organization: {
        organization_name: '',
        organization_address: '',
        phone_number: '',
        organization_email: '',
        created_by: '',
        updated_by: '',
        created_at: '',
        updated_at: '',
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
        state.organizations = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.organization = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.organization = {
            organization_name: '',
            organization_address: '',
            phone_number: '',
            organization_email: '',
            created_by: '',
            updated_by: '',
            created_at: '',
            updated_at: '',
        }
    }
}

const actions = {
    getOrganization({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/organization?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    submitOrganization({ dispatch, commit, state }) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            //MENGIRIMKAN REQUEST KE BACKEND DENGAN DATA YANG DIDAPATKAN DARI STATE CUSTOMER
            $axios.post(`/organization`, state.organization)
            .then((response) => {
                //APABILA BERHASIL MAKA LOAD DATA CUSTOMER UNTUK MENGAMBIL DATA TERBARU
                dispatch('getOrganization').then(() => {
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
      editOrganization({ commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.get(`/organization/${payload}/edit`) //KIRIM PERMINTAAN KE SERVER UNTUK MENGAMBIL SINGLE DATA CUSTOMER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                commit('ASSIGN_FORM', response.data.data) //ASSIGN DATA TERSEBUT KE DALAM STATE CUSTOMER
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    updateOrganization({ state, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.put(`/organization/${payload}`, state.organization) //KIRIM PERMINTAAN KE SERVER UNTUK MENGUPDATE DATA BERDASARKAN PAYLOAD (ID) DAN DATA YANG AKAN DI UPDATE DI AMBIL DARI STATE CUSTOMER
            .then((response) => {
                commit('CLEAR_FORM') //BERSIHKAN FORM
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
            })
        })
    },
    removeOrganization({ dispatch, commit }, payload) {
        commit('isLoading')
        return new Promise((resolve, reject) => {
            $axios.delete(`/organization/${payload}`) //KIRIM REQUEST KE SERVER BERDASARKAN PAYLOAD (ID)
            .then((response) => {
                dispatch('getOrganization').then(() => resolve()) //AMBIL DATA CUSTOMER TERBARU
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
