<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create sjpstatuss')" :to="{ name: 'sjpstatuss.add' }"><v-btn>Add SJP Status</v-btn></router-link>
            </div>
            <!-- <template>
                <qrcode-stream></qrcode-stream>
            </template> -->
            <div class="panel-body">
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                            Surat Jalan Pallet Status
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
                        :items="sjpstatuss.data"
                        :search="search"
                        >       
                        <template v-slot:item.status="{ item }">
                            <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
                            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip>
                        </template>

                        <template v-if="$can('update sjpstatuss')" v-slot:item.receive="{ item }">
                            <router-link v-if="item.status == 0 && authenticated.reference_pool_pallet_id == item.destination_pool_pallet_id " :to="{ name: 'sjpstatuss.edit', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receive</v-btn>   
                            </router-link>             
                        </template>

                        <template v-if="$can('create sjpstatuss')" v-slot:item.send_back="{ item }">
                            <router-link v-if="item.transaction == 'SEND' && item.status == 1" :to="{ name: 'sjpstatuss.sendback', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Send Back</v-btn>
                            </router-link>                       
                        </template>
                        
                        <template v-if="$can('delete sjps')" v-slot:item.delete="{ item }">
                                <v-btn color="error" @click="deleteSjpStatus(item.sjp_status_id)" small>Delete</v-btn>                     
                        </template>
                        <!-- <template v-slot:item.qrcode="{ item }">
                            <qrcode-vue :value="sjpstatuss.sjps_number" :size="size" level="H"></qrcode-vue>                    
                        </template> -->
                        </v-data-table>
                    </v-card>
                </template>
            </div>
        </div>
    </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

export default {
    name: 'DataSjpStatus',
    created() {
        this.getSjpStatuss() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                { value: 'checker_sender', text: 'Checker Sender' },
                { value: 'checker_receiver', text: 'Checker Receive' },
                { value: 'sjp_number', text: 'SJP' },
                { value: 'sjps_number', text: 'SJP Status' },
                { value: 'transaction', text: 'Transaction' },
                { value: 'status', text: 'Status' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'good_cement', text: 'Good Cement' },
                { value: 'bad_cement', text: 'Bad Cement' },
                { value: 'note', text: 'Note' },
                // { value: 'qrcode', text: 'QR Code' },
                // { value: 'created_at', text: 'Send at' },
                // { value: 'updated_at', text: 'Received at' },
                { value: 'receive', text: 'Receive'},
                { value: 'send_back', text: 'Send Back'},
                { value: 'delete', text: 'Delete'}
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('sjpstatus', {
            sjpstatuss: state => state.sjpstatuss //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.sjpstatus.page
            },
            set(val) {
                this.$store.commit('sjpstatus/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getSjpStatuss() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getSjpStatuss(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('sjpstatus', ['getSjpStatuss', 'removeSjpStatus']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteSjpStatus(id) {
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
                    this.removeSjpStatus(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>