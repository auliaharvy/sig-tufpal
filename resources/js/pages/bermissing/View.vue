<template>
    <div  class=" text-center col-md-3 col-lg-3 ">
        <div class=" panel">
            <div class="panel-heading">
                <h3 class="panel-title">BER/Missing Pallet Print</h3>
            </div>
            <div id="print" ref="printMe" class="panel-body text-center" >
                <template>
                    <v-layout align="center" justify="center">
                        <v-flex class="px-5" xs12 md12 lg12>
                            <dt>{{ bmp_number }}</dt>
                            <dd>
                                    <qrcode-vue
                                    :value="bmp_number"
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
                            <dd>{{ pool_name }} </dd>
                            <br>
                            <dt>Transporter</dt>
                            <dd>{{ transporter_name }} </dd>
                            <br>
                            <dt>Note</dt>
                            <dd>{{ note }} </dd>
                            <br>
                            <dt>Reported At</dt>
                            <dd>{{ created_at }} </dd>
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
// import html2canvas from 'html2canvas'

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
                this.created_at = row.created_at
                this.editPools(this.pool_pallet_id).then((res) => {
                let row = res.data
                this.pool_name = row.pool_name
                })
                this.editTransporters(this.transporter_id).then((res) => {
                let row = res.data
                this.transporter_name = row.transporter_name
                })
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
                created_at: '',
                print_at: new Date().toLocaleString(),

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
            ...mapActions('transporter', ['editTransporters']),

            async print() {
                this.output = null;
                    const filename  = this.bmp_number + '.pdf';
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
