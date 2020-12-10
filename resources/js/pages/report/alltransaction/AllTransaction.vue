<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <p> From : {{ fromDate }} </p>
                <p> To : {{ toDate }} </p>
                <v-btn class="mx-2"  @click.prevent="weekAgo()">
                    A Week
                </v-btn>
                <v-btn class="mx-2" @click.prevent="monthAgo()">
                    A Month
                </v-btn>
                <v-btn class="mx-2">
                    <download-excel
                    :data= "alltransactions.data"
                    :fields="json_fields"
                    :name="exportName">
                    Download Data
                    </download-excel>
                </v-btn>
            </div>
            <div class="panel-body">
                  
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                        ALL TRANSACTION
                        <v-spacer></v-spacer>
                        <template>
                            <v-row>
                                <v-menu
                                    ref="menu"
                                    v-model="menu"
                                    :close-on-content-click="false"
                                    :return-value.sync="dates"
                                    transition="scale-transition"
                                    offset-y
                                    min-width="290px"
                                >
                                <template v-slot:activator="{ on, attrs }">
                                    <v-text-field
                                        v-model="dateRangeText"
                                        label="Query Range"
                                        prepend-icon="mdi-calendar"
                                        readonly
                                        v-bind="attrs"
                                        v-on="on"
                                        single-line
                                        hide-details
                                    ></v-text-field>
                                    <v-btn text color="primary" @click="selectedDate">Query</v-btn>
                                    </template>
                                    <v-date-picker v-model="dates" no-title range>
                                    <v-spacer></v-spacer>
                                    <v-btn text color="primary" @click="menu = false">Close</v-btn>
                                    <v-btn text color="primary" @click="$refs.menu.save(dates)">Ok</v-btn>
                                    </v-date-picker>
                                </v-menu>
                            </v-row>
                            </template>
                        
                        <!-- <v-text-field
                            v-model="fromDate"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field> -->
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
import { VDaterange } from "vuetify-daterange-picker"
import "vuetify-daterange-picker/dist/vuetify-daterange-picker.css";

export default {
    components: { VDaterange },
    name: 'DataSjpPalletSend',
    created() {
        this.weekAgo();
        this.getAlltransaction().then((res) => {
                let row = res.data
                // console.log(row)
            });
        this.getUserLogin().then((res) => {
                let row = res.data
                // console.log(row.reference_pool_pallet_id)
            })
            
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            exportName: 'All Transaction ' + this.dateRangeText,
            json_fields: {
                'TID Number' : 'tid_number',
                'SJP Number' : 'sjp_number',
                'SJPS_Number' : 'sjps_number',
                'TP Number' : 'tp_number',
                'BMP Number' : 'bmp_number',
                'NP Number' : 'np_number',
                'DP Number' : 'dp_number' ,
                'RP Number' : 'rp_number',
                'TA Number' : 'ta_number',
                'Transaction Type' : 'transaction',
                'No Dispatch' : 'no_do',
                'New No Dispatch' : 'new_no_do',
                'Status' : 'status',
                'Sender/Reporter' : 'sender/reporter' ,
                'Receiver/Approver' : 'receiver/approver',
                'Departure' : 'departure_pool',
                'Destination' : 'destination_pool',
                'New Destination' : 'new_destination',
                'Pool Pallet' : 'pool_pallet',
                'Transporter' : 'transporter',
                'Vehicle' : 'vehicle',
                'New Vehicle' : 'new_vehicle',
                'Driver' : 'driver',
                'New Driver' : 'new_driver',
                'Good Pallet' : 'good_pallet',
                'TBR Pallet' : 'tbr_pallet',
                'BER Pallet' : 'ber_pallet',
                'Missing Pallet' : 'missing_pallet',
                'Good Cement' : 'good_cement',
                'Bad Cement' : 'bad_cement',
                'Berita Acara' : 'reporter_prove',
                'Reason' : 'reason',
                'Note' : 'note',
                'Created At' : 'created_at' 
            },
             headers: [
                { value: 'tid_number', text: 'TID Number' },
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'sjps_number', text: 'SJPS Number' },
                { value: 'tp_number', text: 'TP Number' },
                { value: 'bmp_number', text: 'BMP Number' },
                { value: 'np_number', text: 'NP Number' },
                { value: 'dp_number', text: 'DP Number' },
                { value: 'rp_number', text: 'RP Number' },
                { value: 'ta_number', text: 'TA Number' },
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
            search: '',
            dates: [ ],
            menu: false,
            fromDate: '',
            toDate: '',
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
        ...mapState(['token']),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.alltransaction.page
            },
            set(val) {
                this.$store.commit('alltransactions/SET_PAGE', val)
            }
        },
        dateRangeText () {
            return this.dates.join(' ~ ')
        },
        aMonth(){
            this.fromDate = this.dates[0]
            this.toDate = this.dates[1]
        },
        aWeek(){
            this.fromDate = this.dates[0]
            this.toDate = this.dates[1]
        },
        
        
    },
    watch: {
        page() {
            this.getAlltransaction() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getAlltransaction(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        dates() {
            this.getAlltransaction()
        }
        
    },
    methods: {
        ...mapActions('alltransaction', ['getAlltransaction']),
        ...mapActions('user', ['getUserLogin']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        exportData() {
            window.open(`api/exportalltransaction?api_token=${this.token}`)
        },
        monthAgo(){
            this.toDate = new Date ().toISOString().slice(0,10)
            var month = new Date();
            month.setDate(month.getDate() - 30);
            this.fromDate = month.toISOString().slice(0,10)
            var today = new Date ().toISOString().slice(0,10)
            this.dates = [month.toISOString().slice(0,10), today ]
            this.$store.state.alltransaction.fromDate = this.dates[0]
            this.$store.state.alltransaction.toDate = this.dates[1]
        },
        weekAgo(){
            this.toDate = new Date ().toISOString().slice(0,10)
            var week = new Date();
            week.setDate(week.getDate() - 7);
            this.fromDate = week.toISOString().slice(0,10)
            var today = new Date ().toISOString().slice(0,10)
            this.dates = [week.toISOString().slice(0,10), today ]
             this.$store.state.alltransaction.fromDate = this.dates[0]
            this.$store.state.alltransaction.toDate = this.dates[1]
        },
        selectedDate(){
            this.fromDate = this.dates[0]
            this.toDate = this.dates[1]
            this.$store.state.alltransaction.fromDate = this.dates[0]
            this.$store.state.alltransaction.toDate = this.dates[1]
            this.getAlltransaction()
        },
    }
}
</script>
