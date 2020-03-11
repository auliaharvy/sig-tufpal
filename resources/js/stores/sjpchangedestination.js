import $axios from '../api.js'

const state = () => ({
    sjpchangedestinations: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    sjpchangedestination: {
        sjp_number: '',
        destination: '',
        new_destination: '',
        adjust_by: '',
        created_at: "",
    },
    page: 1
})

const mutations = {
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.sjpchangedestinations = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.sjpchangedestination = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.sjpchangedestination = {
            sjp_number: '',
            destination: '',
            new_destination: '',
            adjust_by: '',
            created_at: "",
        }
    }
}

const actions = {
    getSjpchangedestination({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/sjpchangedestination?page=${state.page}&q=${search}`)
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