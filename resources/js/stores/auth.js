import $axios from '../api.js'

const state = () => ({
    loading: false,

})

const mutations = {
    isLoading (state) {
        state.loading = true
      },
      doneLoading (state) {
        state.loading = false
      },
    
}

const actions = {
    submit({ commit }, payload) {
        localStorage.setItem('token', null)
        commit('isLoading')
        commit('SET_TOKEN', null, { root: true })
        return new Promise((resolve, reject) => {
            $axios.post('/login', payload)
            .then((response) => {
                if (response.data.status == 'success') {
                    localStorage.setItem('token', response.data.data)
                    commit('SET_TOKEN', response.data.data, { root: true })
                } else {
                    commit('SET_ERRORS', { invalid: 'Wrong Email/Password' }, { root: true })
                }
                resolve(response.data)
            })
            .catch((error) => {
                if (error.response.status == 422) {
                    commit('SET_ERRORS', error.response.data.errors, { root: true })
                }
            })
            .finally(() => {
                commit('doneLoading')
            })
        })
    }
}

export default {
    namespaced: true,
    state,
    actions,
    mutations
}