import $axios from '../api.js'

const state = () => ({
    vehicles: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    vehicle: {
        vehicle_name: '',
        vehicle_type: '',
        
    },
    page: 1
})

const mutations = {
    //MUTATIONS UNTUK ASSIGN DATA CUSTOMER KE DALAM STATE CUSTOMER
    ASSIGN_DATA(state, payload) {
        state.vehicles = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.vehicle = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.vehicle = {
            vehicle_name: '',
            vehicle_type: '',
        }
    }
}

const actions = {
    getVehicles({ commit, state }, payload) {
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/vehicle?page=${state.page}&q=${search}`)
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