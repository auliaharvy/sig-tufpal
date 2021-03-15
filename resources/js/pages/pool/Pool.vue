<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create poolpallets')" :to="{ name: 'pools.add' }"><v-btn>Add Pool Pallet</v-btn></router-link>
                <v-btn class="mx-2">
                    <download-excel
                    :data= "pools.data"
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
                    Pool Pallet
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
                    :items="pools.data"
                    :search="search"
                    dense
                    >
                    <template v-slot:item.total="{ item }">
                        <v-chip class="label"  color="red"  v-if="item.good_pallet+item.filled_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet > item.pallet_quota">
                            {{ item.good_pallet + item.filled_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                        </v-chip>
                        <v-chip class="label label-success"  v-if="item.good_pallet+item.filled_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet < item.pallet_quota">
                            {{ item.good_pallet + item.filled_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                        </v-chip>
                        <v-chip class="label label-warning"  v-if="item.good_pallet+item.filled_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet == item.pallet_quota">
                            {{ item.good_pallet + item.filled_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                        </v-chip>
                    </template>
                    <template v-if="$can('update poolpallets') " v-slot:item.update="{ item }">
                      <router-link :to="{ name: 'pools.edit', params: {id: item.pool_pallet_id} }">
                            <v-btn color="success" small>Update</v-btn>
                        </router-link>  
                    </template>
                    <template v-if="$can('delete poolpallets') " v-slot:item.delete="{ item }">  
                        <v-btn color="error" small @click="deletePools(item.pool_pallet_id)">Delete</v-btn>
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
    name: 'DataPool',
    created() {
        this.getPools() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            exportName: 'Pool Pallet ' + new Date ().toISOString().slice(0,10),
            json_fields: {
                'Pool Name' : 'pool_name',
                'Code' : 'code',
                'Pool Address' : 'pool_address',
                'Good Pallet' : 'good_pallet',
                'Filled Pallet' : 'filled_pallet',
                'TBR Pallet' : 'tbr_pallet',
                'BER Pallet' : 'ber_pallet',
                'Missing Pallet' : 'missing_pallet',
                'Total Pallet' : 'total_pallet',
                'Pallet Quota' : 'pallet_quota',
            },
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                // { value: 'organization_name', text: 'Organization' },
                { value: 'pool_name', text: 'Pool Name' },
                { value: 'code', text: 'Pool Code' },
                { value: 'type', text: 'Pool Type' },
                { value: 'pool_address', text: 'Pool Address' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'filled_pallet', text: 'Filled Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'total', text: 'Total Pallet' },
                { value: 'pallet_quota', text: 'Pallet Quota' },
                { value: 'update', text: 'Update'},
                { value: 'delete', text: 'Delete'}
            ],
            total: null,
            search: ''
        }
    },
    computed: {
        ...mapState('pool', {
            pools: state => state.pools //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('pool', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),

        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.pool.page
            },
            set(val) {
                this.$store.commit('pool/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getPools() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getPools(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('pool', ['getPools', 'removePools']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deletePools(id) {
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
                    this.removePools(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        },
    }
}
</script>
