<template>
    <div class="col-md-12">
        <div class="panel">
            
            <div class="panel-body">
              
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                        PALLET TRANSFER SEND
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
                        :items="pallettransfersends.data"
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
    name: 'DataSjpPalletSend',
    created() {
        this.getTransferPalletSend() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
             headers: [
                { value: 'tp_number', text: 'TP Number' },
                { value: 'pallet_transfer_status', text: 'Transfer Status' },
                { value: 'sender', text: 'Sender' },
                { value: 'departure_pool', text: 'Departure' },
                { value: 'destination_pool', text: 'Destination' },
                { value: 'transporter', text: 'Transporter' },
                { value: 'driver', text: 'Driver' },
                { value: 'vehicle', text: 'Vehicle' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'note', text: 'Note' },
                { value: 'created_at', text: 'Send At' },          
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('pallettransfersend', {
            pallettransfersends: state => state.pallettransfersends //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.pallettransfer.page
            },
            set(val) {
                this.$store.commit('pallettransfersend/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getTransferPalletSend() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getTransferPalletSend(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('pallettransfersend', ['getTransferPalletSend']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        
    }
}
</script>