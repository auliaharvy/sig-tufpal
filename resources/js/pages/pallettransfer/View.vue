<template>
    <div  class=" text-center col-md-3 col-lg-3 ">
        <div class=" panel">
            <div class="panel-heading">
                <h3 class="panel-title">Pallet Transfer Print</h3>
            </div>
            <div id="print" ref="printMe" class="panel-body text-center" >
                <template>
                    <v-layout align="center" justify="center">
                        <v-flex class="px-5" xs12 md12 lg12>
                            <dt>{{ tp_number }}</dt>
                            <dd>
                                    <qrcode-vue
                                    :value="tp_number"
                                    renderAs="svg"
                                    level="H"></qrcode-vue>
                            </dd>
                            <br>
                            <dt>Pallet</dt>
                            <dd>Good Pallet: {{ good_pallet }} Pallet</dd>
                            <dd>TBR Pallet: {{ tbr_pallet }} Pallet</dd>
                            <dd>BER Pallet: {{ ber_pallet }} Pallet</dd>
                            <dd>Missing Pallet: {{ missing_pallet }} Pallet</dd>
                            <br>
                            <dt>Pool Pallet</dt>
                            <dd>Departure: {{ dept_pool_name }} </dd>
                            <dd>Destination: {{ dest_pool_name }} </dd>
                            <br>
                            <dt>Transporter</dt>
                            <dd>{{ transporter_name }} </dd>
                            <br>
                            <dt>Note</dt>
                            <dd>{{ note }} </dd>
                            <br>
                            <dt>Print At</dt>
                            <dd>{{ print_at }} </dd>
                            <br>
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
import { mapActions, mapState, mapMutations } from 'vuex';
import VueQrcode from 'qrcode.vue'
import jsPDF from 'jspdf'

    export default {
        name: 'ViewBermissing',
        components: {
            VueQrcode,
        },
        created() {
            this.editPalletTransfer(this.$route.params.id).then((res) => {
                let row = res.data
                this.tp_number =  row.tp_number
                this.checker_send_user_id =  row.sender_user_id
                this.checker_receive_user_id =  row.receiver_user_id
                this.transporter_id = row.transporter_id
                this.dept_pool_pallet_id = row.departure_pool_pallet_id
                this.dest_pool_pallet_id = row.destination_pool_pallet_id
                this.good_pallet =  row.good_pallet
                this.ber_pallet = row.ber_pallet
                this.tbr_pallet = row.tbr_pallet
                this.missing_pallet =  row.missing_pallet
                this.good_cement = row.good_cement
                this.bad_cement =  row.bad_cement
                this.driver_approval = row.driver_approval
                this.note = row.note

                    this.editTransporters(this.transporter_id).then((res) => {
                    let row = res.data
                    this.transporter_name = row.transporter_name
                    })
                    this.editPools(this.dept_pool_pallet_id).then((res) => {
                    let row = res.data
                    this.dept_pool_name = row.pool_name
                    })
                    this.editPools(this.dest_pool_pallet_id).then((res) => {
                    let row = res.data
                    this.dest_pool_name = row.pool_name
                    })
            })

        },
        data() {
            return {
                output: null,
                tp_number: '',
                checker_send_user_id: '',
                checker_receive_user_id: '',
                good_pallet: '',
                tbr_pallet: '',
                ber_pallet: '',
                missing_pallet: '',
                note: '',
                print_at: new Date().toLocaleString(),

                dept_pool_name: '',
                dest_pool_name: '',
                transporter_name: '',
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
            ...mapActions('pallettransfer', ['editPalletTransfer']),
            ...mapActions('pool', ['getPools', 'editPools']),
            ...mapActions('transporter', ['editTransporters']),
           async print() {
                this.output = null;
                    const filename  = this.tp_number + '.pdf';
                    const el = this.$refs.printMe;
                // add option type to get the image version
                // if not provided the promise will return
                // the canvas.
                const options = {
                    type: 'dataURL'
                }
                this.output = await this.$html2canvas(el, options);

                let pdf = new jsPDF('p', 'mm', 'a4');
                    var width = pdf.internal.pageSize.getWidth();
                    var height = pdf.internal.pageSize.getHeight();
                    pdf.addImage(this.output, 'PNG', 0, 0, width, height);
                    pdf.save(filename);
            },
        }
    }
</script>
