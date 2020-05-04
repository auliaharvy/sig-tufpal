<template>
    <div>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>SJP Number</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.sjp_number }}</option>
                    </select>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Sendback To</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.dept_pool }}</option>
                    </select>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.good_pallet }">
                    <label for="">Good Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.good_pallet">
                    <p class="text-danger" v-if="errors.good_pallet">{{ errors.good_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>  
                <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }">
                    <label for="">Tbr Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.tbr_pallet">
                    <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>  
                <div class="form-group" :class="{ 'has-error': errors.ber_pallet }" :readonly="true">
                    <label for="">Ber Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.ber_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.ber_pallet">{{ errors.ber_pallet[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>  
                <div class="form-group" :class="{ 'has-error': errors.missing_pallet }" :readonly="true">
                    <label for="">Missing Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.missing_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.missing_pallet">{{ errors.missing_pallet[0] }}</p>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.sending_driver_approval }">
                    <label for="">Driver Approval</label>
                    <input type="file" class="form-control" accept="image/*" @change="uploadImage($event)" id="file-input">
                    <p class="text-black">Take A Picture Drive Holding Approve Note</p>
                    <p class="text-danger" v-if="errors.sending_driver_approval">{{ errors.sending_driver_approval[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
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
        this.editSjpStatus(this.$route.params.id).then((res) => {
                let row = res.data    
                this.sjpstatus.sjp_id =  row.sjp_id
                this.sjpstatus.good_pallet = row.good_pallet
                this.sjpstatus.tbr_pallet = row.tbr_pallet
                this.sjpstatus.ber_pallet = row.ber_pallet
                this.sjpstatus.missing_pallet = row.missing_pallet
            }),
        this.getSjp(), 
        this.getMstTransaction(), 
        this.getUserLogin() //LOAD DATA
    },
    data() {
        return {
            sjpstatus: {
                sjp_status_id: '',
                sjp_id: '',
                good_pallet: '',
                tbr_pallet: '',
                ber_pallet: '',
                missing_pallet: '',
                note: '',
                sending_driver_approval: '',
                receiving_driver_approval: '',
            }
        }
    },
    computed: {
        ...mapState(['errors']),
        ...mapState('sjp', {
            sjps: state => state.sjps
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
        ...mapActions('sjpstatus', ['editSjpStatus','submitSjpStatussendback']),
        ...mapActions('msttransaction', ['getMstTransaction']),
        ...mapActions('user', ['getUserLogin']),
        uploadImage(event) {
            this.sjpstatus.sending_driver_approval = event.target.files[0]
        },
        submit() {
            let form = new FormData()
            form.append('sjp_id', this.sjpstatus.sjp_id)
            form.append('sjp_status_id', this.sjpstatus.sjp_status_id)
            form.append('good_pallet', this.sjpstatus.good_pallet)
            form.append('tbr_pallet', this.sjpstatus.tbr_pallet)
            form.append('ber_pallet', this.sjpstatus.ber_pallet)
            form.append('missing_pallet', this.sjpstatus.missing_pallet)
            form.append('sending_driver_approval', this.sjpstatus.sending_driver_approval)
            form.append('note', this.sjpstatus.note)
                this.submitSjpStatussendback(form).then(() => {
                    this.sjpstatus = {
                        sjp_status_id: '',
                        sjp_id: '',
                        good_pallet: '',
                        tbr_pallet: '',
                        ber_pallet: '',
                        missing_pallet: '',
                        note: '',
                        sending_driver_approval: '',
                    }
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
        },
    },
   
    destroyed() {
        this.CLEAR_FORM()
    }
}
</script>

