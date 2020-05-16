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

       <!-- <div class="form-group" :class="{ 'has-error': errors.organization_id }">
            <label for="">Organization</label>
            <input type="text" class="form-control" v-model="pool.organization_id" :readonly="$route.name == 'pools.edit'">
            <p class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</p>
        </div> -->
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Organization</label>
                    <v-autocomplete
                    :items="organizations.data"
                    dense
                    solo
                    v-model="transporter.organization_id"
                    item-text="organization_name"
                    item-value="organization_id"
                    clearable
                    >
                    </v-autocomplete>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.transporter_name }">
                    <label for="">Transporter Name</label>
                    <input type="text" class="form-control" v-model="transporter.transporter_name">
                    <p class="text-danger" v-if="errors.transporter_name">{{ errors.transporter_name[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.transporter_code }">
                    <label for="">Transporter Code</label>
                    <input type="text" class="form-control" v-model="transporter.transporter_code">
                    <p class="text-danger" v-if="errors.transporter_code">{{ errors.transporter_code[0] }}</p>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.pallet_quota }">
                    <label for="">Pallet Quota</label>
                    <input type="text" class="form-control" v-model="transporter.pallet_quota">
                    <p class="text-danger" v-if="errors.pallet_quota">{{ errors.pallet_quota[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                 <div class="form-group" :class="{ 'has-error': errors.transporter_address }">
                    <label for="">Transporter Address</label>
                    <input type="text" class="form-control" v-model="transporter.transporter_address">
                    <p class="text-danger" v-if="errors.transporter_address">{{ errors.transporter_address[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                 <div class="form-group" :class="{ 'has-error': errors.transporter_email }">
                    <label for="">Transporter Email</label>
                    <input type="text" class="form-control" v-model="transporter.transporter_email">
                    <p class="text-danger" v-if="errors.transporter_email">{{ errors.transporter_email[0] }}</p>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.phone_number }">
                    <label for="">Phone Number</label>
                    <input type="text" class="form-control" v-model="transporter.phone_number">
                    <p class="text-danger" v-if="errors.phone_number">{{ errors.phone_number[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    created() {
        this.getOrganization()//LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    name: 'FormPool',
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('transporter', {
            transporter: state => state.transporter //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('transporter', {
            transporters: state => state.transporters //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('organization', {
            organizations: state => state.organizations
        }),
    },
    methods: {
        ...mapMutations('transporter', ['CLEAR_FORM']),
        ...mapActions('transporter', ['getTransporters']),
        ...mapActions('organization', ['getOrganization']),
    },

    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

