<template>
    <div class="col-md-12">
        <div class="panel">

            <div class="panel-body">

              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
  <v-card>
    <v-card-title>
      Pallet Movement
      <v-spacer></v-spacer>
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
      :items="palletmovements.data"
      :search="search"
    >
        <template v-slot:item.status="{ item }">
            <!-- <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip> -->
            <p v-if="item.status == 0">Sending</p>
            <p class="text-blue" v-else-if="item.status == 1">Received</p>
        </template>
        <template v-slot:item.late="{ item }">
            <span>{{ item.eta | moment("from", true) }}</span>
        </template>

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
    name: 'DataPalletMovement',
    created() {
        this.getPalletMovements() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
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
