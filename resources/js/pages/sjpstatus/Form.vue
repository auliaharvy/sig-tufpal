<template>
    <div>
        <!-- <div class="form-group">
            <label>SJP Number</label>
            <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.sjp_number }}</option>
            </select>
        </div> -->
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group">
                    <label>SJP Number</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.sjp_number }}</option>
                    </select>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>From</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.dept_pool }}</option>
                    </select>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Send To</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.dest_pool }}</option>
                    </select>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Driver</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.driver_name }}</option>
                    </select>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Vehicle Number</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.vehicle_number }}</option>
                    </select>
                </div>
            </v-flex>
        </v-layout>
        
        <!-- <div class="form-group" :class="{ 'has-error': errors.packaging }">
            <label for="">Transaction</label>
            <input type="text" class="form-control" v-model="sjpstatus.transaction_id">
            <p class="text-danger" v-if="errors.transaction_id">{{ errors.transaction_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Select Transaction Type</label>
            <select class='form-control' v-model='sjpstatus.transaction_id' :readonly="$route.name == 'sjpstatuss.edit'">
                <option v-for='data in msttransactions.data' v-bind:key='data.id' :value='data.id'>{{ data.transaction }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group">
            <label>Checker Sender:</label>
            <select class='form-control' v-model='sjpstatus.checker_send_user_id'>
                <option value='0' >Select User</option>
                <option v-for='data in users.data' :value='data.id'>{{ data.name }}</option>
            </select>
        </div> -->   
        <!-- <div class="form-group" :class="{ 'has-error': errors.created_by }">
            <label for="">Created By</label>
            <p>{{ authenticated.name }}</p>
        </div>
       -->
         <!-- <div class="form-group" :class="{ 'has-error': errors.checker_receive_user_id }" >
            <label for="">Checker Receive</label>
            <input type="text" class="form-control" v-model="sjpstatus.checker_receive_user_id" :readonly="$route.name == 'sjpstatuss.add'">
            <p class="text-danger" v-if="errors.checker_receive_user_id">{{ errors.checker_receive_user_id[0] }}</p>
        </div>  -->
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.good_pallet }">
                    <label for="">Good Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.good_pallet">
                    <p class="text-danger" v-if="errors.good_pallet">{{ errors.good_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md3 lg3>  
                <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }" :readonly="true">
                    <label for="">Tbr Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.tbr_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md3 lg3>  
                <div class="form-group" :class="{ 'has-error': errors.ber_pallet }" :readonly="true">
                    <label for="">Ber Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.ber_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.ber_pallet">{{ errors.ber_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md3 lg3>  
                <div class="form-group" :class="{ 'has-error': errors.missing_pallet }" :readonly="true">
                    <label for="">Missing Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.missing_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.missing_pallet">{{ errors.missing_pallet[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <!-- <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }">
            <label for="">Tbr Pallet</label>
            <input type="text" class="form-control" v-model="sjpstatus.tbr_pallet">
            <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.ber_pallet }">
            <label for="">Ber Pallet</label>
            <input type="text" class="form-control" v-model="sjpstatus.ber_pallet">
            <p class="text-danger" v-if="errors.ber_pallet">{{ errors.ber_pallet[0] }}</p>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.missing_pallet }">
            <label for="">Missing Pallet</label>
            <input type="text" class="form-control" v-model="sjpstatus.missing_pallet">
            <p class="text-danger" v-if="errors.missing_pallet">{{ errors.missing_pallet[0] }}</p>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.good_cement }">
            <label for="">Good Cement</label>
            <input type="text" class="form-control" v-model="sjpstatus.good_cement">
            <p class="text-danger" v-if="errors.good_cement">{{ errors.good_cement[0] }}</p>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.bad_cement }">
            <label for="">Bad Cement</label>
            <input type="text" class="form-control" v-model="sjpstatus.bad_cement">
            <p class="text-danger" v-if="errors.bad_cement">{{ errors.bad_cement[0] }}</p>
        </div> -->
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.note }">
                    <label for="">Note</label>
                    <input type="text" class="form-control" v-model="sjpstatus.note">
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
        this.getSjp(), 
        this.getMstTransaction(), 
        this.getUserLogin() //LOAD DATA
    },
   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('sjpstatus', {
            sjpstatus: state => state.sjpstatus //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjp', {
            sjps: state => state.sjps //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('msttransaction', {
            msttransactions: state => state.msttransactions
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
    },
    methods: {
        ...mapMutations('sjpstatus', ['CLEAR_FORM']), 
        ...mapActions('sjp', ['getSjp']),
        ...mapActions('msttransaction', ['getMstTransaction']),
        ...mapActions('user', ['getUserLogin']),
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

