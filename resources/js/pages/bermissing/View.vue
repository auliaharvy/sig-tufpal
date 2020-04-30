<template>
    <div id="print" class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">BER/Missing Pallet Print</h3>
            </div>
            <div class="panel-body">
                <template>
                    <v-layout align="center" justify="center">
                        <v-flex class="px-5" xs12 md6 lg6>
                            <dt>{{ bmp_number }}</dt>
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
                        </v-flex>
                        <v-flex class="px-5" xs12 md6 lg6>
                            <dt>Pool Pallet</dt>
                            <dd>{{ pool_pallet_id }}</dd>
                            <br>
                            <dt>Transporter</dt>
                            <dd>{{ transporter_id }} </dd>
                            <br>
                        </v-flex>
                    </v-layout>
                </template>
            </div>
                    <v-layout align="center" justify="center">
                        <v-flex class="px-5 py-5" xs12 md6 lg6>
                            <v-btn @click="print">Print</v-btn>
                        </v-flex>
                    </v-layout>            
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
            this.editBermissing(this.$route.params.id).then((res) => {
                let row = res.data
                this.bmp_number =  row.bmp_number
                this.reporter_user_id =  row.reporter_user_id
                this.pool_pallet_id =  row.pool_pallet_id
                this.reporter_name =  row.reporter
                this.transporter_id =  row.transporter_id
                this.reference_sjp_status_id =  row.reference_sjp_status_id
                this.ber_pallet = row.ber_pallet
                this.missing_pallet =  row.missing_pallet
                this.reporter_prove = row.reporter_prove
                this.status =  row.status
                this.note = row.note
            }),
            this.getPools() 
        },
        data() {
            return {
                output: null,
                bmp_number: '',
                reporter_user_id: '',
                approver_user_id: '',
                pool_pallet_id: '',
                transporter_id: '',
                reference_sjp_status_id: '',
                ber_pallet: '',
                missing_pallet: '',
                reporter_prove: '',
                status: '',
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
            ...mapActions('bermissing', ['editBermissing']),
            ...mapActions('pool', ['getPools', 'editPools']),
            print () {
                // Pass the element id here
                this.$htmlToPaper('print');
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
