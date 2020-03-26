<template>
    <div class="col-md-12">
        <div class="panel">
            
            <div class="panel-body">
              
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                        SJP Pallet Send
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchsjppallletsend"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headersjppalletsend"
                        :items="sjppalletsends.data"
                        :search="searchsjppallletsend"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        SJP Pallet Receive
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchsjppallletreceive"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headersjppalletreceive"
                        :items="sjppalletreceives.data"
                        :search="searchsjppallletreceive"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        SJP Adjusment
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchsjpadjusment"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headersjpadjusment"
                        :items="sjpadjusments.data"
                        :search="searchsjpadjusment"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        SJP Change Destination
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchsjpchangedest"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headersjpchangedest"
                        :items="sjpchangedestinations.data"
                        :search="searchsjpchangedest"
                        >        
                        </v-data-table>
                    </v-card>
                </template>
                <v-divider />
                <template>
                    <v-card>
                        <v-card-title>
                        Pallet Transfer Send
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchtransferpalletsend"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headertransferpalletsend"
                        :items="pallettransfersends.data"
                        :search="searchtransferpalletsend"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        Pallet Transfer Receive
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchtransferpalletreceive"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headertransferpalletreceive"
                        :items="pallettransferreceives.data"
                        :search="searchtransferpalletreceive"
                        >        
                        </v-data-table>
                    </v-card>
                </template>

                <v-divider />

                <template>
                    <v-card>
                        <v-card-title>
                        BER/Missing Pallet Reported
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchbermissingpalletreported"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headerbermissingpalletreported"
                        :items="bermissingpalletreporteds.data"
                        :search="searchbermissingpalletreported"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        BER/Missing Pallet Approved
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchbermissingpalletapproved"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headerbermissingpalletapproved"
                        :items="bermissingpalletapproveds.data"
                        :search="searchbermissingpalletapproved"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        BER/Missing Pallet Disapproved
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchbermissingpalletdisapproved"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headerbermissingpalletdisapproved"
                        :items="bermissingpalletdisapproveds.data"
                        :search="searchbermissingpalletdisapproved"
                        >        
                        </v-data-table>
                    </v-card>
                </template>

                <v-divider />

                <template>
                    <v-card>
                        <v-card-title>
                        Damaged Pallet
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchdamagedpallet"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headerdamagedpallet"
                        :items="damagedpallets.data"
                        :search="searchdamagedpallet"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        Repaired Pallet
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchrepairedpallet"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headerrepairedpallet"
                        :items="repairedpallets.data"
                        :search="searchrepairedpallet"
                        >        
                        </v-data-table>
                    </v-card>
                    <v-divider />
                    <v-card>
                        <v-card-title>
                        New Pallet
                        <v-spacer></v-spacer>
                        <v-text-field
                            v-model="searchnewpallet"
                            prepend-icon="mdi-search"
                            label="Search"
                            single-line
                            hide-details
                        ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headernewpallet"
                        :items="newpallets.data"
                        :search="searchnewpallet"
                        >        
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
    name: 'DataAllTransaction',
    created() {
        this.getSjpPalletSend();
        this.getSjpPalletReceive();
        this.getSjpadjusment();
        this.getSjpchangedestination();
        this.getTransferPalletSend();
        this.getTransferPalletReceive();
        this.getBerMissingPalletReported();
        this.getBerMissingPalletApproved();
        this.getBerMissingPalletDisapproved();
        this.getDamagedpallet();
        this.getRepairedpallet();
        this.getNewpallet();
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
             headersjppalletsend: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'sjp_status', text: 'SJP Status' },
                { value: 'sender', text: 'Sender' },
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
            searchsjppallletsend: '',

            headersjppalletreceive: [
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
            searchsjppallletreceive: '',

            headersjpadjusment: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'vehicle', text: 'Old Vehicle' },
                { value: 'new_vehicle', text: 'New Vehicle' },
                { value: 'driver', text: 'Old Driver' },
                { value: 'new_driver', text: 'New Driver' },
                { value: 'adjust_by', text: 'Adjust By' },
                { value: 'created_at', text: 'Adjust At' },
            ],
            searchsjpadjusment: '',

            headersjpchangedest: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'no_do', text: 'Old Dispatch No' },
                { value: 'new_no_do', text: 'New Dispatch No' },
                { value: 'destination', text: 'Old Destination' },
                { value: 'new_destination', text: 'New Destination' },
                { value: 'adjust_by', text: 'Change By' },
                { value: 'created_at', text: 'Change At' }, 
            ],
            searchsjpchangedest: '',

            headertransferpalletsend: [
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
            searchtransferpalletsend: '',

            headertransferpalletreceive: [
                { value: 'tp_number', text: 'TP Number' },
                { value: 'pallet_transfer_status', text: 'Transfer Status' },
                { value: 'receiver', text: 'Receiver' },
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
            searchtransferpalletreceive: '',

            headerbermissingpalletreported: [
                { value: 'bmp_number', text: 'BMP Number' },
                { value: 'status', text: 'Status' },
                { value: 'reporter', text: 'Reporter' },
                { value: 'pool_pallet', text: 'Pool Pallet' },
                { value: 'transporter', text: 'Transporter' },
                { value: 'reference_sjp_status', text: 'Reference SJP Status' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'reporter_prove', text: 'Berita Acara' },
                { value: 'note', text: 'Note' },
                { value: 'created_at', text: 'Report At' },
            ],
            searchbermissingpalletreported: '',

            headerbermissingpalletapproved: [
                { value: 'bmp_number', text: 'BMP Number' },
                { value: 'status', text: 'Status' },
                { value: 'approver', text: 'Approver' },
                { value: 'pool_pallet', text: 'Pool Pallet' },
                { value: 'transporter', text: 'Transporter' },
                { value: 'reference_sjp_status', text: 'Reference SJP Status' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'reporter_prove', text: 'Berita Acara' },
                { value: 'note', text: 'Note' },
                { value: 'created_at', text: 'Report At' },
            ],
            searchbermissingpalletapproved: '',

            headerbermissingpalletdisapproved: [
                { value: 'bmp_number', text: 'BMP Number' },
                { value: 'status', text: 'Status' },
                { value: 'disapprover', text: 'Disapprover' },
                { value: 'pool_pallet', text: 'Pool Pallet' },
                { value: 'transporter', text: 'Transporter' },
                { value: 'reference_sjp_status', text: 'Reference SJP Status' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'reporter_prove', text: 'Berita Acara' },
                { value: 'note', text: 'Note' },
                { value: 'created_at', text: 'Report At' },
            ],
            searchbermissingpalletdisapproved: '',

            headerdamagedpallet: [
                { value: 'dp_number', text: 'DP Number' },
                { value: 'name', text: 'Reporter' },
                { value: 'pool_name', text: 'Pool Pallet' },
                { value: 'transporter_name', text: 'Transporter' },
                { value: 'sjps_number', text: 'SJPS Number' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'note', text: 'Note' },
            ],
            searchdamagedpallet: '',

            headerrepairedpallet: [
                { value: 'rp_number', text: 'RP Number' },
                { value: 'name', text: 'Reporter' },
                { value: 'pool_name', text: 'Pool Pallet' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'note', text: 'Note' },
            ],
            searchrepairedpallet: '',

            headernewpallet: [
                { value: 'np_number', text: 'BMP Number' },
                { value: 'name', text: 'Adder' },
                { value: 'pool_name', text: 'Pool Pallet' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'vendor', text: 'Vendor' },
                { value: 'vehicle', text: 'Vehicle Number' },
                { value: 'driver', text: 'Driver' },
                { value: 'created_at', text: 'Created At' },
                { value: 'note', text: 'Note' },
            ],
            searchnewpallet: '',

            
        }
    },
    computed: {
        ...mapState('sjppalletsend', {
            sjppalletsends: state => state.sjppalletsends //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjppalletreceive', {
            sjppalletreceives: state => state.sjppalletreceives //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjpadjusment', {
            sjpadjusments: state => state.sjpadjusments //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjpchangedestination', {
            sjpchangedestinations: state => state.sjpchangedestinations //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pallettransfersend', {
            pallettransfersends: state => state.pallettransfersends //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pallettransferreceive', {
            pallettransferreceives: state => state.pallettransferreceives //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('bermissingreported', {
            bermissingpalletreporteds: state => state.bermissingpalletreporteds //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('bermissingapproved', {
            bermissingpalletapproveds: state => state.bermissingpalletapproveds //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('bermissingdisapproved', {
            bermissingpalletdisapproveds: state => state.bermissingpalletdisapproveds //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('damagedpallet', {
            damagedpallets: state => state.damagedpallets //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('repairedpallet', {
            repairedpallets: state => state.repairedpallets //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('newpallet', {
            newpallets: state => state.newpallets //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.alltransaction.page
            },
            set(val) {
                this.$store.commit('alltransaction/SET_PAGE', val)
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
        ...mapActions('sjppalletsend', ['getSjpPalletSend']),
        ...mapActions('sjpadjusment', ['getSjpadjusment']),
        ...mapActions('sjpchangedestination', ['getSjpchangedestination']), 
        ...mapActions('sjppalletreceive', ['getSjpPalletReceive']), 
        ...mapActions('pallettransfersend', ['getTransferPalletSend']),
        ...mapActions('pallettransferreceive', ['getTransferPalletReceive']),
        ...mapActions('bermissingreported', ['getBerMissingPalletReported']),  
        ...mapActions('bermissingapproved', ['getBerMissingPalletApproved']),  
        ...mapActions('bermissingdisapproved', ['getBerMissingPalletDisapproved']), 
        ...mapActions('damagedpallet', ['getDamagedpallet', 'removeDamagedpallet']),
        ...mapActions('repairedpallet', ['getRepairedpallet', 'removeRepairedpallet']),
        ...mapActions('newpallet', ['getNewpallet', 'removeNewpallet']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        
    }
}
</script>