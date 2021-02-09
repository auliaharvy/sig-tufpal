<template>
    <div>
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
                    <label>Transporter</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.transporter_name }}</option>
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

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.good_pallet }">
                    <label for="">Good Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.good_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.good_pallet">{{ errors.good_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }">
                    <label for="">TBR Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.tbr_pallet" :readonly="true" >
                    <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.ber_pallet }">
                    <label for="">BER Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.ber_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.ber_pallet">{{ errors.ber_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.missing_pallet }">
                    <label for="">Missing Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.missing_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.missing_pallet">{{ errors.missing_pallet[0] }}</p>
                </div>
            </v-flex>
        </v-layout> 

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.reason }">
                    <label for="">Reason</label>
                    <input type="text" class="form-control" v-model="sjpstatus.reason" >
                    <p class="text-danger" v-if="errors.reason">{{ errors.reason[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.note }">
                    <label for="">Note</label>
                    <input type="text" class="form-control" v-model="sjpstatus.note" >
                    <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
                </div>
            </v-flex>
        </v-layout>   
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormSjpStatusCancel',
    created() {
        this.getSjp(), 
        this.getMstTransaction(), 
        this.getUserLogin() //LOAD DATA
    },
    computed: {
        ...mapState(['errors']),
        ...mapState('sjp', {
            sjps: state => state.sjps,
            sjp: state => state.sjp
        }),
        ...mapState('sjpstatus', {
            sjpstatus: state => state.sjpstatus,
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
        ...mapActions('sjp', ['getSjp' , 'editSjp']),
        ...mapActions('sjpstatus', ['editSjpStatus','canceljSpStatus']),
        ...mapActions('msttransaction', ['getMstTransaction']),
        ...mapActions('user', ['getUserLogin']),
        ...mapActions('sjpstatus', ['getSjpStatus']),
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

