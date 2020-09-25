<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link :to="{ name: 'newpallets.add' }"><v-btn>Add New Pallet</v-btn></router-link>
            </div>
            <div class="panel-body">

                <!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                    <v-card>
                        <v-card-title>
                            New Pallet Record
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
                        :items="newpallets.data"
                        :search="search"
                        dense
                        >
                        <template v-if="$can('update newpallet')" class="pa-5" v-slot:item.cancel="{ item }">
                            <router-link :to="{ name: 'newpallets.cancel', params: {id: item.new_pallet_id} }" v-if="item.status == 0"><v-btn color="primary" small>Cancel</v-btn></router-link>
                        </template>
        <!-- <template v-slot:item.approve="{ item }">
            <router-link :to="{ name: 'bermissings.edit', params: {id: item.ber_missing_pallet_id} }">
                <v-btn color="success" small>Approve</v-btn>
            </router-link>
        </template>
        <template v-slot:item.delete="{ item }">
            <v-btn color="error" small @click="deleteBermissing(item.ber_missing_pallet_id)">Delete</v-btn>
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
    name: 'DataNewpallet',
    created() {
        this.getNewpallet() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                { value: 'np_number', text: 'BMP Number' },
                { value: 'name', text: 'Adder' },
                { value: 'pool_name', text: 'Pool Pallet' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'vendor', text: 'Vendor' },
                { value: 'vehicle', text: 'Vehicle Number' },
                { value: 'driver', text: 'Driver' },
                { value: 'created_at', text: 'Created At' },
                { value: 'note', text: 'Note' },
                { value: 'cancel', text: 'Cancel' },
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('newpallet', {
            newpallets: state => state.newpallets //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('newpallet', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.newpallet.page
            },
            set(val) {
                this.$store.commit('newpallet/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getNewpallet() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getNewpallet(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('newpallet', ['getNewpallet', 'removeNewpallet']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteNewpallet(id) {
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
                    this.removeNewpallet(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        }
    }
}
</script>
