import $axios from '../api.js'

const state = () => ({
    loading: false,
    palletmovements: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    palletmovement: {
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
    isLoading (state) {
        state.loading = true
      },
      doneLoading (state) {
        state.loading = false
      },
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.palletmovements = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.palletmovement = payload
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
    getPalletMovements({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/palletmovement?page=${state.page}&q=${search}`)
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
