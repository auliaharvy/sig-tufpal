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

        <v-layout row wrap class="px-5">
            <!-- <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.filled_pallet }" :readonly="true">
                    <label for="">Pallet Quantity / Filled Pallet</label>
                    <input type="text" class="form-control" v-model="sjpstatus.filled_pallet" :readonly="true">
                    <p class="text-danger" v-if="errors.filled_pallet">{{ errors.filled_pallet[0] }}</p>
                </div>
            </v-flex> -->
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Pallet Quantity / Good Pallet</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.pallet_quantity }}</option>
                    </select>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Good Cement</label>
                    <select class='form-control' v-model='sjpstatus.sjp_id' :readonly="true">
                        <option disabled v-for='data in sjps.data' v-bind:key='data.sjp_id' :value='data.sjp_id'>{{ data.product_quantity }}</option>
                    </select>
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
import $axios from '../../api.js'

export default {
    name: 'FormSjpStatus',
    created() {
        this.addSjpStatusbyMaster(this.$route.params.id).then((res) => {
                let row = res.data
                this.sjpstatus.sjp_id =  row.sjp_id
                this.editSjp(row.sjp_id).then((res) => {
                    let row = res.data
                    // this.sjpstatus.filled_pallet =  row.pallet_quantity
                    this.sjpstatus.good_pallet =  row.pallet_quantity
                })
            }),
        this.getSjp(),
        this.getMstTransaction(),
        this.getUserLogin() //LOAD DATA
    },
   data() {
        return {
            truckNumber: '',
            sjpstatus: {
                sjp_status_id: '',
                sjp_id: '',
                good_pallet: '',
                // filled_pallet: '',
                tbr_pallet: 0,
                ber_pallet: 0,
                missing_pallet: 0,
                note: '',
                sending_driver_approval: '',
                receiving_driver_approval: '',
            }
        }
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
    },
    methods: {
        ...mapMutations('sjpstatus', ['CLEAR_FORM']),
        ...mapActions('sjpstatus', ['addSjpStatusbyMaster','submitSjpStatus']),
        ...mapActions('sjp', ['getSjp', 'checkSjp', 'editSjp']),
        ...mapActions('msttransaction', ['getMstTransaction']),
        ...mapActions('user', ['getUserLogin']),
        sendCheck(){
            this.editSjp(this.sjpstatus.sjp_id).then((res) => {
                let row = res.data
                var sendData = this.sendSjpStatus
                var data = this.sjpstatus
                var checkContent = 
                "<div><strong><span>" + 
                "| Send Back Good Pallet : <b> " + data.good_pallet + " </b> | </p>" +
                "| Send Back TBR Pallet : <b> " + data.tbr_pallet + " </b> | </p>" +
                "| Send Back BER Pallet : <b> " + data.ber_pallet + " </b> | </p>" +
                "| Send Back Missing Pallet : <b> " + data.missing_pallet + " </b> | </p>" +
                "</span> </strong></div>"
                        
                this.$swal({
                    title: "Send " + row.sjp_number,
                    text: "...<div>" + checkContent + "</div>...",
                    html: "...<div>" + checkContent +   "</div>...",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Send!'
                }).then((result) => {
                    if (result.value) {
                        this.submit() //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                    }
                }).catch((error) => {
                    alert(error.response.data.message)
                })
            })
        },
        SjpCheck(){
            this.editSjp(this.sjpstatus.sjp_id).then((res) => {
                let row = res.data
                this.truckNumber =  row.vehicle_id
                // console.log(this.truckNumber)
                let bodyFormData = new FormData()
                bodyFormData.set('vehicle_number', this.truckNumber);
                    $axios({
                        method: 'post',
                        url: '/sjp/checktruck',
                        data: bodyFormData,
                        headers: {'Content-Type': 'multipart/form-data' }
                    })
                    .then((response) => {
                        // console.log(response.data); 
                        var data = response.data
                        var checkContent = data.map(function(item) {
                            if(item.state == 0){
                                item.statusSjp = "DRAFT"
                            }
                            if(item.state == 1){
                                item.statusSjp = "SEND"
                            }
                            if(item.state == 2){
                                item.statusSjp = "RECEIVED"
                            }
                            if(item.state == 3){
                                item.statusSjp = "SENDBACK"
                            }
                            if(item.state == 4){
                                item.statusSjp = "RECEIVE SENDBACK"
                            }
                            return "<div><strong><span>" + 
                            " | SJP Number : <b> " + item.sjp_number + "</b> | Destination : <b> " + item.dest_pool + "</b> | Status : <b> " + item.statusSjp  + "</b> | </span> </strong></div>"
                        }).join('')
                            this.$swal({
                                title: response.data.length + ' open SJP for Truck ' + this.truckNumber,
                                text: "...<div>" + checkContent + "</div>...",
                                html: "...<div>" + checkContent + "</div>...",
                                type: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Send!'
                            }).then((result) => {
                                if (result.value) {
                                    this.submit() //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                                }
                            })
                        
                    }).catch((error) => {
                    alert(error.response.data.message)
                })
            
            })
        },
        uploadImage(event) {
            this.sjpstatus.sending_driver_approval = event.target.files[0]
        },
        submit() {
            let form = new FormData()
            form.append('sjp_id', this.sjpstatus.sjp_id)
            form.append('good_pallet', this.sjpstatus.good_pallet)
            // form.append('filled_pallet', this.sjpstatus.filled_pallet)
            form.append('sjp_status_id', this.sjpstatus.sjp_status_id)
            form.append('sending_driver_approval', this.sjpstatus.sending_driver_approval)
            form.append('note', this.sjpstatus.note)
                this.submitSjpStatus(form).then(() => {
                    this.sjpstatus = {
                        sjp_id: '',
                        good_pallet: '',
                        // filled_pallet: '',
                        sjp_status_id: '',
                        sending_driver_approval: '',
                        note: '',
                    }
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
        },
    },

    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

