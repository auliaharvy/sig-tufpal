<template>
    <div class="col-md-12">
        <div class="panel">

            <div class="panel-body">

              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                        ALL TRANSACTION
                        <v-spacer></v-spacer>
                        <v-btn>
                            <download-excel
                            :data= "alltransactions.data"
                            :name="exportName">
                                Download Data
                            </download-excel>
                        </v-btn>
                        <v-text-field
                            v-model="search"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headers"
                        :loading="loading"
                        :items="alltransactions.data"
                        :search="search"
                        dense
                        >
                        <!-- <template v-slot:item.status="{ item }">
                                            <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
                                            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip>
                                        </template> -->

                            </v-data-table>
                        </v-card>
                        </template>
              	<!-- TABLE UNTUK MENAMPILKAN LIST CUSTOMER -->


                    <!-- <div class="col-md-6">
                        <p v-if="sjpstatuss.data"><i class="fa fa-bars"></i> {{ sjpstatuss.data.length }} item dari {{ sjpstatuss.meta.total }} total data</p>
                    </div>
                    <div class="col-md-6">
                        <div class="pull-right">
                            <b-pagination
                                v-model="page"
                                :total-rows="sjpstatuss.meta.total"
                                :per-page="sjpstatuss.meta.per_page"
                                aria-controls="sjpstatuss"
                                v-if="sjpstatuss.data && sjpstatuss.data.length > 0"
                                ></b-pagination>
                        </div>
                    </div> -->

            </div>
        </div>
    </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

export default {
    name: 'DataSjpPalletSend',
    created() {
        this.getAlltransaction().then((res) => {
                let row = res.data
                console.log(row.pool_pallet)
            });
        this.getUserLogin().then((res) => {
                let row = res.data
                console.log(row)
            })
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            exportName: 'All Transaction ' + new Date().toISOString().slice(0,10),
             headers: [
                { value: 'tid_number', text: 'TID Number' },
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'sjps_number', text: 'SJPS Number' },
                { value: 'tp_number', text: 'TP Number' },
                { value: 'bmp_number', text: 'BMP Number' },
                { value: 'np_number', text: 'NP Number' },
                { value: 'dp_number', text: 'DP Number' },
                { value: 'rp_number', text: 'RP Number' },
                { value: 'transaction', text: 'Transaction Type' },
                { value: 'no_do', text: 'No Dispatch' },
                { value: 'new_no_do', text: 'New No Dispatch' },
                { value: 'status', text: 'Status' },
                { value: 'sender/reporter', text: 'Sender/Reporter' },
                { value: 'receiver/approver', text: 'Receiver/Approver' },
                { value: 'departure_pool', text: 'Departure' },
                { value: 'destination_pool', text: 'Destination' },
                { value: 'new_destination', text: 'New Destination' },
                { value: 'pool_pallet', text: 'Pool Pallet' },
                { value: 'transporter', text: 'Transporter' },
                { value: 'vehicle', text: 'Vehicle' },
                { value: 'new_vehicle', text: 'New Vehicle' },
                { value: 'driver', text: 'Driver' },
                { value: 'new_driver', text: 'New Driver' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'good_cement', text: 'Good Cement' },
                { value: 'bad_cement', text: 'Bad Cement' },
                { value: 'reporter_prove', text: 'Berita Acara' },
                { value: 'reason', text: 'Reason' },
                { value: 'note', text: 'Note' },
                { value: 'created_at', text: 'Created At' },
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('alltransaction', {
            alltransactions: state => state.alltransactions //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('alltransaction', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.alltransaction.page
            },
            set(val) {
                this.$store.commit('alltransactions/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getAlltransaction() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getAlltransaction(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('alltransaction', ['getAlltransaction']),
        ...mapActions('user', ['getUserLogin']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        exportData() {
            window.open(`api/exportalltransactiontoday?api_token=${this.token}`)
        }
    }
}
</script>
