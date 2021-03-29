<template>
    <div>
        <!-- <div class="form-group">
            <label>Pool Pallet</label>
            <select class='form-control' v-model='newpallet.pool_pallet_id'>
                <option value='0' >Select Pool Pallet</option>
                <option v-for='data in pools.data' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.pool_pallet_id }">
            <label for="">Pool Pallet</label>
            <input type="text" class="form-control" v-model="newpallet.pool_pallet_id">
            <p class="text-danger" v-if="errors.pool_pallet_id">{{ errors.pool_pallet_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Departure Pool Pallet </label>
            <select class='form-control' v-model='newpallet.pool_pallet_id'>
                <option value='0' >Select Departure</option>
                <option v-for='data in pools.data' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.adder_user_id }">
            <label for="">Adder User</label>
            <input type="text" class="form-control" v-model="newpallet.adder_user_id">
            <p class="text-danger" v-if="errors.adder_user_id">{{ errors.adder_user_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Adder User</label>
            <select class='form-control' v-model='newpallet.adder_user_id'>
                <option v-for='data in authenticated' :value='authenticated.id'>{{ authenticated.name }}</option>
            </select>
        </div> -->
        <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }">
            <label for="">TBR Pallet</label>
            <input type="text" class="form-control" v-model="damagedpallet.tbr_pallet">
            <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.note }">
            <label for="">Note</label>
            <input type="text" class="form-control" v-model="damagedpallet.note">
            <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
        </div>
        
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormDamagedpallet',
    created() {
      this.getPools(), this.getUserLogin() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('damagedpallet', {
            damagedpallet: state => state.damagedpallet //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pool', {
            pools: state => state.pools //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
    },
    methods: {
        ...mapMutations('damagedpallet', ['CLEAR_FORM']), 
        ...mapActions('pool', ['getPools']),
        ...mapActions('user', ['getUserLists']),
        ...mapActions('user', ['getUserLogin']),
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

