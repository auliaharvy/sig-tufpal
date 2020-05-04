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
                            <VueSignaturePad width="100%" height="150px" ref="signaturePad" />
                        </v-card>
                        <v-btn  :disabled="loading" :loading="loading" class="success my-5"  @click="save">
                            {{ loading ? 'Loading...':'Save' }}
                        </v-btn>
                        <v-btn  :disabled="loading" :loading="loading" class="success my-5"  @click="clear">
                            {{ loading ? 'Loading...':'clear' }}
                        </v-btn>
                        <div class="form-group" >
                            <label for="">SendDriverApproval</label>
                            <input type="input" class="form-control" v-model="sending_driver_approval">
                        </div>
                       <div class="form-group">
                            <label for="">Prove</label>
                            <input type="file" class="form-control" accept="image/*" @change="uploadImage($event)" id="file-input">
                            <p class="text-black">Leave blank if you don't want to change photo</p>
                        </div>
                        </v-flex>
                    </v-layout>
                    <div ref="printMe">
                    <v-layout align="center" justify="center">
                        <v-flex class="px-5" xs12 md12 lg12>
                        
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
                    </div>
                </template>
            </div> 
            <div class="pa-5">
                <v-btn @click="print">Print</v-btn>     
            </div>      
            <div class="pa-5">
                <v-btn @click="submit">Submit</v-btn>     
            </div>   
            <div class="pa-5">
                <v-btn @click="setImage">Upload</v-btn>     
            </div>                 
        </div>  
    </div>
</template>
<script>
    import $axios from '../../api.js'
    import { mapActions, mapState } from 'vuex'
    import FormSjpStatus from './Formedit.vue'
    import VueQrcode from 'qrcode.vue'
    import jsPDF from 'jspdf'

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
                output: '',
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
            ...mapActions('sjpstatus', ['editSjpStatus', 'updateSendDriverApproval']),
            ...mapActions('sjp', ['editSjp']),
            ...mapActions('driver', ['getDriverForm']),
            async print() {
            this.output = null;
                const filename  = this.sjp_number + '_send.pdf';
                const el = this.$refs.printMe;
                // add option type to get the image version
                // if not provided the promise will return 
                // the canvas.
                const options = {
                    type: 'dataURL'
                }
                this.output = await this.$html2canvas(el, options);

                let pdf = new jsPDF('p', 'mm', 'a4');
                pdf.addImage(this.output, 'PNG', 0, 0, 0, 0);
                pdf.save(filename);
            },
            uploadImage(event) {
                this.sending_driver_approval = event.target.files[0]
            },
            submit() {
                let form = new FormData()
                form.append('sending_driver_approval', this.sending_driver_approval)
                    this.updateSendDriverApproval(form).then(() => {
                        this.sending_driver_approval
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
                this.sending_driver_approval = data;
            },
           async save1(){
                const filename  = this.sjp_number + '_send.pdf';
                const el = this.$refs.printMe;
                // add option type to get the image version
                // if not provided the promise will return 
                // the canvas.
                const options = {
                    type: 'dataURL'
                }
                this.sending_driver_approval = await this.$html2canvas(el, options);
            },
             async  setImage(sending_driver_approval) {
                // const filename  = this.sjp_number + '_send.pdf';
                // const el = this.$refs.printMe;
                // // add option type to get the image version
                // // if not provided the promise will return 
                // // the canvas.
                // const options = {
                //     type: 'dataURL'
                // }
                // this.sending_driver_approval = await this.$html2canvas(el, options);
                let formData = new FormData();
                formData.append('sending_driver_approval', sending_driver_approval);
                $axios.post('/sjpstatus/sendingapproval', formData , {
                    headers: { 'Content-Type': 'multipart/form-data' }
                })
                .then(response => {
                    // upload successful
                })
                .catch(error => console.log(error));
        },
            
        },
        // beforeRouteLeave (to, from , next) {
        //     const answer = window.confirm('Do you really want to leave? you have unsaved changes!')
        //     if (answer) {
        //         next()
        //     } else {
        //         next(false)
        //     }
        // },
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