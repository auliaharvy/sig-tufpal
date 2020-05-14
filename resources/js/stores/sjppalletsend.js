import $axios from '../api.js'

const state = () => ({
    loading: false,
    sjppalletsends: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    sjppalletsend: {
        sjp_number: '',
        sjp_status: '',
        sender: '',
        departure_pool: '',
        destination_pool: '',
        transporter: "",
        driver: "",
        vehicle: "",
        good_pallet: "",
        tbr_pallet: "",
        ber_pallet: "",
        missing_pallet: "",
        good_cement: "",
        bad_cement: "",
        note: "",
        created_at: "",
        updated_at: "",
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
        state.sjppalletsends = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.sjppalletsend = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.sjppalletsend = {
            sjp_number: '',
            sjp_status: '',
            sender: '',
            departure_pool: '',
            destination_pool: '',
            transporter: "",
            driver: "",
            vehicle: "",
            good_pallet: "",
            tbr_pallet: "",
            ber_pallet: "",
            missing_pallet: "",
            good_cement: "",
            bad_cement: "",
            note: "",
            created_at: "",
            updated_at: "",
        }
    }
}

const actions = {
    getSjpPalletSend({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/sjppalletsend?page=${state.page}&q=${search}`)
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
