<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create poolpallets')" :to="{ name: 'organizations.add' }"><v-btn>Add Organization</v-btn></router-link>
                <!-- <v-btn class="mx-2">
                    <download-excel
                    :data= "pools.data"
                    :fields="json_fields"
                    :name="exportName">
                    Download Data
                    </download-excel>
                </v-btn> -->
            </div>
            <div class="panel-body">

              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                <v-card>
                    <v-card-title>
                    Organization
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
                    :items="organizations.data"
                    :search="search"
                    dense
                    >
                    <template v-if="$can('update poolpallets') " v-slot:item.update="{ item }">
                      <router-link :to="{ name: 'organizations.edit', params: {id: item.organization_id} }">
                            <v-btn color="success" small>Update</v-btn>
                        </router-link>  
                    </template>
                    <template v-if="$can('delete poolpallets') " v-slot:item.delete="{ item }">  
                        <v-btn color="error" small @click="deleteOrganization(item.organization_id)">Delete</v-btn>
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
    name: 'DataOrganization',
    created() {
        this.getOrganization() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            exportName: 'Organization ' + new Date ().toISOString().slice(0,10),
            json_fields: {
                'Pool Name' : 'pool_name',
                'Code' : 'code',
                'Pool Address' : 'pool_address',
                'Good Pallet' : 'good_pallet',
                'TBR Pallet' : 'tbr_pallet',
                'BER Pallet' : 'ber_pallet',
                'Missing Pallet' : 'missing_pallet',
                'Total Pallet' : 'total_pallet',
                'Pallet Quota' : 'pallet_quota',
            },
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                // { value: 'organization_name', text: 'Organization' },
                { value: 'organization_name', text: 'Organization Name' },
                { value: 'organization_address', text: 'Organization Address' },
                { value: 'organization_email', text: 'Organization Email' },
                { value: 'phone_number', text: 'Phone Number' },
                { value: 'created_at', text: 'Created At' },
                { value: 'update', text: 'Update'},
                { value: 'delete', text: 'Delete'}
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('organization', {
            organizations: state => state.organizations //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('organization', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),

        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.organization.page
            },
            set(val) {
                this.$store.commit('organization/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getOrganization() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getOrganization(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('organization', ['getOrganization', 'removeOrganization']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteOrganization(id) {
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
                    this.removeOrganization(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        },
    }
}
</script>
