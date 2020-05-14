<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create transporters')" :to="{ name: 'transporters.add' }"><v-btn>Add Transporters</v-btn></router-link>
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
        <!-- <template v-slot:item.actions="{ item }">
            <router-link :to="{ name: 'transporters.edit', params: {id: item.transporter_id} }">
                <v-btn color="success" small>Update</v-btn>
            </router-link>
            <v-btn color="error" small @click="deleteTransporter(item.transporter_id)">Delete</v-btn>
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
    name: 'DataTransporter',
    created() {
        this.getTransporters() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                { value: 'transporter_name', text: 'Transporter Name' },
                { value: 'transporter_address', text: 'Transporter Address' },

                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'total', text: 'Total Pallet' },
                { value: 'pallet_quota', text: 'Pallet Quota' },
                // { value: 'actions', text: 'Action'}
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
