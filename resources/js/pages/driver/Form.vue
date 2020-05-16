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
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Transporter</label>
                    <v-autocomplete
                    :items="transporters.data"
                    dense
                    solo
                    v-model="driver.transporter_id"
                    item-text="transporter_name"
                    item-value="transporter_id"
                    clearable
                    >
                    </v-autocomplete>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.driver_name }">
                    <label for="">Driver Name</label>
                    <input type="text" class="form-control" v-model="driver.driver_name">
                    <p class="text-danger" v-if="errors.driver_name">{{ errors.driver_name[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.driver_address }">
                    <label for="">Driver Address</label>
                    <input type="text" class="form-control" v-model="driver.driver_address">
                    <p class="text-danger" v-if="errors.driver_address">{{ errors.driver_address[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.driver_id }">
                    <label for="">Driver ID</label>
                    <input type="text" class="form-control" v-model="driver.driver_id">
                    <p class="text-danger" v-if="errors.driver_id">{{ errors.driver_id[0] }}</p>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.mobile_number }">
                    <label for="">Mobile Number</label>
                    <input type="text" class="form-control" v-model="driver.mobile_number">
                    <p class="text-danger" v-if="errors.mobile_number">{{ errors.mobile_number[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.email }">
                    <label for="">Driver Email</label>
                    <input type="text" class="form-control" v-model="driver.email">
                    <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormVehicles',
    created() {
        this.getTransporters()
    },
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
         ...mapState('transporter', {
            transporters: state => state.transporters
        }),
         ...mapState('driver', {
            driver: state => state.driver
        }),
    },
    methods: {
        ...mapMutations('driver', ['CLEAR_FORM']),
        ...mapActions('driver', ['getDrivers']),
        ...mapActions('transporter', ['getTransporters']),
    },
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

