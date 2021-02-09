<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link :to="{ name: 'sjps.add' }" class="v-btn btn-primary text-black" v-if="$can('create sjps') && authenticated.reference_pool_pallet_id != 'stationnambo' && pool.type != 'STATION' "><v-btn>Add SJP</v-btn></router-link>
                <router-link :to="{ name: 'sjps.add2nddiststation' }" class="v-btn btn-primary text-black" v-if="$can('create sjps') && authenticated.reference_pool_pallet_id == 'stationnambo' "><v-btn>Add SJP</v-btn></router-link>
                <router-link :to="{ name: 'sjps.add2nddiststation' }" class="v-btn btn-primary text-black" v-if="$can('create sjps') && pool.type == 'STATION' && authenticated.reference_pool_pallet_id != 'stationnambo' "><v-btn>Add to Nambo</v-btn></router-link>
                <router-link :to="{ name: 'sjps.add' }" class="v-btn btn-primary text-black" v-if="$can('create sjps') && pool.type == 'STATION' && authenticated.reference_pool_pallet_id != 'stationnambo' "><v-btn>Add to Warehouse</v-btn></router-link>
                <!-- <v-btn>
                    <download-excel
                    :data= "sjps.data"
                    :before-generate = "startDownload"
                    :before-finish = "finishDownload"
                    type="csv"
                    name="SJP.csv">
                         Download Data
                    </download-excel>
                </v-btn> -->
            </div>
            <div class="panel-body">

                <v-card>
                    <v-card-title>
                        Surat Jalan Pallet
                        <v-spacer></v-spacer>
                        <v-text-field
                        v-model="search"
                        prepend-icon="mdi-search"
                        label="Search"
                        single-line
                        hide-details
                        ></v-text-field>
                    </v-card-title>
                    <v-data-table :loading="loading" :items="sjps.data" :headers="fields" :search="search" dense>
                        <template v-slot:item.status="{ item }">
                            <!-- <v-chip class="label label-default" v-if="item.status == 'OPEN'">Open</v-chip>
                            <v-chip class="label label-success" v-else-if="item.status == 'CLOSED'">Closed</v-chip> -->
                            <p v-if="item.status == 'OPEN'">Open</p>
                            <p class="text-blue" v-else-if="item.status == 'CLOSED'">Closed</p>
                        </template>

                        <template v-slot:item.distribution="{ item }">
                            <!-- <v-chip class="label label-default" v-if="item.status == 'OPEN'">Open</v-chip>
                            <v-chip class="label label-success" v-else-if="item.status == 'CLOSED'">Closed</v-chip> -->
                            <p v-if="item.distribution == 0">Main Distribution</p>
                            <p v-else-if="item.distribution == 1">Secondary Distribution</p>
                        </template>

                        <template v-slot:item.state="{ item }">
                            <!-- <v-chip class="label label-default" v-if="item.state == 0">Draft</v-chip>
                            <v-chip class="label label-success" v-else-if="item.state == 1">Send</v-chip>
                            <v-chip class="label label-primary" v-else>Received</v-chip> -->
                            <p v-if="item.state == 0">Draft</p>
                            <p class="text-green" v-else-if="item.state == 1">Send</p>
                            <p class="text-blue" v-else-if="item.state == 2">Received</p>
                            <p class="text-green" v-else-if="item.state == 3">Send Back</p>
                            <p class="text-blue" v-else-if="item.state == 4">Send Back Received </p>
                            <p class="text-red" v-else-if="item.state == 6">Sending Cancel </p>
                        </template>

                        <!-- <template  class="pa-5" v-slot:item.send="{ item }">
                            <router-link :to="{ name: 'sjpstatuss.add', params: {id: item.sjp_number} }" v-if="sjps.state == 0">
                                <v-btn color="success" small >Send</v-btn>
                            </router-link>
                        </template> -->
                        <template v-if="$can('create sjpstatuss') "  v-slot:item.send="{ item }">
                            <router-link :to="{ name: 'sjpstatuss.addsjp', params: {id: item.sjp_id} }" v-if="item.state == 0 && authenticated.reference_pool_pallet_id == item.departure_pool_pallet_id">
                                <v-btn color="primary" small>Send</v-btn>
                            </router-link>
                        </template>

                        <template v-if="$can('update sjps')" class="pa-5" v-slot:item.adjusment="{ item }">
                            <router-link :to="{ name: 'sjps.edit', params: {id: item.sjp_id} }" v-if="item.status == 'OPEN'"><v-btn color="success" small>Adjust</v-btn></router-link>
                        </template>

                        <template v-if="$can('update sjpsdest')" class="pa-5" v-slot:item.changedest="{ item }">
                            <router-link :to="{ name: 'sjps.editdestination', params: {id: item.sjp_id} }" v-if="item.status == 'OPEN' && item.state <= 2"><v-btn color="success" small>Change Dest</v-btn></router-link>
                        </template>

                        <template v-if="$can('update sjps')" class="pa-5" v-slot:item.cancel="{ item }">
                            <router-link :to="{ name: 'sjps.cancel', params: {id: item.sjp_id} }" v-if="item.status == 'OPEN' && item.state == 0"><v-btn color="primary" small>Cancel</v-btn></router-link>
                        </template>

                        <template v-if="$can('delete sjps')" class="pa-5" v-slot:item.delete="{ item }">
                            <v-btn color="error" @click="deleteSjp(item.sjp_id)" small>Delete</v-btn>
                        </template>
                    </v-data-table>
                    <div class="text-center">
                            <!-- <v-pagination
                            v-model="page"
                            :length="20"
                            :total-visible="10"
                            circle
                            ></v-pagination> -->
                        </div>
                     </v-card>
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <!-- <b-table striped hover bordered :items="sjps.data" :fields="fields" show-empty>


                    <template slot="actions" slot-scope="row">
                        <router-link :to="{ name: 'sjps.addsjpstat', params: {id: row.item.sjp_id} }" class="btn btn-warning btn-sm">Add SJP Status<i class="fa fa-pencil"></i></router-link>
                        <router-link :to="{ name: 'sjps.edit', params: {id: row.item.sjp_id} }" class="btn btn-warning btn-sm"><i class="fa fa-pencil"></i></router-link>
                        <button class="btn btn-danger btn-sm" @click="deleteSjp(row.item.sjp_id)"><i class="fa fa-trash"></i></button>
                    </template>
                </b-table>  -->
              	<!-- TABLE UNTUK MENAMPILKAN LIST CUSTOMER -->

                <!-- <div class="row">
                    <div class="col-md-6">
                        <p v-if="sjps.data"><i class="fa fa-bars"></i> {{ sjps.data.length }} item dari {{ sjps.meta.total }} total data</p>
                    </div> -->
                     <!-- <div class="col-md-6">
                        <div class="pull-right">
                            <b-pagination
                                v-model="page"
                                :total-rows="sjps.meta.total"
                                :per-page="sjps.meta.per_page"
                                aria-controls="sjps"
                                v-if="sjps.data && sjps.data.length > 0"
                                ></b-pagination>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>
    <!-- </div> -->
</template>

<script>
import { mapActions, mapState } from 'vuex'

export default {
    name: 'DataSjp',
    created() {
        this.getSjp().then((res) => {
                let row = res.data    
                let reference_pool_pallet_id = this.authenticated.reference_pool_pallet_id
                this.editPools(reference_pool_pallet_id)
            })
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            fields: [
                // { value: 'dept_pool', text: 'Departure Pool' },
                // { value: 'dest_pool', text: 'Destination Pool' },
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'vehicle_number', text: 'Vehicle Number' },
                // { value: 'driver_name', text: 'Driver Name' },
                // { value: 'transporter_name', text: 'Transporter Name' },
                { value: 'pallet_quantity', text: 'Pallet Quantity' },
                // { value: 'no_do', text: 'DO No' },
                // { value: 'product_name', text: 'Product' },
                // { value: 'packaging', text: 'Packaging' },
                // { value: 'product_quantity', text: 'Product QTY' },
                // { value: 'status', text: 'Status' },
                { value: 'state', text: 'State' },
                // { value: 'distribution', text: 'Distribution' },
                // { value: 'created_by', text: 'Created By' },
                // { value: 'adjust_by', text: 'Adjust By' },
                // { value: 'departure_time', text: 'Departure Time' },
                // { value: 'eta', text: 'ETA' },
                { value: 'send', text: 'Send Pallet' },
                { value: 'adjusment', text: 'SJP Adjusment' },
                { value: 'changedest', text: 'SJP Destination Change' },
                { value: 'cancel', text: 'SJP Cancel' },
                { value: 'delete', text: 'Delete' }

            ],
            search: ''
        }
    },
    computed: {
        ...mapState('sjp', {
            sjps: state => state.sjps //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjp', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
        ...mapState('pool', {
            pool: state => state.pool //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.sjp.page
            },
            set(val) {
                this.$store.commit('sjp/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getSjp() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getSjp(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('pool', ['editPools', 'updatePools']),
        ...mapActions('sjp', ['getSjp', 'removeSjp']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteSjp(id) {
            this.$swal({
                title: 'Are you sure?',
                text: "This will delete record Permanently!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!'
            }).then((result) => {
                if (result.value) {
                    this.removeSjp(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        },
        cancelSjp(id) {
            this.$swal({
                title: 'Are you sure?',
                text: "This will cancel Surat Jalan Pallet record!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!'
            }).then((result) => {
                if (result.value) {
                    this.removeSjp(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>
