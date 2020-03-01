import Vue from 'vue'
import Vuex from 'vuex'

import auth from './stores/auth.js'
import outlet from './stores/outlet.js'
import courier from './stores/courier.js'
import product from './stores/product.js'
import user from './stores/user.js'
import expenses from './stores/expenses.js'
import notification from './stores/notification.js'
import customer from './stores/customer.js'
import transaction from './stores/transaction.js'
import dashboard from './stores/dashboard.js'
import sjp from './stores/sjp.js'
import sjpstatus from './stores/sjpstatus.js'
import pool from './stores/pool.js'
import vehicle from './stores/vehicle.js'
import driver from './stores/driver.js'
import transporter from './stores/transporter.js'
import msttransaction from './stores/msttransaction.js'
import organization from './stores/organization.js'
import pallettransfer from './stores/pallettransfer.js'
import bermissing from './stores/Bermissing.js'
import newpallet from './stores/Newpallet.js'
import palletmovement from './stores/palletmovement.js'
Vue.use(Vuex)

const store = new Vuex.Store({
    modules: {
        auth,
        outlet,
        courier,
        product,
        user,   
        expenses,
        notification,
        customer,
        transaction,
        dashboard,
        sjp,
        sjpstatus,
        pool,
        vehicle,
        driver,
        transporter,
        msttransaction,
        organization,
        pallettransfer,
        bermissing,
        newpallet,
        palletmovement
    },
    state: {
        token: localStorage.getItem('token'),
        errors: []
    },
    getters: {
        isAuth: state => {
            return state.token != "null" && state.token != null
        }
    },
    mutations: {
        SET_TOKEN(state, payload) {
            state.token = payload
        },
        SET_ERRORS(state, payload) {
            state.errors = payload
        },
        CLEAR_ERRORS(state) {
            state.errors = []
        }
    }
})

export default store