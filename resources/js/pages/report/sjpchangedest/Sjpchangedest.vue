<template>
    <div class="col-md-12">
        <div class="panel">
            
            <div class="panel-body">
              
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
  <v-card>
    <v-card-title>
      SJP CHANGE DESTINATION
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
      :items="sjpchangedestinations.data"
      :search="search"
    >       
        <!-- <template v-slot:item.status="{ item }">
                            <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
                            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip>
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
    name: 'DataSjpChangeDestination',
    created() {
        this.getSjpchangedestination() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
             headers: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'no_do', text: 'Old Dispatch No' },
                { value: 'new_no_do', text: 'New Dispatch No' },
                { value: 'destination', text: 'Old Destination' },
                { value: 'new_destination', text: 'New Destination' },
                { value: 'adjust_by', text: 'Change By' },
                { value: 'created_at', text: 'Change At' },          
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('sjpchangedestination', {
            sjpchangedestinations: state => state.sjpchangedestinations //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.sjpchangedestination.page
            },
            set(val) {
                this.$store.commit('sjpchangedestination/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getSjpchangedestination() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getSjpchangedestination(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('sjpchangedestination', ['getSjpchangedestination']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        
    }
}
</script>