<template >
  <div class="container">
      <v-layout row wrap class="px-5 py-5">
        <v-flex class="px-5" xs12 md6 lg6>
          <v-card>  
            <v-toolbar>
              <v-toolbar-title>Pallet Quantity Pool :  </v-toolbar-title>
            </v-toolbar>
            <v-data-table
                class="py-5"
                :headers="headers"
                :items="pools.data"
                :search="search"
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
              </v-data-table>
          </v-card>
        </v-flex>
        <v-flex class="px-5" xs12 md6 lg6>
          <v-card>  
            <v-toolbar>
              <v-toolbar-title>Pallet Quantity Transporter : </v-toolbar-title>
            </v-toolbar>
            <v-data-table
                class="py-5"
                :headers="headers4"
                :items="transporters.data"
                :search="search"
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
              </v-data-table>
          </v-card>
        </v-flex>
         </v-layout>
         
        <v-layout row wrap class="px-5 py-5">
        <v-flex class="px-5" xs12 md6 lg6>
          <v-card>  
            <v-toolbar>
              <v-toolbar-title>Pallet Send : </v-toolbar-title>
            </v-toolbar>
              <!-- <v-text-field
              v-model="search"
              prepend-icon="mdi-search"
              label="Search"
              single-line
              hide-details
              ></v-text-field> -->
              <v-data-table
                class="py-5"
                :headers="headers2"
                :items="sjppalletsends.data"
                :search="search"
              >       
                <!-- <template v-slot:item.total="{ item }">
                    <v-chip class="label"  color="red"  v-if="item.good_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet > item.pallet_quota">
                        {{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                    </v-chip> 
                    <v-chip class="label label-success"  v-if="item.good_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet < item.pallet_quota">
                        {{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                    </v-chip>
                    <v-chip class="label label-warning"  v-if="item.good_pallet+item.tbr_pallet+item.ber_pallet+item.missing_pallet == item.pallet_quota">
                        {{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}
                    </v-chip>
                </template> -->
              </v-data-table>
          </v-card>
        </v-flex>
        <v-flex class="px-5" xs12 md6 lg6>
          <v-card>  
            <v-toolbar>
              <v-toolbar-title>Pallet Received : </v-toolbar-title>
            </v-toolbar>
              <!-- <v-text-field
              v-model="search"
              prepend-icon="mdi-search"
              label="Search"
              single-line
              hide-details
              ></v-text-field> -->
              <v-data-table
                class="py-5"
                :headers="headers3"
                :items="sjppalletreceives.data"
                :search="search"
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
              </v-data-table>
          </v-card>
        </v-flex>
      </v-layout>

      <v-layout row wrap class="px-5 py-5">
        <v-flex class="px-5" xs12 md6 lg6>
          <v-card>  
            <v-toolbar>
              <v-toolbar-title>Pallet Movement  </v-toolbar-title>
            </v-toolbar>
            <v-data-table
            :headers="headers1"
            :items="palletmovements.data"
            :search="search"
          >       
        <template v-slot:item.totalpalletmove="{ item }">
            <!-- <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip> -->
            <p>{{ item.good_pallet + item.tbr_pallet + item.ber_pallet + item.missing_pallet }}</p>
        </template>
        <!-- <template v-slot:item.latetime="{ item }">
            <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip>
            <p></p>
        </template> -->
       
    </v-data-table>
          </v-card>
        </v-flex>
      </v-layout>
      
  </div>
</template>

<script>
import PieChart from '../components/PieChart.vue'
import { mapActions, mapState } from 'vuex'
import Vue from 'vue'

export default {
  name: 'Dashboard',
  created() {
        this.getPoolsDashboard(),
        this.getPools(),
        this.getPalletMovements(),
        this.getSjpPalletSend();
        this.getSjpPalletReceive();
        this.getTransporters();
        
    },
  components: { PieChart },
    data() {
        return {
            loaded: false,
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            chartdata: [
                // { value: 'organization_name', text: 'Organization' },
                { value: 'pool_name', text: 'Pool Name' },
                { value: 'code', text: 'Pool Code' },
                { value: 'type', text: 'Pool Type' },
                { value: 'pool_address', text: 'Pool Address' },
                { value: 'pallet_quota', text: 'Pallet Quota' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                { value: 'ber_pallet', text: 'BER Pallet' },
                { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'total', text: 'Total Pallet' },
                // { value: 'actions', text: 'Action'}
            ],
            headers: [
                // { value: 'organization_name', text: 'Organization' },
                { value: 'pool_name', text: 'Pool Name' },
                // { value: 'code', text: 'Pool Code' },
                // { value: 'type', text: 'Pool Type' },
                // { value: 'pool_address', text: 'Pool Address' },
                { value: 'pallet_quota', text: 'Pallet Quota' },
                // { value: 'good_pallet', text: 'Good Pallet' },
                // { value: 'tbr_pallet', text: 'TBR Pallet' },
                // { value: 'ber_pallet', text: 'BER Pallet' },
                // { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'total', text: 'Total Pallet' },
                // { value: 'actions', text: 'Action'}
            ],
            headers4: [
                { value: 'transporter_name', text: 'Transporter Name' },
                // { value: 'transporter_address', text: 'Transporter Address' },
                { value: 'pallet_quota', text: 'Pallet Quota' },
                // { value: 'good_pallet', text: 'Good Pallet' },
                // { value: 'tbr_pallet', text: 'TBR Pallet' },
                // { value: 'ber_pallet', text: 'BER Pallet' },
                // { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'total', text: 'Total Pallet' },
                // { value: 'actions', text: 'Action'}
            ],
             headers1: [
                // { value: 'sjps_number', text: 'SJP Status Number' },
                // { value: 'sjp_number', text: 'SJP Number' },
                // { value: 'transaction', text: 'Send/Send Back' },
                // { value: 'status', text: 'Status' },
                // { value: 'dept_pool', text: 'Departure Pool' },
                // { value: 'dest_pool', text: 'Destination Pool' },
                { value: 'transporter_name', text: 'Transporter' },
                { value: 'vehicle_number', text: 'Vehicle Number' },
                // { value: 'driver_name', text: 'Driver Name' },
                // { value: 'transporter_name', text: 'Transporter Name' },
                // { value: 'pallet_quantity', text: 'Pallet Quantity' },
                // { value: 'good_pallet', text: 'Good Pallet' },
                // { value: 'tbr_pallet', text: 'TBR Pallet' },
                // { value: 'ber_pallet', text: 'BER Pallet' },
                // { value: 'missing_pallet', text: 'Missing Pallet' },
                // { value: 'product_name', text: 'Product' },
                { value: 'totalpalletmove', text: 'Total Pallet' },
                { value: 'departure_time', text: 'Departure Time' },
                { value: 'eta', text: 'ETA' },
                { value: 'latetime', text: 'Late Time' },
                // { value: 'send', text: 'Send Pallet' },
                // { value: 'adjusment', text: 'Adjusment SJP' },
            ],
            headers2: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'sjp_status', text: 'SJP Status' },
                // { value: 'sender', text: 'Sender' },
                { value: 'departure_pool', text: 'Departure' },
                // { value: 'destination_pool', text: 'Destination' },
                // { value: 'transporter', text: 'Transporter' },
                // { value: 'driver', text: 'Driver' },
                // { value: 'vehicle', text: 'Vehicle' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                // { value: 'ber_pallet', text: 'BER Pallet' },
                // { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'good_cement', text: 'Good Cement' },
                // { value: 'bad_cement', text: 'Bad Cement' },
                // { value: 'note', text: 'Note' },
                // { value: 'created_at', text: 'Send At' },          
            ],
            headers3: [
                { value: 'sjp_number', text: 'SJP Number' },
                { value: 'sjp_status', text: 'SJP Status' },
                // { value: 'receiver', text: 'Receiver' },
                // { value: 'departure_pool', text: 'Departure' },
                { value: 'destination_pool', text: 'Destination' },
                // { value: 'transporter', text: 'Transporter' },
                // { value: 'driver', text: 'Driver' },
                // { value: 'vehicle', text: 'Vehicle' },
                { value: 'good_pallet', text: 'Good Pallet' },
                { value: 'tbr_pallet', text: 'TBR Pallet' },
                // { value: 'ber_pallet', text: 'BER Pallet' },
                // { value: 'missing_pallet', text: 'Missing Pallet' },
                { value: 'good_cement', text: 'Good Cement' },
                // { value: 'bad_cement', text: 'Bad Cement' },
                // { value: 'note', text: 'Note' },
                // { value: 'created_at', text: 'Send At' },          
            ],
            total: null,
            search: ''
        }
    },
    computed: {
      ...mapState('pool', {
            pools: state => state.pools //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('palletmovement', {
            palletmovements: state => state.palletmovements //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjppalletsend', {
            sjppalletsends: state => state.sjppalletsends //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjppalletreceive', {
            sjppalletreceives: state => state.sjppalletreceives //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('transporter', {
            transporters: state => state.transporters //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        page: {
            get() {
                return this.$store.state.pool.page
            },
            set(val) {
                this.$store.commit('pool/SET_PAGE', val)
            }
        },
          datasetsfull (state) {
            return {
              labels: [ "Pool Pallet DLI", "Workshop DLI", "BCTD", "Sukabumi" ],
              datasets: [
              {
                label: 'Data One',
                backgroundColor: ['#41B883',
                                  '#E46651',
                                  '#00D8FF',
                                  '#DD1B16'],
                data: [ 1000,100,100,50]
              }
                  ]
                }
              },
              datasetsfull1 (state) {
              return {
                labels: [ "Transporter DLI", "Mitra" ],
                datasets: [
                {
                  label: 'Data One',
                  backgroundColor: ['#41B883',
                                    '#E46651',
                                    '#00D8FF',
                                    '#DD1B16'],
                  data: [ 800,100]
                }
                    ]
                  }
              },
              
        ...mapState('dashboard', {
            dashboards: state => state.dashboards //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
  
        
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
        ...mapActions('dashboard', ['getPoolsDashboard']),
        ...mapActions('palletmovement', ['getPalletMovements']), 
        ...mapActions('sjppalletsend', ['getSjpPalletSend']), 
        ...mapActions('pallettransferreceive', ['getTransferPalletReceive']),
        ...mapActions('sjppalletreceive', ['getSjpPalletReceive']),
        ...mapActions('transporter', ['getTransporters', 'removeTransporters']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        
    }
}
</script>