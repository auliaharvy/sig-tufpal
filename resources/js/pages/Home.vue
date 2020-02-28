<template>
  <div class="home">
    <v-container fluid class=" primary pa-5">
      <v-toolbar dark>
          <h1>
           WALLET SYSTEM
          </h1>
        </v-toolbar>
      <v-card class="pa-5">
      <h1 class="display-1 black--text">
        Menu
      </h1 >
      <v-layout row wrap class="px-5">
      <v-flex xs12 md3 lg3 v-for="item in items" :key="item.title" link >
          <v-card link router :to="item.route" class="text-center ma-3">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>{{ item.icon }}</v-icon>
              <span right> {{ item.title }} </span>
            </v-card-title>
          </v-card>
      </v-flex>
      </v-layout>
      
      <h1 class="display-1 black--text">
        Report
      </h1>
      <v-layout row wrap class="px-5">
      <v-flex xs12 md3 lg3 v-for="item in reports" :key="item.title" link>
          <v-card link router :to="item.route" class="text-center ma-3">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>{{ item.icon }}</v-icon>
              <span right> {{ item.title }} </span>
            </v-card-title>
          </v-card>
      </v-flex>
      </v-layout>

      <h1 class="display-1 black--text">
        Setting
      </h1>
      <v-layout row wrap class="px-5">
      <v-flex xs12 md3 lg3 v-for="item in settings" :key="item.title" link>
          <v-card link router :to="item.route" class="text-center ma-3">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>{{ item.icon }}</v-icon>
              <span right> {{ item.title }} </span>
            </v-card-title>
          </v-card>
      </v-flex>
      </v-layout>
      </v-card>
    </v-container>
  </div>
  
</template>
<script>
export default {
    data(){
        return{
            drawer: false,
            items: [
                { title: 'Surat Jalan Pallet', icon: 'mdi-file-document', route:'/sjp' },
                { title: 'SJP Status', icon: 'mdi-file-document', route:'/sjpstatus' },
                { title: 'Pallet Transfer', icon: 'mdi-call-received', route:'/pallettransfer' },
                { title: 'Missing/BER Pallet', icon: 'mdi-close-circle', route:'/bermissing' },
                { title: 'Add New Pallet', icon: 'mdi-plus', route:'/newpallet' },
                ],
            reports: [
                { title: 'Report Dashboard', icon: 'mdi-monitor-dashboard' },
                { title: 'Pallet Quantity', icon: 'mdi-numeric', route:'/poolpallet' },
                { title: 'Transporter', icon: 'mdi-numeric', route:'/transporter' },
                { title: 'Pallet Movement', icon: 'mdi-truck', route:'/palletmovement' },
                { title: 'Pallet Deposit', icon: 'mdi-clipboard-flow', route:'/' },
                { title: 'Pallet Geolocation', icon: 'mdi-google-maps', route:'/map' },
            ],
            settings: [
                { title: 'Setting', icon: 'mdi-monitor-dashboard', route:'/setting' },
               
            ],
            right: null,
        }
    },
}
</script>