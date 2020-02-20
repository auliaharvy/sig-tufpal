<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link :to="{ name: 'sjps.add' }" class="v-btn btn-primary text-black"><v-btn>Add SJP</v-btn></router-link>
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
                    <v-data-table :items="sjps.data" :headers="fields" :search="search">
                        <template class="pa-5" v-slot:item.actions="{ item }">
                            <router-link :to="{ name: 'sjpstatuss.add', params: {id: item.sjp_id} }"><v-btn color="success">Send</v-btn></router-link>
                    
                            <v-btn color="error" @click="deleteSjp(item.sjp_id)">Delete</v-btn>                        
                        </template>
                    </v-data-table>
                     </v-card>
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <!-- <b-table striped hover bordered :items="sjps.data" :fields="fields" show-empty>
                    
                    
                    <template slot="actions" slot-scope="row">
                        <router-link :to="{ name: 'sjps.addsjpstat', params: {id: row.item.sjp_id} }" class="btn btn-warning btn-sm">Add SJP Status<i class="fa fa-pencil"></i></router-link>
                        <router-link :to="{ name: 'sjps.edit', params: {id: row.item.sjp_id} }" class="btn btn-warning btn-sm"><i class="fa fa-pencil"></i></router-link>
                        <button class="btn btn-danger btn-sm" @click="deleteSjp(row.item.sjp_id)"><i class="fa fa-trash"></i></button>
                    </template>
                </b-table> -->
              	<!-- TABLE UNTUK MENAMPILKAN LIST CUSTOMER -->

                <div class="row">
                    <!-- <div class="col-md-6">
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
    </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

export default {
    name: 'DataSjp',
    created() {
        this.getSjp() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            fields: [
                { value: 'dept_pool', text: 'Departure Pool' },
                { value: 'dest_pool', text: 'Destination Pool' },
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'vehicle_number', text: 'Vehicle Number' },
                { value: 'driver_name', text: 'Driver Name' },
                { value: 'transporter_name', text: 'Transporter Name' },
                { value: 'pallet_quantity', text: 'Pallet Quantity' },
                { value: 'no_do', text: 'DO No' },
                { value: 'product_name', text: 'Product' },
                { value: 'packaging', text: 'Packaging' },
                { value: 'product_quantity', text: 'Product QTY' },
                { value: 'status', text: 'Status' },
                { value: 'departure_time', text: 'Departure Time' },
                { value: 'eta', text: 'ETA' },
                { value: 'actions', text: 'Action' }
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('sjp', {
            sjps: state => state.sjps //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
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
        ...mapActions('sjp', ['getSjp', 'removeSjp']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteSjp(id) {
            this.$swal({
                title: 'Kamu Yakin?',
                text: "Tindakan ini akan menghapus secara permanent!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Iya, Lanjutkan!'
            }).then((result) => {
                if (result.value) {
                    this.removeSjp(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>