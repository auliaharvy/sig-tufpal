import $axios from '../api.js'

const state = () => ({
    loading: false,
    sjpadjusments: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    sjpadjusment: {
        sjp_number: '',
        vehicle: '',
        new_vehicle: '',
        driver: '',
        new_driver: '',
        adjust_by: "",
        created_at: "",
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
        state.sjpadjusments = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.sjpadjusment = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.sjpadjusment = {
            sjp_number: '',
            vehicle: '',
            new_vehicle: '',
            driver: '',
            new_driver: '',
            adjust_by: "",
            created_at: "",
        }
    }
}

const actions = {
    getSjpadjusment({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/sjpadjusment?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
            }).finally(() => {
                commit('doneLoading')
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
