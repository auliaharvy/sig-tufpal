import $axios from '../api.js'

const state = () => ({
    loading: false,
    sjpphotos: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS

    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    sjpphoto: {
        sjp_number: '',
        sender: '',
        receiver: '',
        departure_pool: '',
        destination_pool: '',
        sending_driver_approval: '',
        receiving_driver_approval: '' ,
    },
    page: 1,
    fromDate: '',
    toDate: '',
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
        state.sjpphotos = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.sjpphoto = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.sjpphoto = {
            sjp_number: '',
            sender: '',
            receiver: '',
            departure_pool: '',
            destination_pool: '',
            sending_driver_approval: '',
            receiving_driver_approval: '' ,
        }
    }
}

const actions = {
    getSjpPhoto({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/sjpphoto`, {
                params: {
                    fromDate: state.fromDate,
                    toDate: state.toDate
                },
            })
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
