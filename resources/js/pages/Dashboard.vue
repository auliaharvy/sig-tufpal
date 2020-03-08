<template >
  <div class="container">
    <v-card>  
      <v-toolbar>
        <v-toolbar-title>Pallet Quantity : </v-toolbar-title>
      </v-toolbar>
        <h4 align="center">Pool Pallet : </h4>
        <pie-chart :chartdata="datasetsfull"/>
        <h4 align="center">Transporter : </h4>
        <pie-chart :chartdata="datasetsfull1"/>
     
    </v-card>
  </div>
</template>

<script>
import PieChart from '../components/PieChart.vue'
import { mapActions, mapState } from 'vuex'

export default {
  name: 'Dashboard',
  created() {
        this.getPoolsDashboard() //LOAD DATA SJP KETIKA COMPONENT DI-LOAD 
    },
  components: { PieChart },
    data() {
        return {
            loaded: false,
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            chartdata: [
                { value: 'organization_name', text: 'Organization' },
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
            total: null,
            search: ''
        }
    },
    computed: {
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
    methods: {
        ...mapActions('dashboard', ['getPoolsDashboard']), 
        //KETIKA TOMBOL HAPUS DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
        
    }
}
</script>