<template >
  <div class="container">
      <v-layout row wrap class="px-5 py-5">
        <v-flex class="px-5" xs12 md3 lg3>
          <v-card>  
            <v-toolbar>
              <v-toolbar-title>Pallet Quantity : </v-toolbar-title>
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
        <v-flex class="px-5" xs12 md3 lg3>
          <v-card>  
            <v-toolbar>
              <v-toolbar-title>Pallet Quantity : </v-toolbar-title>
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
              <v-toolbar-title>Pallet Quantity : </v-toolbar-title>
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
        <template v-slot:item.latetime="{ item }">
            <!-- <v-chip class="label label-default" v-if="item.status == 0">Sending</v-chip>
            <v-chip class="label label-success" v-else-if="item.status == 1">Received</v-chip> -->
            <p></p>
        </template>
       
    </v-data-table>
          </v-card>
        </v-flex>
      </v-layout>
      
  </div>
</template>

<script>
import PieChart from '../components/PieChart.vue'
import { mapActions, mapState } from 'vuex'

export default {
  name: 'Dashboard',
  created() {
        this.getPoolsDashboard(),
        this.getPools(),
        this.getPalletMovements()
        
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
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        
    }
}
</script>