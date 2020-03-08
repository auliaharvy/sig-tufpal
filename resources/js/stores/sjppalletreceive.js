import $axios from '../api.js'

const state = () => ({
    sjppalletreceives: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    sjppalletreceive: {
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
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.sjppalletreceives = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.sjppalletreceive = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.sjppalletreceive = {
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
    getSjpPalletReceive({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/sjppalletreceive?page=${state.page}&q=${search}`)
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