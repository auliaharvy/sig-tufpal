<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link :to="{ name: 'sjpstatuss.add' }"><v-btn>Add SJP Status</v-btn></router-link>
            </div>
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
        <template v-slot:item.actions="{ item }">
            <router-link :to="{ name: 'sjpstatuss.edit', params: {id: item.sjp_status_id} }">
                <v-btn color="success" small>Receive</v-btn>
            </router-link>
            <v-btn color="error" small @click="deleteSjpStatus(item.sjp_status_id)">Delete</v-btn>                         
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
    name: 'DataSjpStatus',
    created() {
        this.getSjpStatus() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                { value: 'checker_sender', text: 'Checker Sender' },
                { value: 'checker_receiver', text: 'Checker Receive' },
                { value: 'sjp_number', text: 'SJP' },
                { value: 'transaction', text: 'Transaction' },
                { value: 'status', text: 'Status' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'good_cement', text: 'Good Cement' },
                { value: 'bad_cement', text: 'Bad Cement' },
                { value: 'note', text: 'Note' },
                { value: 'actions', text: 'Action'}
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('sjpstatus', {
            sjpstatuss: state => state.sjpstatuss //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
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
            this.getSjpStatus() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getSjpStatus(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('sjpstatus', ['getSjpStatus', 'removeSjpStatus']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteSjpStatus(id) {
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
                    this.removeSjpStatus(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>