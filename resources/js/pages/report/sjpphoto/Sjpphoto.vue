<template>
    <div class="col-md-12">
        <div class="panel">
            
            <div class="panel-body">
              
              	<!-- TABLE UNTUK MENAMPILKAN LIST SJP -->
                <template>
  <v-card>
    <v-card-title>
      SJP PHOTO
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
      :items="sjpphotos.data"
      :search="search"
      :loading="loading"
    >       
    <template v-slot:item.sending_driver_approval="{ item }">
        <img :src="'/storage/app/public/driverapproval/' + item.sending_driver_approval" :width="70" :height="100" :alt="item.sjp_number"> </img>
        <v-btn dark color="success" text small :href="'/storage/app/public/driverapproval/' + item.sending_driver_approval" target="_blank">
            show
        </v-btn>
    </template>
    <template v-slot:item.receiving_driver_approval="{ item }">
        <img :src="'/storage/app/public/driverapproval/' + item.receiving_driver_approval" :width="70" :height="100" :alt="item.receiving_driver_approval"> </img>
        <v-btn dark color="success" text small :href="'/storage/app/public/driverapproval/' + item.receiving_driver_approval" target="_blank">
            show
        </v-btn>
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
    name: 'DataSjpChangeDestination',
    created() {
        this.getSjpPhoto() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
             headers: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'departure_pool', text: 'Departure Pool' },
                { value: 'destination_pool', text: 'Destination Pool' },
                { value: 'sender', text: 'Sender' },
                { value: 'receiver', text: 'Receiver' },
                { value: 'sending_driver_approval', text: 'Photo Send' },
                { value: 'receiving_driver_approval', text: 'Photo Receive' },          
            ],
            search: '',
            dates: [ ],
            fromDate: '',
            toDate: '',
        }
    },
    computed: {
        ...mapState('sjpphoto', {
            sjpphotos: state => state.sjpphotos //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjpphoto', {
            loading: state => state.loading //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        dateRangeText () {
            return this.dates.join(' ~ ')
        },
        aMonth(){
            this.fromDate = this.dates[0]
            this.toDate = this.dates[1]
        },
        aWeek(){
            this.fromDate = this.dates[0]
            this.toDate = this.dates[1]
        },
        //MENGAMBIL DATA PAGE DARI STATE CUSTOMER
        page: {
            get() {
                return this.$store.state.sjpphoto.page
            },
            set(val) {
                this.$store.commit('sjpphoto/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getSjpPhoto() //KETIKA VALUE PAGE TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        },
        search() {
            this.getSjpPhoto(this.search) //KETIKA VALUE SEARCH TERJADI PERUBAHAN, MAKA REQUEST DATA BARU
        }
    },
    methods: {
        ...mapActions('sjpphoto', ['getSjpPhoto']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        monthAgo(){
            this.toDate = new Date ().toISOString().slice(0,10)
            var month = new Date();
            month.setDate(month.getDate() - 30);
            this.fromDate = month.toISOString().slice(0,10)
            var today = new Date ().toISOString().slice(0,10)
            this.dates = [month.toISOString().slice(0,10), today ]
            this.$store.state.alltransaction.fromDate = this.dates[0]
            this.$store.state.alltransaction.toDate = this.dates[1]
        },
        weekAgo(){
            this.toDate = new Date ().toISOString().slice(0,10)
            var week = new Date();
            week.setDate(week.getDate() - 7);
            this.fromDate = week.toISOString().slice(0,10)
            var today = new Date ().toISOString().slice(0,10)
            this.dates = [week.toISOString().slice(0,10), today ]
             this.$store.state.alltransaction.fromDate = this.dates[0]
            this.$store.state.alltransaction.toDate = this.dates[1]
        },
        selectedDate(){
            this.fromDate = this.dates[0]
            this.toDate = this.dates[1]
            this.$store.state.alltransaction.fromDate = this.dates[0]
            this.$store.state.alltransaction.toDate = this.dates[1]
            this.getAlltransaction()
        },
    }
}
</script>