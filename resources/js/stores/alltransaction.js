import $axios from '../api.js'

const state = () => ({
    loading: false,
    alltransactions: [], //STATE UNTUK MENAMPUNG DATA CUSTOMERS
    
    //STATE INI UNTUK FORM ADD DAN EDIT NANTINYA
    alltransaction: {
        tid_number: '',
        reference_sjp_id: '',
        reference_sjp_status_id: '',
        reference_pallet_transfer_id: '',
        reference_ber_missing_id: '',
        reference_new_pallet_id: '',
        reference_damaged_pallet_id: '',
        reference_repaired_pallet_id: '',
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
        state.alltransactions = payload
    },
    //MENGUBAH STATE PAGE
    SET_PAGE(state, payload) {
        state.page = payload
    },
    //MENGUBAH STATE CUSTOMER
    ASSIGN_FORM(state, payload) {
        state.alltransaction = payload
    },
    //RESET STATE CUSTOMER
    CLEAR_FORM(state) {
        state.alltransaction = {
        tid_number: '',
        reference_sjp_id: '',
        reference_sjp_status_id: '',
        reference_pallet_transfer_id: '',
        reference_ber_missing_id: '',
        reference_new_pallet_id: '',
        reference_damaged_pallet_id: '',
        reference_repaired_pallet_id: '',
    }
    }
}

const actions = {
    getAlltransaction({ commit, state }, payload) {
        commit('isLoading')
        let search = typeof payload != 'undefined' ? payload:''
        return new Promise((resolve, reject) => {
            //REQUEST DATA CUSTOMER  DENGAN MENGIRIMKAN PARAMETER PAGE YG SEDANG AKTIF DAN VALUE PENCARIAN
            $axios.get(`/alltransaction?page=${state.page}&q=${search}`)
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