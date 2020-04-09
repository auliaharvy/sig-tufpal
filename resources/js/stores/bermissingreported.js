import $axios from '../api.js'

const state = () => ({
    bermissingpalletreporteds: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    bermissingpalletreported: {
        ber_missing_id: '',
        status: '',
        reporter: '',
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
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.bermissingpalletreporteds = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.bermissingpalletreported = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.bermissingpalletreported = {
            ber_missing_id: '',
            status: '',
            reporter: '',
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
    getBerMissingPalletReported({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/bermissingreported?page=${state.page}&q=${search}`)
            .then((response) => {
                commit('ASSIGN_DATA', response.data) //JIKA DATA DITERIMA, SIMPAN DATA KEDALMA MUTATIONS
                resolve(response.data)
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