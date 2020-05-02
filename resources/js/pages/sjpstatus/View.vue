<template>
    <div ref="printMe" id="print" class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">SJP Status Print</h3>
            </div>
            <div class="panel-body">
                <template>
                    <v-divider />
                    <v-layout align="center" justify="center">
                        <v-flex class="px-5" xs12 md6 lg6>
                            <dt>{{ sjp_number }}</dt>
                            <dd>
                                <div id="qrcode">
                                    <VueQrcode :value="sjp_number" />
                                </div>
                            </dd>
                            <br>
                            <dt>Good Pallet</dt>
                            <dd>{{ good_pallet }} Pallet</dd>
                            <br>
                            <dt>TBR Pallet</dt>
                            <dd>{{ tbr_pallet }} Pallet</dd>
                            <br>
                            <br>
                            <dt>BER Pallet</dt>
                            <dd>{{ ber_pallet }} Pallet</dd>
                            <br>
                            <dt>Missing Pallet</dt>
                            <dd>{{ missing_pallet }} Pallet</dd>
                            <br>
                            <dt>Note</dt>
                            <dd>{{ note }} </dd>
                        </v-flex>
                        <v-divider />
                        <v-flex class="px-5" xs12 md6 lg6>
                            <dt>Pool Pallet</dt>
                            <dd>{{ pool_pallet_id }} </dd>
                            <br>
                            <dt>Transporter</dt>
                            <dd>{{ transporter_id }} </dd>
                            <br>
                        </v-flex>
                    </v-layout>
                    <v-divider />
                    <!-- <v-layout align="center" justify="center">
                        <v-flex class="px-5" xs12 md6 lg6>
                            <v-btn @click="print">Download PDF</v-btn>
                        </v-flex>
                    </v-layout> -->
                </template>
            </div>
            
        </div>
    </div>
</template>
<script>
import { mapActions, mapState, mapMutations } from 'vuex';
import VueQrcode from 'qrcode.vue'
import jsPDF from 'jspdf'

    export default {
        name: 'ViewBermissing',
        components: {
            VueQrcode,
        },
        created() {
            this.editSjpStatus(this.$route.params.id).then((res) => {
                let row = res.data
                this.sjp_number =  row.sjp_number
                this.checker_send_user_id =  row.checker_send_user_id
                this.checker_receive_user_id =  row.checker_receive_user_id
                this.sjp_id =  row.sjp_id
                this.transaction_id =  row.transaction_id
                this.status =  row.status
                this.good_pallet =  row.good_pallet
                this.ber_pallet = row.ber_pallet
                this.tbr_pallet = row.tbr_pallet
                this.missing_pallet =  row.missing_pallet
                this.good_cement = row.good_cement
                this.bad_cement =  row.bad_cement
                this.driver_approval = row.driver_approval
                this.note = row.note
            }),
            this.editPools(this.pool_pallet_id).then((res) => {
                let row = res.data
                this.pool_name = row.pool_name  
            })
        },
        data() {
            return {
                output: null,
                checker_send_user_id: '',
                checker_receive_user_id: '',
                sjp_id: '',
                transaction_id: '',
                sjp_number: '',
                status: '',
                good_pallet: '',
                tbr_pallet: '',
                ber_pallet: '',
                missing_pallet: '',
                good_cement: '',
                bad_cement: '',
                driver_approval: '',
                note: '',
                
                pool_name: '',
                transporter_name: '',
                sjp_status: '',
                reporter_name: '',
                approver_name: '',
            }
        },
        
        computed: {
            ...mapState('pool', {
            pools: state => state.pools 
        }),
        ...mapState('pool', {
            pool: state => state.pool 
        }),
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus']),
            ...mapActions('pool', ['getPools', 'editPools']),
           async print() {
                const el = this.$refs.printMe;
                // add option type to get the image version
                // if not provided the promise will return 
                // the canvas.
                const options = {
                    type: 'dataURL'
                }
                this.output = await this.$html2canvas(el, options);
            },
            
            accept() {
                this.$swal({
                    title: 'Kamu Yakin?',
                    text: "Permintaan yang disetujui tidak dapat dikembalikan!",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Iya, Lanjutkan!'
                }).then((result) => {
                    if (result.value) {
                        this.acceptExpenses(this.$route.params.id).then(() => this.$router.push({ name: 'expenses.data' }))
                    }
                })
            },
            cancelRequest() {
                this.$swal({
                    title: 'Kamu Yakin?',
                    text: "Permintaan yang ditolak tidak dapat dikembalikan!",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Iya, Lanjutkan!'
                }).then((result) => {
                    if (result.value) {
                        this.cancelExpenses({id: this.$route.params.id, reason: this.inputReason}).then(() => {
                            this.formReason = false
                            this.$router.push({ name: 'expenses.data' })
                        })
                    }
                })
            }
        }
    }
</script>
