import $axios from '../api.js'

const state = () => ({
    bermissingpalletdisapproveds: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    bermissingpalletdisapproved: {
        bmp_number: '',
        status: '',
        disapprover: '',
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
        state.bermissingpalletdisapproveds = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.bermissingpalletdisapproved = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.bermissingpalletdisapproved = {
            bmp_number: '',
            status: '',
            disapprover: '',
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
    getBerMissingPalletDisapproved({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/bermissingdisapproved?page=${state.page}&q=${search}`)
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