<template>
    <div class="col-md-12">
        <div class="panel">
            <!-- <div class="panel-heading">
                <router-link v-if="$can('create sjpstatuss')" :to="{ name: 'sjpstatuss.add' }"><v-btn>Add SJP Status</v-btn></router-link>
            </div> -->
            <!-- <template>
                <qrcode-stream></qrcode-stream>
            </template> -->
            <div class="panel-body">
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-dialog
                    v-model="scanner"
                    max-width="500"
                    >
                    <qrcode-stream @decode="onDecode"></qrcode-stream>
                    </v-dialog>
                    <v-card>
                        <v-card-title>
                            Surat Jalan Pallet Status
                            <v-spacer></v-spacer>
                            <v-btn color="success" small @click="isScanning()">Scan QR</v-btn>
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
                        :loading="loading"
                        :items="sjpstatuss.data"
                        :search="search"
                        dense
                        >
                        <template v-slot:item.status_sjps="{ item }">
                            <!-- <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
                            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip> -->
                            <p class="text-green" v-if="item.status_sjps == 0">Sending</p>
                            <p class="text-blue" v-else-if="item.status_sjps == 1">Received</p>
                        </template>
                        <template v-slot:item.transaction_id="{ item }">
                            <!-- <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
                            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip> -->
                            <p class="text-black" v-if="item.transaction_id == 1">SEND</p>
                            <p class="text-black" v-else-if="item.transaction_id == 2">SEND_BACK</p>
                        </template>

                        <template v-if="$can('update sjpstatuss')" v-slot:item.receive="{ item }">
                            <router-link v-if="item.status_sjps == 0 && item.transaction_id == 1 && item.distribution == 0 &&  authenticated.reference_pool_pallet_id == item.destination_pool_pallet_id " :to="{ name: 'sjpstatuss.edit', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receive</v-btn>
                            </router-link>
                            <router-link v-if="item.status_sjps == 0 && item.transaction_id == 1 && item.distribution == 1  " :to="{ name: 'sjpstatuss.edit', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receive</v-btn>
                            </router-link>
                            <router-link v-if="item.status_sjps == 0 && item.transaction_id == 1 && item.distribution == 2 &&  authenticated.reference_pool_pallet_id == item.destination_pool_pallet_id " :to="{ name: 'sjpstatuss.edit2nddist', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receive</v-btn>
                            </router-link>
                            <router-link v-if="item.status_sjps == 0 && item.transaction_id == 1 &&  item.distribution == 3 " :to="{ name: 'sjpstatuss.edit', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receive</v-btn>
                            </router-link>

                            <router-link v-else-if="item.status_sjps == 0 && item.transaction_id == 2  && authenticated.reference_pool_pallet_id == item.departure_pool_pallet_id " :to="{ name: 'sjpstatuss.editsendback', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receive Sendback</v-btn>
                            </router-link>

                            <router-link v-else-if="item.status_sjps == 0 && item.transaction_id == 2 && item.distribution == 1 " :to="{ name: 'sjpstatuss.editsendback', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receive Sendback</v-btn>
                            </router-link>
                        </template>

                        <template v-if="$can('create sjpstatuss') " v-slot:item.send_back="{ item }">
                            <router-link v-if="item.transaction_id == 1 && item.status_sjps == 1 && item.is_sendback == 0 && authenticated.reference_pool_pallet_id == item.destination_pool_pallet_id" :to="{ name: 'sjpstatuss.sendback', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Send Back</v-btn>
                            </router-link>

                            <router-link v-if="item.transaction_id == 1 && item.status_sjps == 1 && item.distribution == 1 && item.is_sendback == 0" :to="{ name: 'sjpstatuss.sendback', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Send Back</v-btn>
                            </router-link>
                        </template>

                        <template v-if="$can('update sjpstatuss') " v-slot:item.approval="{ item }">
                            <router-link v-if="item.driver_approve == 0 && authenticated.reference_pool_pallet_id == item.departure_pool_pallet_id" :to="{ name: 'sjpstatussend.approval', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Sending Approval</v-btn>
                            </router-link>

                            <router-link v-if="item.driver_approve == 1 && authenticated.reference_pool_pallet_id == item.destination_pool_pallet_id" :to="{ name: 'sjpstatuss.sendback', params: {id: item.sjp_status_id} }">
                                <v-btn color="success" small>Receiving Approval</v-btn>
                            </router-link>
                        </template>

                        <template v-slot:item.view="{ item }">
                            <router-link :to="{ name: 'sjpstatuss.view', params: {id: item.sjp_status_id} }" >
                                <v-btn color="success" small>View</v-btn>
                            </router-link>
                        </template>

                        <template v-if="$can('delete sjps')" v-slot:item.delete="{ item }">
                                <v-btn color="error" @click="deleteSjpStatus(item.sjp_status_id)" small>Delete</v-btn>
                        </template>
                        <!-- <template v-slot:item.image="{ item }">
                                <img :src="'/storage/app/public/driverapproval/' + item.sending_driver_approval" :width="70" :height="100" :alt="item.bmp_number"> </img>
                                <v-btn dark color="success" text small :href="'/storage/app/public/driverapproval/' + item.sending_driver_approval" target="_blank">
                                    show
                                </v-btn>
                        </template> -->
                        <!-- <template v-slot:item.qrcode="{ item }">
                            <qrcode-vue :value="sjpstatuss.sjps_number" :size="size" level="H"></qrcode-vue>
                        </template> -->
                        </v-data-table>
                        <!-- <div class="text-center">
                            <v-pagination
                            v-model="page"
                            :length="20"
                            :total-visible="10"
                            circle
                            ></v-pagination>
                        </div> -->
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
        this.getSjpStatuss()
    },
    data() {
        return {
            scanner: false,
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                // { value: 'dept_pool', text: 'Departure' },
                // { value: 'checker_sender', text: 'Checker Sender' },
                // { value: 'dest_pool', text: 'Destination' },
                // { value: 'checker_receiver', text: 'Checker Receive' },
                { value: 'sjp_number', text: 'SJP' },
                // { value: 'transporter_name', text: 'Transporter' },
                { value: 'vehicle_id', text: 'Vehicle' },
                // { value: 'sjps_number', text: 'SJP Status' },
                { value: 'transaction_id', text: 'SJP Status' },
                { value: 'status_sjps', text: 'Status' },
                // { value: 'good_pallet', text: 'Good Pallet' },
                // { value: 'tbr_pallet', text: 'TBR Pallet' },
                // { value: 'ber_pallet', text: 'BER Pallet' },
                // { value: 'missing_pallet', text: 'Missing Pallet' },
                // { value: 'good_cement', text: 'Good Cement' },
                // { value: 'bad_cement', text: 'Bad Cement' },
                { value: 'note_sjps', text: 'Note' },
                // { value: 'image', text: 'Image' },
                { value: 'view', text: 'View' },
                // { value: 'driver_approve', text: 'Note' },
                // { value: 'qrcode', text: 'QR Code' },
                // { value: 'created_at', text: 'Send at' },
                // { value: 'updated_at', text: 'Received at' },
                // { value: 'approval', text: 'Approval'},
                { value: 'receive', text: 'Receive'},
                { value: 'send_back', text: 'Send Back'},
                { value: 'delete', text: 'Delete'}
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('sjpstatus', {
            sjpstatuss: state => state.sjpstatuss
        }),
        ...mapState('sjpstatus', {
            sjpstatus: state => state.sjpstatus
        }),
        ...mapState('sjpstatus', {
            loading: state => state.loading
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
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
        isScanning(){
            this.scanner = true
        },
        onDecode (decodedString) {
          console.log(decodedString)
          this.search = decodedString
          this.scanner = false
        },
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
