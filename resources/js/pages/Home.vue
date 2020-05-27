<template>
  <div class="home">
    <v-container fluid class="pa-5">
      <v-toolbar dark>
          <h1>
           TUFPAL SYSTEM
          </h1>
        </v-toolbar>
      <v-card class="pa-5">
      <h1 class="display-1 black--text">
        Menu
      </h1 >
      <v-layout row wrap class="px-5">
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/sjp" class="text-center ma-3" v-if="$can('read sjps')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-file-document</v-icon>
              <span right> Surat Jalan Pallet</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/sjpstatus" class="text-center ma-3" v-if="$can('read sjpstatuss')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-file-document</v-icon>
              <span right> SJP Status</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/pallettransfer" class="text-center ma-3" v-if="$can('read pallettransfers')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-file-document</v-icon>
              <span right> Pallet Transfer</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/bermissing" class="text-center ma-3" v-if="$can('read bermissingpallets')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-file-document</v-icon>
              <span right> BER/Missing Pallet</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/newpallet" class="text-center ma-3" v-if="$can('read newpallet')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-file-document</v-icon>
              <span right>New Pallet</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/damagedpallet" class="text-center ma-3" v-if="$can('read damagedpallet')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-file-document</v-icon>
              <span right>Damaged Pallet</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/repairedpallet" class="text-center ma-3" v-if="$can('read repairedpallet')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-file-document</v-icon>
              <span right>Repaired Pallet</span>
            </v-card-title>
          </v-card>
        </v-flex>
      </v-layout>


      <h1 class="display-1 black--text">
        Report
      </h1>
      <v-layout row wrap class="px-5">
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/dashboard" class="text-center ma-3" v-if="$can('read dashboard')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-monitor-dashboard</v-icon>
              <span right> Dashboard </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/poolpallet" class="text-center ma-3" v-if="$can('read poolpallets')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-numeric</v-icon>
              <span right> Pallet Quantity</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/transporter" class="text-center ma-3" v-if="$can('read transporters')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-domain</v-icon>
              <span right> Transporter</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/palletmovement" class="text-center ma-3" v-if="$can('read palletmovement')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-transfer</v-icon>
              <span right> Pallet Movement </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/alltransaction" class="text-center ma-3" v-if="$can('read alltransaction')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-tag-multiple</v-icon>
              <span right> Transaction Data </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/map" class="text-center ma-3" v-if="$can('read location')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-google-maps</v-icon>
              <span right> Pallet Geolocation </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <!-- <v-flex xs12 md3 lg3 link >
          <v-card link router to="/sjpadjusment" class="text-center ma-3" v-if="$can('read sjpadjusment')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-truck</v-icon>
              <span right> SJP Adjusment </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/sjpchangedestination" class="text-center ma-3" v-if="$can('read sjpchangedestination')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-transfer</v-icon>
              <span right> SJP Change Destination </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/sjppalletsend" class="text-center ma-3" v-if="$can('read sjppalletsend')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-send</v-icon>
              <span right> SJP Pallet Send </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/sjppalletreceive" class="text-center ma-3" v-if="$can('read sjppalletreceive')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-send</v-icon>
              <span right> SJP Pallet Receive </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/pallettransfersend" class="text-center ma-3" v-if="$can('read pallettransfersend')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-transfer</v-icon>
              <span right> Pallet Transfer Send </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/pallettransferreceive" class="text-center ma-3" v-if="$can('read pallettransferreceive')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-transfer</v-icon>
              <span right> Pallet Transfer Receive </span>
            </v-card-title>
          </v-card>
        </v-flex> -->

        <!-- <v-flex xs12 md3 lg3 link >
          <v-card link router to="/palletdeposit" class="text-center ma-3" v-if="$can('read palletdeposit')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-clipboard-flow</v-icon>
              <span right> Pallet Deposit </span>
            </v-card-title>
          </v-card>
        </v-flex> -->

      </v-layout>

      <h1 class="display-1 black--text">
        Setting
      </h1>
      <v-layout row wrap class="px-5">
        <v-flex xs12 md3 lg3 link >
          <v-card link router :to="{ name: 'user.editprofile', params: {id: authenticated.id} }" class="text-center ma-3" >
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-account</v-icon>
              <span right> Edit Profile </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/setting/role-permission" class="text-center ma-3" v-if="$can('read permission')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-lock</v-icon>
              <span right> Role & Permission </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/user" class="text-center ma-3" v-if="$can('read permission')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-account-multiple</v-icon>
              <span right> User Management </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/vehicle" class="text-center ma-3" v-if="$can('read vehicle')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-truck</v-icon>
              <span right> Vehicle </span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs12 md3 lg3 link >
          <v-card link router to="/driver" class="text-center ma-3" v-if="$can('read driver')">
            <v-card-title class="text-center" color="black">
              <v-icon color="black" left>mdi-clipboard-account</v-icon>
              <span right> Driver </span>
            </v-card-title>
          </v-card>
        </v-flex>
      </v-layout>
      </v-card>
    </v-container>
  </div>

</template>
<script>
import { mapActions, mapState, mapMutations } from 'vuex'

export default {
   created() {
        this.getUserLogin() //LOAD DATA
    },
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
    computed: {
                ...mapState('user', {
                    authenticated: state => state.authenticated
                }),
            },

    methods: {
        ...mapActions('user', ['getUserLogin']),
    },
}
</script>
