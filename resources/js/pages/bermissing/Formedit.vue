<template>
    <div>
        <!-- <div class="form-group">
            <label>Pool Pallet</label>
            <select class='form-control' v-model='bermissing.pool_pallet_id'>
                <option value='0' >Select Pool Pallet</option>
                <option v-for='data in pools.data' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group">
            <label>Transporter Name</label>
            <select class='form-control' v-model='bermissing.transporter_id'>
                <option value='0' >Select Transporter</option>
                <option v-for='data in transporters.data' :value='data.transporter_id'>{{ data.transporter_name }}</option>
            </select>
        </div> -->
       <!-- <div class="form-group" :class="{ 'has-error': errors.reporter_user_id }">
            <label for="">Reporter User</label>
            <input type="text" class="form-control" v-model="bermissing.reporter_user_id" :readonly="$route.name == 'bermissing.edit'">
            <p class="text-danger" v-if="errors.reporter_user_id">{{ errors.reporter_user_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Reporter User</label>
            <select class='form-control' v-model='bermissing.reporter_user_id' :readonly="$route.name == 'bermissings.edit'">
                <option v-for='data in authenticated' :value='authenticated.id'>{{ authenticated.name }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.approver_user_id }">
            <label for="">Approver User</label>
            <input type="text" class="form-control" v-model="bermissing.approver_user_id" :readonly="$route.name == 'bermissing.add'">
            <p class="text-danger" v-if="errors.approver_user_id">{{ errors.approver_user_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Reporter User</label>
            <select class='form-control' v-model='bermissing.approver_user_id' :readonly="$route.name == 'bermissings.add'">
                <option v-for='data in authenticated' :value='authenticated.id'>{{ authenticated.name }}</option>
            </select>
        </div> -->
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.bmp_number }" :readonly="true">
                    <label for="">BER/Missing Pallet Number</label>
                    <input type="text" class="form-control" v-model="bermissing.bmp_number" :readonly="true">
                    <p class="text-danger" v-if="errors.bmp_number">{{ errors.bmp_number[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :readonly="true">
                    <label>Pool Pallet</label>
                    <select class='form-control' v-model='bermissing.pool_pallet_id' :readonly="true">
                        <option value='0' disabled>Select Destination</option>
                        <option disabled v-for='data in pools.data' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
                    </select>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.ber_pallet }" :readonly="true">
                    <label for="">BER Pallet</label>
                    <input type="text" class="form-control" v-model="bermissing.ber_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.ber_pallet">{{ errors.ber_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.missing_pallet }" :readonly="true">
                    <label for="">Missing Pallet</label>
                    <input type="text" class="form-control" v-model="bermissing.missing_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.missing_pallet">{{ errors.missing_pallet[0] }}</p>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <img :src="'../storage/bermissing/reporter_prove/' + bermissing.reporter_prove"  :alt="bermissing.bmp_number"> </img>
            </v-flex>
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.note }">
                    <label for="">Note</label>
                    <input type="text" class="form-control" v-model="bermissing.note">
                    <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormBermissing',
    // data() {
    //     return {
    //         bermissing: {
    //             // ber_pallet: '',
    //             // missing_pallet: '',
    //             berita_acara: '',
    //             note: '',
    //         }
    //     }
    // },
    created() {
      this.getPools(),this.getTransporters(), this.getUserLogin() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('bermissing', {
            bermissing: state => state.bermissing //LOAD DATA CUSTOMER DARI STATE CUSTOMER
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
        ...mapMutations('bermissing', ['CLEAR_FORM']), 
        ...mapActions('bermissing', ['updateBermissing', 'updateBermissingDisapprove']),
        ...mapActions('pool', ['getPools']),
        ...mapActions('vehicle', ['getVehicles']),
        ...mapActions('driver', ['getDrivers']),
        ...mapActions('transporter', ['getTransporters']),
        ...mapActions('user', ['getUserLogin']),
        uploadImage(event) {
            this.bermissing.berita_acara = event.target.files[0]
        },
        submit() {
            let form = new FormData()
            form.append('ber_pallet', this.bermissing.ber_pallet)
            form.append('missing_pallet', this.bermissing.missing_pallet)
            form.append('berita_acara', this.bermissing.berita_acara)
            form.append('note', this.bermissing.note)
                this.updateBermissing(form).then(() => {
                    this.bermissing = {
                        ber_pallet: '',
                        missing_pallet: '',
                        berita_acara: '',
                        note: '',
                    }
                    this.$router.push({ name: 'bermissings.data' })
                })
        }
       
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>