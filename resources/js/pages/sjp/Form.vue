<template>
    <div>
       <!-- <div class="form-group" :class="{ 'has-error': errors.sjp_id }">
            <label for="">ID</label>
            <input type="text" class="form-control" v-model="sjp.sjp_id" :readonly="$route.name == 'sjps.edit'">
            <p class="text-danger" v-if="errors.sjp_id">{{ errors.sjp_id[0] }}</p>
        </div> -->
        
        <!-- <div class="form-group" :class="{ 'has-error': errors.departure_pool_pallet_id }">
            <label for="">Departure</label>
            <input type="text" class="form-control" v-model="sjp.departure_pool_pallet_id">
            <p class="text-danger" v-if="errors.departure_pool_pallet_id">{{ errors.departure_pool_pallet_id[0] }}</p>
        </div> -->
        <div class="form-group">
                            <label>Departure Pool Pallet</label>
                            <select class='form-control' v-model='sjp.departure_pool_pallet_id'>
                              <option value='0' >Select Departure</option>
                              <option v-for='data in pools.data' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
                            </select>
                        </div>
         <div class="form-group">
                            <label>Destination Pool Pallet</label>
                            <select class='form-control' v-model='sjp.destination_pool_pallet_id'>
                              <option value='0' >Select Destination</option>
                              <option v-for='data in pools.data' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
                            </select>
                        </div>
        <div class="form-group">
                            <label>Vehicle Number</label>
                            <select class='form-control' v-model='sjp.vehicle_id'>
                              <option value='0' >Select Vehicle</option>
                              <option v-for='data in vehicles.data' :value='data.vehicle_id'>{{ data.vehicle_number }}</option>
                            </select>
                        </div>
       
        <div class="form-group">
                            <label>Driver Name</label>
                            <select class='form-control' v-model='sjp.driver_id'>
                              <option value='0' >Select Driver</option>
                              <option v-for='data in drivers.data' :value='data.driver_id'>{{ data.driver_name }}</option>
                            </select>
                        </div>
        <div class="form-group">
            <label>Transporter Name</label>
            <select class='form-control' v-model='sjp.transporter_id'>
                <option value='0' >Select Transporter</option>
                <option v-for='data in transporters.data' :value='data.transporter_id'>{{ data.transporter_name }}</option>
            </select>
        </div>               
        <!-- <div class="form-group" :class="{ 'has-error': errors.transporter_id }">
            <label for="">Transporter</label>
            <input type="text" class="form-control" v-model="sjp.transporter_id">
            <p class="text-danger" v-if="errors.transporter_id">{{ errors.transporter_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.sjp_number }">
            <label for="">SJP No</label>
            <input type="text" class="form-control" v-model="sjp.sjp_number">
            <p class="text-danger" v-if="errors.sjp_number">{{ errors.sjp_number[0] }}</p>
        </div> -->
        <div class="form-group" :class="{ 'has-error': errors.no_do }">
            <label for="">DO Number</label>
            <input type="text" class="form-control" v-model="sjp.no_do">
            <p class="text-danger" v-if="errors.no_do">{{ errors.no_do[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.product_name }">
            <label for="">Product Name</label>
            <input type="text" class="form-control" v-model="sjp.product_name">
            <p class="text-danger" v-if="errors.product_name">{{ errors.product_name[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.packaging }">
            <label for="">Packaging (KG/Pack)</label>
            <input type="text" class="form-control" v-model="sjp.packaging">
            <p class="text-danger" v-if="errors.packaging">{{ errors.packaging[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.product_quantity }">
            <label for="">Product Quantity (/pack)</label>
            <input type="text" class="form-control" v-model="sjp.product_quantity">
            <p class="text-danger" v-if="errors.product_quantity">{{ errors.product_quantity[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.departure_time }">
            <label for="">Departure Time</label>
            <input type="date" class="form-control" v-model="sjp.departure_time">
            <p class="text-danger" v-if="errors.departure_time">{{ errors.departure_time[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.eta }">
            <label for="">Estimated Time Arrival</label>
            <input type="date" class="form-control" v-model="sjp.eta">
            <p class="text-danger" v-if="errors.eta">{{ errors.eta[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.pallet_quantity }">
            <label for="">Pallet Quantity</label>
            <input type="text" class="form-control" v-model="sjp.pallet_quantity">
            <p class="text-danger" v-if="errors.pallet_quantity">{{ errors.pallet_quantity[0] }}</p>
        </div>
    </div>
</template>

<script>
import { mapState, mapActions, mapMutations } from 'vuex'
export default {
    name: 'FormSjp',
    created() {
        this.getVehicles(),this.getPools(),this.getDrivers(),this.getTransporters() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    // created() {
    //     this.getPools() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    // },
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('sjp', {
            sjp: state => state.sjp //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pool', {
            pools: state => state.pools //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('vehicle', {
            vehicles: state => state.vehicles //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('driver', {
            drivers: state => state.drivers //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
         ...mapState('transporter', {
            transporters: state => state.transporters //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
    },
    methods: {
        ...mapMutations('sjp', ['CLEAR_FORM']), 
        ...mapActions('pool', ['getPools']),
        ...mapActions('vehicle', ['getVehicles']),
        ...mapActions('driver', ['getDrivers']),
        ...mapActions('transporter', ['getTransporters']),
    },
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>