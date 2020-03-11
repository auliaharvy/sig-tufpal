<template>
    <div class="col-md-12">
        <div class="panel">
            
            <div class="panel-body">
              
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                        SJP PALLET RECEIVE
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
                        :items="sjppalletreceives.data"
                        :search="search"
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
    name: 'DataSjpPalletReceive',
    created() {
        this.getSjpPalletReceive() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
             headers: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'sjp_status', text: 'SJP Status' },
                { value: 'receiver', text: 'Receiver' },
                { value: 'departure_pool', text: 'Departure' },
                { value: 'destination_pool', text: 'Destination' },
                { value: 'transporter', text: 'Transporter' },
                { value: 'driver', text: 'Driver' },
                { value: 'vehicle', text: 'Vehicle' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'good_cement', text: 'Good Cement' },
                { value: 'bad_cement', text: 'Bad Cement' },
                { value: 'note', text: 'Note' },
                { value: 'created_at', text: 'Send At' },          
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('sjppalletreceive', {
            sjppalletreceives: state => state.sjppalletreceives //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.sjppalletreceive.page
            },
            set(val) {
                this.$store.commit('sjppalletreceive/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getSjpPalletReceive() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getSjpPalletReceive(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('sjppalletreceive', ['getSjpPalletReceive']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        
    }
}
</script>