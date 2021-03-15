<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <v-btn>
                            <download-excel
                            :data= "palletmovements.data"
                            :fields="json_fields"
                            :name='exportName'>
                            Download Data
                            </download-excel>
                        </v-btn>
            </div>
            <div class="panel-body">

              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                        Pallet Movement
                        <v-spacer></v-spacer>
                        
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="search"
                            prepend-icon="mdi-magnify"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :loading="loading"
                        :headers="headers"
                        :items="palletmovements.data"
                        :search="search"
                        dense
                        >
                            <template v-slot:item.status="{ item }">
                                <!-- <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
                                <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip> -->
                                <p v-if="item.status == 0">Sending</p>
                                <p class="text-blue" v-else-if="item.status == 1">Received</p>
                            </template>
                            <template v-slot:item.late="{ item }">
                                <v-chip class="error " v-if="item.eta < now">{{ item.eta | moment("from", true) }}</v-chip>
                                <v-chip class="success " v-else-if="item.eta > now ">0 Day</v-chip>
                                <v-chip class="success " v-else-if="item.eta == now ">0 Day</v-chip>
                            </template>

                        </v-data-table>
                    </v-card>
                </template>
            </div>
        </div>
    </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import moment from 'moment'

export default {
    name: 'DataPalletMovement',
    created() {
        this.getPalletMovements()
    },
    data() {
        return {
            now: moment().format("YYYY-MM-DD"),
            exportName: 'Pallet Movement ' + new Date ().toISOString().slice(0,10),
            json_fields: {
                'SJP Number' : 'sjp_number',
                'Transaction Type' : 'transaction',
                'Status' : 'status',
                'Departure' : 'dept_pool',
                'Destination' : 'dest_pool',
                'Transporter' : 'transporter_name',
                'Vehicle' : 'vehicle_number',
                'Good Pallet' : 'good_pallet',
                'Filled Pallet' : 'filled_pallet',
                'TBR Pallet' : 'tbr_pallet',
                'BER Pallet' : 'ber_pallet',
                'Missing Pallet' : 'missing_pallet',
                'Departure Time' : 'departure_time',
                'ETA' : 'eta',
            },
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
             headers: [
                // { value: 'sjps_number', text: 'SJP Status Number' },
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'transaction', text: 'Send/Send Back' },
                { value: 'status', text: 'Status' },
                { value: 'dept_pool', text: 'Departure Pool' },
                { value: 'dest_pool', text: 'Destination Pool' },
                { value: 'transporter_name', text: 'Transporter' },
                { value: 'vehicle_number', text: 'Vehicle Number' },
                // { value: 'driver_name', text: 'Driver Name' },
                // { value: 'transporter_name', text: 'Transporter Name' },
                // { value: 'pallet_quantity', text: 'Pallet Quantity' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'filled_pallet', text: 'Filled Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                // { value: 'product_name', text: 'Product' },
                { value: 'departure_time', text: 'Departure Time' },
                { value: 'eta', text: 'ETA' },
                { value: 'late', text: 'Late Time'}
                // { value: 'send', text: 'Send Pallet' },
                // { value: 'adjusment', text: 'Adjusment SJP' },


            ],
            search: ''
        }
    },
    computed: {
        ...mapState('palletmovement', {
            palletmovements: state => state.palletmovements //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('palletmovement', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.palletmovement.page
            },
            set(val) {
                this.$store.commit('palletmovement/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getPalletMovements() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getPalletMovements(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('palletmovement', ['getPalletMovements']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN

    }
}
</script>
