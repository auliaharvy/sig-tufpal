<template>
    <div>
        <!-- <div class="form-group">
            <label>Departure Pool Pallet</label>
            <select class='form-control' v-model='pallettransfer.departure_pool_pallet_id'>
   s             <option value='0' >Select Departure</option>
                <option v-for='data in pools.data' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
            </select>
        </div> -->
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Destination Pool Pallet</label>
                    <v-autocomplete
                    :items="pools.data"
                    dense
                    solo
                    v-model="pallettransfer.destination_pool_pallet_id"
                    item-text="pool_name"
                    item-value="pool_pallet_id"
                    clearable
                    >
                    </v-autocomplete>
                    <!-- <select class='form-control' v-model='pallettransfer.destination_pool_pallet_id'>
                        <option value='0' >Select Destination</option>
                        <option v-for='data in pools.data' v-bind:key='data.destination_pool_pallet_id' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
                    </select> -->
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Vehicle Number</label>
                    <v-autocomplete
                    :items="vehicles.data"
                    dense
                    solo
                    v-model="pallettransfer.vehicle_id"
                    item-text="vehicle_number"
                    item-value="vehicle_id"
                    clearable
                    >
                    </v-autocomplete>
                    <!-- <select class='form-control' v-model='pallettransfer.vehicle_id'>
                        <option value='0' >Select Vehicle</option>
                        <option v-for='data in vehicles.data' v-bind:key='data.vehicle_id' :value='data.vehicle_id'>{{ data.vehicle_number }}</option>
                    </select> -->
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Driver Name</label>
                    <v-autocomplete
                    :items="drivers.data"
                    dense
                    solo
                    v-model="pallettransfer.driver_id"
                    item-text="driver_name"
                    item-value="driver_id"
                    clearable
                    >
                    </v-autocomplete>
                    <!-- <select class='form-control' v-model='pallettransfer.driver_id'>
                        <option value='0' >Select Driver</option>
                        <option v-for='data in drivers.data' v-bind:key='data.driver_id' :value='data.driver_id'>{{ data.driver_name }}</option>
                    </select> -->
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Transporter Name</label>
                    <v-autocomplete
                    :items="transporters.data"
                    dense
                    solo
                    v-model="pallettransfer.transporter_id"
                    item-text="transporter_name"
                    item-value="transporter_id"
                    clearable
                    >
                    </v-autocomplete>
                    <!-- <select class='form-control' v-model='pallettransfer.transporter_id'>
                        <option value='0' >Select Transporter</option>
                        <option v-for='data in transporters.data' v-bind:key='data.transporter_id' :value='data.transporter_id'>{{ data.transporter_name }}</option>
                    </select> -->
                </div>
            </v-flex>
        </v-layout>
       <!-- <div class="form-group" :class="{ 'has-error': errors.sender_user_id }">
            <label for="">Checker Sender</label>
            <input type="text" class="form-control" v-model="pallettransfer.sender_user_id" :readonly="$route.name == 'pallettransfers.edit'">
            <p class="text-danger" v-if="errors.sender_user_id">{{ errors.sender_user_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Checker Sender</label>
            <select class='form-control' v-model='pallettransfer.sender_user_id' :readonly="$route.name == 'pallettransfers.edit'">
                <option v-for='data in authenticated' :value='authenticated.id'>{{ authenticated.name }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.receiver_user_id }">
            <label for="">Checker Receiver</label>
            <input type="text" class="form-control" v-model="pallettransfer.receiver_user_id">
            <p class="text-danger" v-if="errors.receiver_user_id">{{ errors.receiver_user_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Checker Receiver</label>
            <select class='form-control' v-model='pallettransfer.receiver_user_id' :readonly="$route.name == 'pallettransfers.add'">
                <option v-for='data in authenticated' :value='authenticated.id'>{{ authenticated.name }}</option>
            </select>
        </div> -->
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.good_pallet }">
                    <label for="">Good Pallet</label>
                    <input type="text" class="form-control" v-model="pallettransfer.good_pallet">
                    <p class="text-danger" v-if="errors.good_pallet">{{ errors.good_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }">
                    <label for="">Tbr Pallet</label>
                    <input type="text" class="form-control" v-model="pallettransfer.tbr_pallet">
                    <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.reason }">
                    <label for="">Reason</label>
                    <input type="text" class="form-control" v-model="pallettransfer.reason">
                    <p class="text-danger" v-if="errors.reason">{{ errors.reason[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.note }">
                    <label for="">Note</label>
                    <input type="text" class="form-control" v-model="pallettransfer.note">
                    <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormSjpStatus',
    created() {
        this.getVehicleForm(), //LOAD DATA VEHICLES KETIKA COMPONENT DI-LOAD
        this.getPoolForm(), //LOAD DATA POOLS KETIKA COMPONENT DI-LOAD
        this.getDriverForm(), //LOAD DATA DRIVERS KETIKA COMPONENT DI-LOAD
        this.getTransporters(), //LOAD DATA TRANSPORTER KETIKA COMPONENT DI-LOAD
        this.getUserLogin() //LOAD DATA USER LOGIN KETIKA COMPONENT DI-LOAD
    },

    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('pallettransfer', {
            pallettransfer: state => state.pallettransfer //LOAD DATA CUSTOMER DARI STATE CUSTOMER
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
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
    },
    methods: {
        ...mapMutations('pallettransfer', ['CLEAR_FORM']),
        ...mapActions('pool', ['getPoolForm']),
        ...mapActions('vehicle', ['getVehicleForm']),
        ...mapActions('driver', ['getDriverForm']),
        ...mapActions('transporter', ['getTransporters']),
        ...mapActions('user', ['getUserLogin']),

    },

    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

