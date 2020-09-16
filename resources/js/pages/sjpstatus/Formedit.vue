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
                    <input type="text" class="form-control" v-model="sjpstatus.tbr_pallet" >
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
                <div class="form-group" :class="{ 'has-error': errors.good_cement }">
                    <label for="">Good Cement</label>
                    <input type="text" class="form-control" v-model="sjpstatus.good_cement" >
                    <p class="text-danger" v-if="errors.good_cement">{{ errors.good_cement[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.good_cement }">
                    <label for="">Bad Cement</label>
                    <input type="text" class="form-control" v-model="sjpstatus.bad_cement" >
                    <p class="text-danger" v-if="errors.bad_cement">{{ errors.bad_cement[0] }}</p>
                </div>
            </v-flex>
        </v-layout> 

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.receiving_driver_approval }">
                    <label for="">Driver Approval</label>
                    <input type="file" class="form-control" accept="image/*" @change="uploadImage($event)" id="file-input">
                    <p class="text-black">Take A Picture Drive Holding Approve Note</p>
                    <p class="text-danger" v-if="errors.receiving_driver_approval">{{ errors.receiving_driver_approval[0] }}</p>
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
    name: 'FormSjpStatus',
    created() {
        this.editSjpStatus(this.$route.params.id).then((res) => {
                let row = res.data    
                this.sjpstatus.sjp_id =  row.sjp_id
                this.sjpstatus.sjp_status_id = row.sjp_status_id
                this.sjpstatus.good_pallet = row.good_pallet
                this.sjpstatus.tbr_pallet = row.tbr_pallet
                this.sjpstatus.ber_pallet = row.ber_pallet
                this.sjpstatus.missing_pallet = row.missing_pallet
                this.sjpstatus.good_cement = row.good_cement
                this.sjpstatus.bad_cement = row.bad_cement
                this.sjpstatus.note = row.note
                this.sendSjpStatus.sjp_id =  row.sjp_id
                this.sendSjpStatus.sjp_status_id = row.sjp_status_id
                this.sendSjpStatus.good_pallet = row.good_pallet
                this.sendSjpStatus.tbr_pallet = row.tbr_pallet
                this.sendSjpStatus.ber_pallet = row.ber_pallet
                this.sendSjpStatus.missing_pallet = row.missing_pallet
                this.sendSjpStatus.good_cement = row.good_cement
                this.sendSjpStatus.bad_cement = row.bad_cement
                this.sendSjpStatus.note = row.note
            }),
        this.getSjp(), 
        this.getMstTransaction(), 
        this.getUserLogin() //LOAD DATA
    },
    data() {
        return {
            sendSjpStatus: {
                sjp_status_id: '',
                sjp_id: '',
                good_pallet: '',
                tbr_pallet: '',
                ber_pallet: '',
                missing_pallet: '',
                good_cement: '',
                bad_cement: '',
                note: '',
                receiving_driver_approval: '',
            },
            sjpstatus: {
                sjp_status_id: '',
                sjp_id: '',
                good_pallet: '',
                tbr_pallet: '',
                ber_pallet: '',
                missing_pallet: '',
                good_cement: '',
                bad_cement: '',
                note: '',
                receiving_driver_approval: '',
            },
            sendbackSjpstatus: {
                sjp_status_id: '',
                sjp_id: '',
                good_pallet: 16,
                tbr_pallet: 0,
                ber_pallet: 0,
                missing_pallet: 0,
                good_cement: '',
                bad_cement: '',
                note: '',
                sending_driver_approval: '',
            },
        }
    },
   
    watch: {
        autoGoodPallet(){
            this.sjpstatus.good_pallet = this.sendSjpStatus.good_pallet - this.sjpstatus.tbr_pallet;
        },
    },
    computed: {
        ...mapState(['errors']),
        ...mapState('sjp', {
            sjps: state => state.sjps,
            sjp: state => state.sjp
        }),
        ...mapState('msttransaction', {
            msttransactions: state => state.msttransactions
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
        autoGoodPallet(){
            this.sjpstatus.good_pallet = this.sendSjpStatus.good_pallet - this.sjpstatus.tbr_pallet;
        },
                
    },
    methods: {
        ...mapMutations('sjpstatus', ['CLEAR_FORM']), 
        ...mapActions('sjp', ['getSjp' , 'editSjp']),
        ...mapActions('sjpstatus', ['editSjpStatus','updateSjpStatus', 'submitSjpStatussendback']),
        ...mapActions('msttransaction', ['getMstTransaction']),
        ...mapActions('user', ['getUserLogin']),
        ...mapActions('sjpstatus', ['getSjpStatus']),
        updateQuantity(event) {
            this.form.sale_quantity = event.target.value
            this.form.sale_total = this.form.sale_quantity * this.form.sale_rate
        },
        sendbackCheck(){
            this.editSjp(this.sjpstatus.sjp_id).then((res) => {
                let row = res.data
                // var sendData = this.sendSjpStatus
                var data = this.sjpstatus
                var checkContent = 
                "<div><strong><span>Did you want Sendback?" + 
                "<p> Good Pallet : <b>" + 16 +
                "<p> TBR Pallet : <b> " + 0 +
                "<p> BER Pallet : <b> " + 0 +
                "<p> Missing Pallet : <b> " + 0 +
                "</span> </strong></div>"
                        
                this.$swal({
                    title: "Sendback " + row.sjp_number,
                    text: "...<div>" + checkContent + "</div>...",
                    html: "...<div>" + checkContent +   "</div>...",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sendback!',
                    cancelButtonText: 'No!'
                }).then((result) => {
                    if (result.value) {
                        this.autoSendback() //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                    }else{
                        this.$router.push({ name: 'sjpstatuss.sendback', params: {id: this.sjpstatus.sjp_status_id} })
                    }
                })
            })
        },
        autoSendback(){
            let form = new FormData()
            form.append('sjp_id', this.sjpstatus.sjp_id)
            form.append('sjp_status_id', this.sjpstatus.sjp_status_id)
            form.append('good_pallet', this.sendbackSjpstatus.good_pallet)
            form.append('tbr_pallet', this.sendbackSjpstatus.tbr_pallet)
            form.append('ber_pallet', this.sendbackSjpstatus.ber_pallet)
            form.append('missing_pallet', this.sendbackSjpstatus.missing_pallet)
            form.append('sending_driver_approval', this.sendbackSjpstatus.sending_driver_approval)
            form.append('note', this.sendbackSjpstatus.note)
                this.submitSjpStatussendback(form).then(() => {
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
        },
        receiveCheck(){
            this.editSjp(this.sjpstatus.sjp_id).then((res) => {
                let row = res.data
                var sendData = this.sendSjpStatus
                var data = this.sjpstatus
                var checkContent = 
                "<div><strong><span>" + 
                "<p> | Send Good Pallet : <b>" + sendData.good_pallet + " </b> | Receive Good Pallet : <b> " + data.good_pallet + " </b> | </p>" + 
                "<p> | Send TBR Pallet : <b> " + sendData.tbr_pallet  + " </b> | Receive TBR Pallet : <b> " + data.tbr_pallet + " </b> | </p>" +
                "<p> | Send BER Pallet : <b> " + sendData.ber_pallet  + " </b> | Receive BER Pallet : <b> " + data.ber_pallet + " </b> | </p>" +
                "<p> | Send Missing Pallet : <b> " + sendData.missing_pallet  + " </b> | Receive Missing Pallet : <b> " + data.missing_pallet + " </b> | </p>" +
                "</span> </strong></div>"
                        
                this.$swal({
                    title: "Receive " + row.sjp_number,
                    text: "...<div>" + checkContent + "</div>...",
                    html: "...<div>" + checkContent +   "</div>...",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Receive!'
                }).then((result) => {
                    if (result.value) {
                        this.submit() //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                    }
                })
            })
        },
        uploadImage(event) {
            this.sjpstatus.receiving_driver_approval = event.target.files[0]
        },
        submit() {
            let form = new FormData()
            form.append('sjp_id', this.sjpstatus.sjp_id)
            form.append('sjp_status_id', this.sjpstatus.sjp_status_id)
            form.append('good_pallet', this.sjpstatus.good_pallet)
            form.append('tbr_pallet', this.sjpstatus.tbr_pallet)
            form.append('ber_pallet', this.sjpstatus.ber_pallet)
            form.append('missing_pallet', this.sjpstatus.missing_pallet)
            form.append('good_cement', this.sjpstatus.good_cement)
            form.append('bad_cement', this.sjpstatus.bad_cement)
            form.append('sending_driver_approval', this.sjpstatus.receiving_driver_approval)
            form.append('note', this.sjpstatus.note)
                this.updateSjpStatus(form).then(() => {
                    this.sendbackCheck()
                })
        },
       
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

