<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create bermissingpallets')" :to="{ name: 'bermissings.add' }"><v-btn>Add BER/Missing Pallet</v-btn></router-link>

            </div>
            <v-spacer />

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
                            BER/Missing Pallet
                            <v-spacer></v-spacer>
                            <v-btn color="success" small @click="isScanning()">Scan QR</v-btn>
                            <v-spacer></v-spacer>
                            <v-text-field
                            v-model="search"
                            append-icon="mdi-magnify"
                            label="Search"
                            single-line
                            hide-details
                            ></v-text-field>
                        </v-card-title>
                        <v-data-table
                        :headers="headers"
                        :loading="loading"
                        :items="bermissings.data"
                        :search="search"
                        dense
                        >
                            <template v-slot:item.reporter_prove="{ item }">
                                <img :src="'/storage/bermissing/reporter_prove/' + item.reporter_prove" :width="70" :height="100" :alt="item.bmp_number"> </img>
                                <v-btn dark color="success" text small :href="'/storage/bermissing/reporter_prove/' + item.reporter_prove" target="_blank">
                                    show
                                </v-btn>
                            </template>
                            <template v-slot:item.status="{ item }">
                                <!-- <v-chip class="label label-default" v-if="item.status == 0">DRAFT REPORTED</v-chip>
                                <v-chip class="label label-primary" v-if="item.status == 1">APPROVED</v-chip> -->
                                <!-- <span class="label label-primary" v-if="item.status == 0">SENDING</span>
                                <span class="label label-success" v-else-if="item.status == 1">RECEIVED</span> -->
                                <p v-if="item.status == 0">DRAFT REPORTED</p>
                                <p class="text-blue" v-if="item.status == 1">APPROVED</p>
                            </template>
                            <template v-slot:item.approve="{ item }">
                                <router-link :to="{ name: 'bermissings.edit', params: {id: item.ber_missing_pallet_id} }" v-if="item.status == 0 && $can('update bermissingpallets')" >
                                    <v-btn color="success" small>Approval</v-btn>
                                </router-link>
                            </template>
                            <template v-slot:item.view="{ item }">
                                <router-link :to="{ name: 'bermissings.view', params: {id: item.ber_missing_pallet_id} }" >
                                    <v-btn color="success" small>View</v-btn>
                                </router-link>
                            </template>

                            <template v-slot:item.delete="{ item }">
                                <v-btn v-if="$can('delete bermissingpallets')" color="error" small @click="deleteBermissings(item.ber_missing_pallet_id)">Delete</v-btn>
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

export default {
    name: 'DataBermissing',
    created() {
        this.getBermissing() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            scanner: false,
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                { value: 'bmp_number', text: 'BMP Number' },
                { value: 'pool_name', text: 'Pool Pallet' },
                { value: 'transporter_name', text: 'Transporter' },
                { value: 'reporter', text: 'Reporter Name' },
                { value: 'approver', text: 'Approver Name' },
                { value: 'sjps_number', text: 'Reference SJP Number' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'reporter_prove', text: 'Prove' },
                // { value: 'berita_acara', text: 'Berita Acara' },
                { value: 'status', text: 'Status' },
                { value: 'note', text: 'Note' },
                { value: 'approve', text: 'Approve'},
                { value: 'view', text: 'View'},
                { value: 'delete', text: 'Delete'},
            ],
            search: '',
        }
    },
    computed: {
        ...mapState('bermissing', {
            bermissings: state => state.bermissings //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('bermissing', {
            bermissing: state => state.bermissing //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('bermissing', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.bermissing.page
            },
            set(val) {
                this.$store.commit('bermissing/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getBermissing() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getBermissing(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('bermissing', ['getBermissing', 'removeBermissing']),
        showimage(id) {
            this.dialog=true
        },
        isScanning(){
            this.scanner = true
        },
        onDecode (decodedString) {
          console.log(decodedString)
          this.search = decodedString
          this.scanner = false
        },
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteBermissings(id) {
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
                    this.removeBermissing(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>
