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
                    v-model="vehicle.transporter_id"
                    item-text="transporter_name"
                    item-value="transporter_id"
                    clearable
                    >
                    </v-autocomplete>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.vehicle_number }">
                    <label for="">Vehicle Number</label>
                    <input type="text" class="form-control" v-model="vehicle.vehicle_number">
                    <p class="text-danger" v-if="errors.vehicle_number">{{ errors.vehicle_number[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.vehicle_type }">
                    <label for="">Vehicle Type</label>
                    <input type="text" class="form-control" v-model="vehicle.vehicle_type">
                    <p class="text-danger" v-if="errors.vehicle_type">{{ errors.vehicle_type[0] }}</p>
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
        this.getTransporterForm()
    },
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
         ...mapState('transporter', {
            transporters: state => state.transporters
        }),
         ...mapState('vehicle', {
            vehicle: state => state.vehicle
        }),
    },
    methods: {
        ...mapMutations('vehicle', ['CLEAR_FORM']),
        ...mapActions('vehicle', ['getVehciles']),
        ...mapActions('transporter', ['getTransporterForm']),
    },
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

