import $axios from '../api.js'

const state = () => ({
    loading: false,
    bermissingpalletapproveds: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    bermissingpalletapproved: {
        bmp_number: '',
        status: '',
        approver: '',
        pool_pallet: '',
        transporter: "",
        reference_sjp_status: "",
        ber_pallet: "",
        missing_pallet: "",
        reporter_prove: "",
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
        state.bermissingpalletapproveds = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.bermissingpalletapproved = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.bermissingpalletapproved = {
            bmp_number: '',
            status: '',
            approver: '',
            pool_pallet: '',
            transporter: "",
            reference_sjp_status: "",
            ber_pallet: "",
            missing_pallet: "",
            reporter_prove: "",
            note: "",
            created_at: "",
            updated_at: "",
        }
    }
}

const actions = {
    getBerMissingPalletApproved({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/bermissingapproved?page=${state.page}&q=${search}`)
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
