import Vue from 'vue'
import Router from 'vue-router'
import Home from './pages/Home.vue'
import Login from './pages/Login.vue'
import store from './store.js'

import IndexSjp from './pages/sjp/index.vue'
import DataSjp from './pages/sjp/sjp.vue'
import AddSjp from './pages/sjp/Add.vue'
import EditSjp from './pages/sjp/Edit.vue'

import IndexSjpStatus from './pages/sjpstatus/Index.vue'
import DataSjpStatus from './pages/sjpstatus/SjpStatus.vue'
import AddSjpStatus from './pages/sjpstatus/AddSjpStatus.vue'
import EditSjpStatus from './pages/sjpstatus/EditSjpStatus.vue'

import IndexPool from './pages/pool/Index.vue'
import DataPool from './pages/pool/Pool.vue'
import AddPool from './pages/pool/AddPool.vue'
import EditPool from './pages/pool/EditPool.vue'

import IndexPalletTransfer from './pages/pallettransfer/Index.vue'
import DataPalletTransfer from './pages/pallettransfer/PalletTransfer.vue'
import AddPalletTransfer from './pages/pallettransfer/AddPalletTransfer.vue'
import EditPalletTransfer from './pages/pallettransfer/EditPalletTransfer.vue'

import IndexOutlet from './pages/outlets/Index.vue'
import DataOutlet from './pages/outlets/Outlet.vue'
import AddOutlet from './pages/outlets/Add.vue'
import EditOutlet from './pages/outlets/Edit.vue'

import IndexCourier from './pages/couriers/Index.vue'
import DataCouriers from './pages/couriers/Courier.vue'
import AddCouriers from './pages/couriers/Add.vue'
import EditCouriers from './pages/couriers/Edit.vue'

import IndexProduct from './pages/products/Index.vue'
import DataProduct from './pages/products/Product.vue'
import AddProduct from './pages/products/Add.vue'
import EditProduct from './pages/products/Edit.vue'

import Setting from './pages/setting/Index.vue'
import SetPermission from './pages/setting/roles/SetPermission.vue'

import IndexExpenses from './pages/expenses/Index.vue'
import DataExpenses from './pages/expenses/Expenses.vue'
import CreateExpenses from './pages/expenses/Add.vue'
import EditExpenses from './pages/expenses/Edit.vue'
import ViewExpenses from './pages/expenses/View.vue'

import IndexCustomer from './pages/customers/Index.vue'
import DataCustomer from './pages/customers/Customer.vue'
import AddCustomer from './pages/customers/Add.vue'
import EditCustomer from './pages/customers/Edit.vue'

import IndexTransaction from './pages/transaction/Index.vue'
import AddTransaction from './pages/transaction/Add.vue'
import ViewTransaction from './pages/transaction/View.vue'
import ListTransaction from './pages/transaction/List.vue'

Vue.use(Router)

const router = new Router({
    mode: 'history',
    routes: [
        {
            path: '/sjp',
            component: IndexSjp,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'sjps.data',
                    component: DataSjp,
                    meta: { title: 'Manage SJP' }
                },
                {
                    path: 'add',
                    name: 'sjps.add',
                    component: AddSjp,
                    meta: { title: 'Add New SJP' }
                },
                {
                    path: 'edit/:id',
                    name: 'sjps.edit',
                    component: EditSjp,
                    meta: { title: 'Edit Sjp' }
                },
                
            ]
        },
       
        {
            path: '/sjpstatus',
            component: IndexSjpStatus,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'sjpstatuss.data',
                    component: DataSjpStatus,
                    meta: { title: 'Manage Sjp Status' }
                },
                {
                    path: 'add',
                    name: 'sjpstatuss.add',
                    component: AddSjpStatus,
                    meta: { title: 'Add Sjp Status' }
                },
                {
                    path: 'edit/:id',
                    name: 'sjpstatuss.edit',
                    component: EditSjpStatus,
                    meta: { title: 'Edit Sjp' }
                },
            ]
        },

        {
            path: '/poolpallet',
            component: IndexPool,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'pools.data',
                    component: DataPool,
                    meta: { title: 'Manage Pool Pallet' }
                },
                {
                    path: 'add',
                    name: 'pools.add',
                    component: AddPool,
                    meta: { title: 'Add Pool Pallet' }
                },
                {
                    path: 'edit/:id',
                    name: 'pools.edit',
                    component: EditPool,
                    meta: { title: 'Edit Pool' }
                },
            ]
        },

        {
            path: '/pallettransfer',
            component: IndexPalletTransfer,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'pallettransfers.data',
                    component: DataPalletTransfer,
                    meta: { title: 'Manage Pallet Transfer' }
                },
                {
                    path: 'add',
                    name: 'pallettransfers.add',
                    component: AddPalletTransfer,
                    meta: { title: 'Add Pallet Transfer' }
                },
                {
                    path: 'edit/:id',
                    name: 'pallettransfers.edit',
                    component: EditPalletTransfer,
                    meta: { title: 'Edit Pallet Transfer' }
                },
            ]
        },


        {
            path: '/',
            name: 'home',
            component: Home,
            meta: { requiresAuth: true }
        },
        {
            path: '/login',
            name: 'login',
            component: Login
        },
        {
            path: '/outlets',
            component: IndexOutlet,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'outlets.data',
                    component: DataOutlet,
                    meta: { title: 'Manage Outlets' }
                },
                {
                    path: 'add',
                    name: 'outlets.add',
                    component: AddOutlet,
                    meta: { title: 'Add New Outlet' }
                },
                {
                    path: 'edit/:id',
                    name: 'outlets.edit',
                    component: EditOutlet,
                    meta: { title: 'Edit Outlet' }
                }
            ]
        }, 
        {
            path: '/couriers',
            component: IndexCourier,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'couriers.data',
                    component: DataCouriers,
                    meta: { title: 'Manage Couriers' }
                },
                {
                    path: 'add',
                    name: 'couriers.add',
                    component: AddCouriers,
                    meta: { title: 'Add New Couriers' }
                },
                {
                    path: 'edit/:id',
                    name: 'couriers.edit',
                    component: EditCouriers,
                    meta: { title: 'Edit Courier' }
                },
            ]
        },
        {
            path: '/product',
            component: IndexProduct,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'products.data',
                    component: DataProduct,
                    meta: { title: 'Manage Products' }
                },
                {
                    path: 'add',
                    name: 'products.add',
                    component: AddProduct,
                    meta: { title: 'Add New Product' }
                },
                {
                    path: 'edit/:id',
                    name: 'products.edit',
                    component: EditProduct,
                    meta: { title: 'Edit Product' }
                },
            ]
        },
        {
            path: '/setting',
            component: Setting,
            meta: { requiresAuth: true },
            children: [
                {
                    path: 'role-permission',
                    name: 'role.permissions',
                    component: SetPermission,
                    meta: { title: 'Set Permissions' }
                },
            ]
        },
        {
            path: '/expenses',
            component: IndexExpenses,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'expenses.data',
                    component: DataExpenses,
                    meta: { title: 'Manage Expenses' }
                },
                {
                    path: 'add',
                    name: 'expenses.create',
                    component: CreateExpenses,
                    meta: { title: 'Add New Expenses' }
                },
                {
                    path: 'edit/:id',
                    name: 'expenses.edit',
                    component: EditExpenses,
                    meta: { title: 'Edit Expenses' }
                },
                {
                    path: 'view/:id',
                    name: 'expenses.view',
                    component: ViewExpenses,
                    meta: { title: 'View Expenses' }
                },
            ]
        },
        {
            path: '/customers',
            component: IndexCustomer,
            meta: { requiresAuth: true },
            children: [
                {
                    path: '',
                    name: 'customers.data',
                    component: DataCustomer,
                    meta: { title: 'Manage Customers' }
                },
                {
                    path: 'add',
                    name: 'customers.add',
                    component: AddCustomer,
                    meta: { title: 'Add New Customers' }
                },
                {
                    path: 'edit/:id',
                    name: 'customers.edit',
                    component: EditCustomer,
                    meta: { title: 'Edit Customer' }
                },
            ]
        },
        {
            path: '/transactions',
            component: IndexTransaction,
            meta: { requiresAuth: true },
            children: [
                {
                    path: 'create',
                    name: 'transactions.add',
                    component: AddTransaction,
                    meta: { title: 'Create New Transaction' }
                },
                {
                    path: 'view/:id',
                    name: 'transactions.view',
                    component: ViewTransaction,
                    meta: { title: 'View Transaction' }
                },
                {
                    path: 'list',
                    name: 'transactions.list',
                    component: ListTransaction,
                    meta: { title: 'List Transaction' }
                },
            ]
        }
    ]
});

router.beforeEach((to, from, next) => {
    store.commit('CLEAR_ERRORS')
    if (to.matched.some(record => record.meta.requiresAuth)) {
        let auth = store.getters.isAuth
        if (!auth) {
            next({ name: 'login' })
        } else {
            next()
        }
    } else {
        next()
    }
})

export default router
