<template>
    <div>
        <div class="form-group" :class="{ 'has-error': errors.good_pallet }">
            <label for="">Good Pallet</label>
            <input type="text" class="form-control" v-model="filledtogood.good_pallet">
            <p class="text-danger" v-if="errors.good_pallet">{{ errors.good_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.note }">
            <label for="">Note</label>
            <input type="text" class="form-control" v-model="filledtogood.note">
            <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
        </div>
        
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormFilledtoGood',
    created() {
      this.getPools(), this.getUserLogin() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('filledtogood', {
            filledtogood: state => state.filledtogood //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pool', {
            pools: state => state.pools //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
    },
    methods: {
        ...mapMutations('filledtogood', ['CLEAR_FORM']), 
        ...mapActions('pool', ['getPools']),
        ...mapActions('user', ['getUserLists']),
        ...mapActions('user', ['getUserLogin']),
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

