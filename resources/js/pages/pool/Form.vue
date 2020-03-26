<template>
    <div>
        <!-- <div class="form-group">
            <label>Select SJP</label>
            <select class='form-control' v-model='sjpstatus.sjp_id'>
                <option value='0' >Select SJP</option>
                <option v-for='data in sjps.data' :value='data.sjp_id'>{{ data.sjp_number }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group">
            <label>Checker Sender:</label>
            <select class='form-control' v-model='sjpstatus.checker_send_user_id'>
                <option value='0' >Select User</option>
                <option v-for='data in users.data' :value='data.id'>{{ data.name }}</option>
            </select>
        </div> -->
        <div class="form-group">
            <label>Organization</label>
            <select class='form-control' v-model='pool.organization_id'>
                <option value='0' >Select Organization</option>
                <option v-for='data in organizations.data' v-bind:key='data.organization_id' :value='data.organization_id'>{{ data.organization_name }}</option>
            </select>
        </div>
        <div class="form-group">
            <label>Pool Type</label>
            <select class='form-control' v-model='pool.type'>
                <option value='WAREHOUSE' >Warehouse</option>
                <option value='SHOP' >Shop</option>
                <option value='STATION' >Station</option>
            </select>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.code }">
            <label for="">Pool Code</label>
            <input type="text" class="form-control" v-model="pool.code">
            <p class="text-danger" v-if="errors.code">{{ errors.code[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.pool_name }">
            <label for="">Pool Name</label>
            <input type="text" class="form-control" v-model="pool.pool_name">
            <p class="text-danger" v-if="errors.pool_name">{{ errors.pool_name[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.pool_address }">
            <label for="">Pool Address</label>
            <input type="text" class="form-control" v-model="pool.pool_address">
            <p class="text-danger" v-if="errors.pool_address">{{ errors.pool_address[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.pool_city }">
            <label for="">Pool City</label>
            <input type="text" class="form-control" v-model="pool.pool_city">
            <p class="text-danger" v-if="errors.pool_city">{{ errors.pool_city[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.phone_number }">
            <label for="">Phone Number</label>
            <input type="text" class="form-control" v-model="pool.phone_number">
            <p class="text-danger" v-if="errors.phone_number">{{ errors.phone_number[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.pool_email }">
            <label for="">Pool Email</label>
            <input type="text" class="form-control" v-model="pool.pool_email">
            <p class="text-danger" v-if="errors.pool_email">{{ errors.pool_email[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.pallet_quota }">
            <label for="">Pallet Quota</label>
            <input type="text" class="form-control" v-model="pool.pallet_quota">
            <p class="text-danger" v-if="errors.pallet_quota">{{ errors.pallet_quota[0] }}</p>
        </div>
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormPool',
    created() {
        this.getOrganization()//LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('pool', {
            pool: state => state.pool //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pool', {
            pools: state => state.pools //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('organization', {
            organizations: state => state.organizations
        }),
    },
    methods: {
        ...mapMutations('pool', ['CLEAR_FORM']), 
        ...mapActions('pool', ['getPools']),
        ...mapActions('organization', ['getOrganization']),
    },
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

