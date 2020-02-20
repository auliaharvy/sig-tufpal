import $axios from '../api.js'

const state = () => ({
    transporters: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    transporter: {
        transporter_name: '',
        transporter_address: '',
        phone_number: '',
        transporter_email: '',
        good_pallet: '',
        tbr_pallet: '',
        ber_pallet: '',
        missing_pallet: '',
        
        
    },
    page: 1
})

const mutations = {
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.transporters = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.transporter = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.transporter = {
            transporter_name: '',
            transporter_address: '',
            phone_number: '',
            transporter_email: '',
            good_pallet: '',
            tbr_pallet: '',
            ber_pallet: '',
            missing_pallet: '',
        }
    }
}

const actions = {
    getTransporters({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/transporter?page=${state.page}&q=${search}`)
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