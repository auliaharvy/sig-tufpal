<template>
    <div>
        <div class="form-group">
            <label>Pool Pallet</label>
            <v-autocomplete
            :items="pools.data"
            dense
            solo
            v-model="transporterAdjusment.pool_pallet_id"
            item-text="pool_name"
            item-value="pool_pallet_id"
            clearable
            >
            </v-autocomplete>
        </div>
        <div class="form-group">
            <label>Transporter</label>
            <v-autocomplete
            :items="transporters.data"
            dense
            solo
            v-model="transporterAdjusment.transporter_id"
            item-text="transporter_name"
            item-value="transporter_id"
            clearable
            >
            </v-autocomplete>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.good_pallet }">
            <label for="">Good Pallet</label>
            <input type="text" class="form-control" v-model="transporterAdjusment.good_pallet">
            <p class="text-danger" v-if="errors.good_pallet">{{ errors.good_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }">
            <label for="">TBR Pallet</label>
            <input type="text" class="form-control" v-model="transporterAdjusment.tbr_pallet">
            <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.is_from_pool }">
            <label>Adjusment Type</label>
            <select class='form-control' v-model='transporterAdjusment.is_from_pool'>
                <option value='0' >Adjustment From Pool Pallet to Transporter</option>
                <option value='1' >Adjustment From Transporter to Pool Pallet</option>
            </select>
            <p class="text-danger" v-if="errors.is_from_pool">{{ errors.is_from_pool[0] }}</p>
        </div>
         <div class="form-group" :class="{ 'has-error': errors.reason }">
            <label for="">Reason</label>
            <input type="text" class="form-control" v-model="transporterAdjusment.reason">
            <p class="text-danger" v-if="errors.reason">{{ errors.reason[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.note }">
            <label for="">Note</label>
            <input type="text" class="form-control" v-model="transporterAdjusment.note">
            <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
        </div>
        
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormTransporterAdjusment',
    created() {
      this.getPoolForm(),
      this.getTransporterForm(), 
      this.getUserLogin() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('transporterAdjusment', {
            transporterAdjusment: state => state.transporterAdjusment //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pool', {
            pools: state => state.pools //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('transporter', {
            transporters: state => state.transporters //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
    },
    methods: {
        ...mapMutations('transporterAdjusment', ['CLEAR_FORM']), 
        ...mapActions('pool', ['getPoolForm']),
        ...mapActions('transporter', ['getTransporterForm']),
        ...mapActions('user', ['getUserLists']),
        ...mapActions('user', ['getUserLogin']),
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

