<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create transporter adjusment')" :to="{ name: 'transporteradjusments.add' }"><v-btn>Transporter Adjusment</v-btn></router-link>
            </div>
            <div class="panel-body">
                <!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                            Transporter Adjusment Record
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
                        :items="transporterAdjusments.data"
                        :search="search"
                        dense
                        >
                        <template v-slot:item.is_from_pool="{ item }">
                                <p v-if="item.is_from_pool == 0">Pool Pallet to Transporter</p>
                                <p v-else-if="item.is_from_pool == 1">Transporter to Pool</p>
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
    name: 'DataTransporterAdjusment',
    created() {
        this.getTransporterAdjusment() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                { value: 'ta_number', text: 'TA Number' },
                { value: 'name', text: 'Reporter' },
                { value: 'pool_name', text: 'Pool Pallet' },
                { value: 'transporter_name', text: 'Transporter' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'is_from_pool', text: 'Adjust Type' },
                { value: 'reason', text: 'Reason' },
                { value: 'note', text: 'Note' },
                { value: 'created_at', text: 'Created At' },
                
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('transporterAdjusment', {
            transporterAdjusments: state => state.transporterAdjusments //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('transporterAdjusment', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.transporterAdjusments.page
            },
            set(val) {
                this.$store.commit('transporterAdjusments/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getTransporterAdjusment() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getTransporterAdjusment(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('transporterAdjusment', ['getTransporterAdjusment', 'removeTransporterAdjusment']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteTransporterAdjusment(id) {
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
                    this.removeTransporterAdjusment(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>
