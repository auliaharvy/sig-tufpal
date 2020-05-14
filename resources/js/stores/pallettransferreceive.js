import $axios from '../api.js'

const state = () => ({
    loading: false,
    pallettransferreceives: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    pallettransferreceive: {
        tp_number: '',
        pallet_transfer_status: '',
        sender: '',
        departure_pool: '',
        destination_pool: '',
        transporter: "",
        driver: "",
        vehicle: "",
        good_pallet: "",
        tbr_pallet: "",
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
        state.pallettransferreceives = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.pallettransferreceive = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.pallettransferreceive = {
            tp_number: '',
            pallet_transfer_status: '',
            sender: '',
            departure_pool: '',
            destination_pool: '',
            transporter: "",
            driver: "",
            vehicle: "",
            good_pallet: "",
            tbr_pallet: "",
            note: "",
            created_at: "",
            updated_at: "",
        }
    }
}

const actions = {
    getTransferPalletReceive({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/pallettransferreceive?page=${state.page}&q=${search}`)
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
