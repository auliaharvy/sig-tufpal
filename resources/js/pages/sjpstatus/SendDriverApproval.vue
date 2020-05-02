<template>
    <div  class=" col-md-12  ">
        <div class=" panel">
            <div class="panel-heading">
                <h3 class="panel-title">Send Driver Approval</h3>
            </div>
            <div id="print" class="panel-body text-center" >
                <template>
                    <v-layout align="center" justify="center">
                        <v-flex class="px-5" xs12 md12 lg12>
                            <v-card>
                            <v-toolbar>
                                <v-toolbar-title>Signature Pad</v-toolbar-title>
                            </v-toolbar>  
                            <VueSignaturePad width="100%" height="110px" ref="signaturePad" />
                        </v-card>
                        <v-btn  :disabled="loading" :loading="loading" class="success my-5"  @click="save">
                            {{ loading ? 'Loading...':'Save' }}
                        </v-btn>
                        <v-btn  :disabled="loading" :loading="loading" class="success my-5"  @click="clear">
                            {{ loading ? 'Loading...':'clear' }}
                        </v-btn>
                        <dt>{{ sjp_number }}</dt>
                            <dd>
                                    <qrcode-vue 
                                    :value="sjp_number"
                                    renderAs="svg" 
                                    level="H"></qrcode-vue>  
                            </dd>
                            <dd>
                             <img width="50%" :src="data">
                             <br>
                             {{ driver_id }}
                             ( <option v-for='data in drivers.data' v-bind:key='data.sjp_id' :value='1'>{{ data.driver_name }}</option> )
                            </dd>
                            <!-- <dt>{{ bmp_number }}</dt>
                            <dd>
                                    <qrcode-vue 
                                    :value="bmp_number"
                                    renderAs="svg" 
                                    level="H"></qrcode-vue>  
                            </dd>
                            <br>
                            <dt>BER Pallet</dt>
                            <dd>{{ ber_pallet }} Pallet</dd>
                            <br>
                            <dt>Missing Pallet</dt>
                            <dd>{{ missing_pallet }} Pallet</dd>
                            <br>
                            <dt>Note</dt>
                            <dd>{{ note }} </dd>
                            <br>
                            <dt>Pool Pallet</dt>
                            <dd>
                                <option v-for='data in pools.data' v-bind:key='data.sjp_id' :value='pool_pallet_id'>{{ data.pool_name }}</option>
                                </dd>
                            <br>
                            <dt>Transporter</dt>
                            <dd>{{ transporter_id }} </dd>
                            <br> -->
                        </v-flex>
                    </v-layout>
                </template>
            </div> 
            <div class="pa-5">
                <v-btn @click="print">Print</v-btn>     
            </div>             
        </div>  
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormSjpStatus from './Formedit.vue'
    import VueQrcode from 'qrcode.vue'

    export default {
        name: 'SendDriverApproval',
        components: {
            VueQrcode,
        },
        created() {
            this.editSjpStatus(this.$route.params.id).then((res) => {
                let row = res.data
                this.sjp_id =  row.sjp_id
                this.sjps_number =  row.sjps_number
                this.checeker_send_user_id =  row.checeker_send_user_id
                this.checker_receive_user_id =  row.reporter
                this.good_pallet =  row.good_pallet
                this.tbr_pallet =  row.tbr_pallet
                this.ber_pallet = row.ber_pallet
                this.missing_pallet =  row.missing_pallet
                this.sending_driver_approval = row.sending_driver_approval
                this.receiving_driver_approval =  row.receiving_driver_approval
                this.note = row.note

                this.editSjp(this.sjp_id).then((res) => {
                let row = res.data
                this.sjp_number = row.sjp_number
                this.driver_id = row.driver_id
                })
            }),
            this.getDriverForm()
        },
        data(){
            return{
                data: '',
                sjp_id: '',
                sjp_number: '',
                driver_id: '',
                sjps_number:  '',
                checeker_send_user_id:  '',
                checker_receive_user_id:  '',
                good_pallet:  '',
                tbr_pallet:  '',
                ber_pallet: '',
                missing_pallet:  '',
                sending_driver_approval: '',
                receiving_driver_approval:  '',
                note: '',
            }
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus', 'updateSjpStatus']),
            ...mapActions('sjp', ['editSjp']),
            ...mapActions('driver', ['getDriverForm']),
            print () {
                // Pass the element id here
                this.$htmlToPaper('print');
            },
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.updateSjpStatus().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
            },
            clear() {
                this.$refs.signaturePad.clearSignature();
            },
            save() {
                const { isEmpty, data } = this.$refs.signaturePad.saveSignature();
                console.log(isEmpty);
                console.log(data);
                this.data = data;
            }
        },
        computed: {
        ...mapState('sjpstatus', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('driver', {
            drivers: state => state.drivers //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'sjpstatus-form': FormSjpStatus
        },
    }
</script>