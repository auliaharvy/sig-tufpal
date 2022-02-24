<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create transporters')" :to="{ name: 'transporters.add' }"><v-btn>Add Transporters</v-btn></router-link>
                <v-btn class="mx-2">
                    <download-excel
                    :data= "transporters.data"
                    :fields="json_fields"
                    :name="exportName">
                    Download Data
                    </download-excel>
                </v-btn>
            </div>
            <div class="panel-body">

              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                        Transporter
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
                        :loading="loading"
                        :headers="headers"
                        :items="transporters.data"
                        :search="search"
                        dense
                        >
                        <template v-slot:item.total="{ item }">
                            <!-- <v-chip class="label"  color="red"  v-if="item.good_pallet+item.filled_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet > item.pallet_quota">
                                {{ item.good_pallet + item.filled_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                            </v-chip>
                            <v-chip class="label label-success"  v-if="item.good_pallet+item.filled_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet < item.pallet_quota">
                                {{ item.good_pallet + item.filled_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                            </v-chip>
                            <v-chip class="label label-warning"  v-if="item.good_pallet+item.filled_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet == item.pallet_quota">
                                {{ item.good_pallet + item.filled_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                            </v-chip> -->
                            <v-chip class="label"  color="red"  v-if="item.good_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet > item.pallet_quota">
                                {{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                            </v-chip>
                            <v-chip class="label label-success"  v-if="item.good_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet < item.pallet_quota">
                                {{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                            </v-chip>
                            <v-chip class="label label-warning"  v-if="item.good_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet == item.pallet_quota">
                                {{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                            </v-chip>
                        </template>
                        <!-- <template v-slot:item.total="{ item }">
                        {{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                        </template> -->
                            <template v-if="$can('update transporters') " v-slot:item.update="{ item }">
                                <router-link :to="{ name: 'transporters.edit', params: {id: item.transporter_id} }">
                                    <v-btn color="success" small>Update</v-btn>
                                </router-link>
                            </template>
                            <template v-if="$can('delete transporters') " v-slot:item.delete="{ item }">
                                <v-btn color="error" small @click="deleteTransporters(item.transporter_id)">Delete</v-btn>
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
    name: 'DataTransporter',
    created() {
        this.getTransporters() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            exportName: 'Transporter ' + new Date ().toISOString().slice(0,10),
            json_fields: {
                'Transporter Name' : 'transporter_name',
                'Transporter Address' : 'transporter_address',
                'Good Pallet' : 'good_pallet',
                // 'Filled Pallet' : 'filled_pallet',
                'TBR Pallet' : 'tbr_pallet',
                'BER Pallet' : 'ber_pallet',
                'Missing Pallet' : 'missing_pallet',
                'Total Pallet' : 'total_pallet',
                'Pallet Quota' : 'pallet_quota',
            },
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                { value: 'transporter_name', text: 'Transporter Name' },
                { value: 'transporter_address', text: 'Transporter Address' },
                { value: 'good_pallet', text: 'Good Pallet' },
                // { value: 'filled_pallet', text: 'Filled Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'total', text: 'Total Pallet' },
                { value: 'pallet_quota', text: 'Pallet Quota' },
                { value: 'update', text: 'Update'},
                { value: 'delete', text: 'Delete'}
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('transporter', {
            transporters: state => state.transporters //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('transporter', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.transporter.page
            },
            set(val) {
                this.$store.commit('transporter/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getTransporters() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getTransporters(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('transporter', ['getTransporters', 'removeTransporters']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteTransporters(id) {
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
                    this.removeTransporters(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>
