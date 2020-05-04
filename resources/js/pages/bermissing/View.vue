<template>
    <div  class=" col-md-12  ">
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
                            <dd>{{ pool_pallet_id }} </dd>
                            <br>
                            <dt>Transporter</dt>
                            <dd>{{ transporter_id }} </dd>
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
            
            


    //         print () {
    //             const filename  = this.bmp_number + '.pdf';

	// 	html2canvas(document.querySelector('#nodeToRenderAsPDF')).then(canvas => {
	// 		let pdf = new jsPDF('p', 'mm', 'a4');
	// 		pdf.addImage(canvas.toDataURL('image/png'), 'PNG', 0, 0, 211, 298);
	// 		pdf.save(filename);
	// 	});
	// },

// Variant
// This one lets you improve the PDF sharpness by scaling up the HTML node tree to render as an image before getting pasted on the PDF.
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
			pdf.addImage(this.output, 'PNG', 0, 0, 0, 0);
			pdf.save(filename);
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
