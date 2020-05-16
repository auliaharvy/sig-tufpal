<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create vehicle')" :to="{ name: 'vehicles.add' }"><v-btn>Add Vehicle</v-btn></router-link>
            </div>
            <div class="panel-body">

              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
                <v-card>
                    <v-card-title>
                    Vehicle
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
                    :items="vehicles.data"
                    :search="search"
                    dense
                    >
                        <template v-slot:item.actions="{ item }">
                            <router-link :to="{ name: 'vehicles.edit', params: {id: item.vehicle_id} }">
                                <v-btn color="success" small>Update</v-btn>
                            </router-link>
                            <v-btn color="error" small @click="deleteVehicles(item.vehicle_id)">Delete</v-btn>
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
    name: 'DataVehicle',
    created() {
        this.getVehicles() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            headers: [
                // { value: 'organization_name', text: 'Organization' },
                { value: 'transporter_name', text: 'Transporter' },
                { value: 'vehicle_number', text: 'Vehicle Number' },
                { value: 'vehicle_type', text: 'Vehicle Type' },
                { value: 'actions', text: 'Action'}
            ],
            total: null,
            search: ''
        }
    },
    computed: {
        ...mapState('vehicle', {
            vehicles: state => state.vehicles //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('vehicle', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),

        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.vehicle.page
            },
            set(val) {
                this.$store.commit('pool/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getVehicles() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getVehicles(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('vehicle', ['getVehicles', 'removeVehicles']),
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        deleteVehicles(id) {
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
                    this.removeVehicles(id) //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                }
            })
        },
    }
}
</script>
