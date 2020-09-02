<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create driver')" :to="{ name: 'drivers.add' }"><v-btn>Add Driver</v-btn></router-link>
                <v-btn class="mx-2">
                    <download-excel
                    :data= "drivers.data"
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
                    Driver
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
                    :items="drivers.data"
                    :search="search"
                    dense
                    >
                        <template v-slot:item.actions="{ item }">
                            <router-link :to="{ name: 'drivers.edit', params: {id: item.driver_id} }">
                                <v-btn color="success" small>Update</v-btn>
                            </router-link>
                            <v-btn color="error" small @click="deleteDrivers(item.driver_id)">Delete</v-btn>
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
    name: 'DataDriver',
    created() {
        this.getDrivers() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            exportName: 'Driver ' + new Date ().toISOString().slice(0,10),
            json_fields: {
                'Transporter Name' : 'transporter_name',
                'Driver ID' : 'driver_id',
                'Driver Name' : 'driver_name',
                'Mobile Number' : 'mobile_number',
            },
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                // { value: 'organization_name', text: 'Organization' },
                { value: 'transporter_name', text: 'Transporter' },
                { value: 'driver_id', text: 'Driver ID' },
                { value: 'driver_name', text: 'Driver Name' },
                { value: 'mobile_number', text: 'Mobile Number' },
                { value: 'actions', text: 'Action'}
            ],
            total: null,
            search: ''
        }
    },
    computed: {
        ...mapState('driver', {
            drivers: state => state.drivers //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('driver', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),

        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.driver.page
            },
            set(val) {
                this.$store.commit('driver/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getDrivers() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getDrivers(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('driver', ['getDrivers', 'removeDrivers']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteDrivers(id) {
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
                    this.removeDrivers(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        },
    }
}
</script>
