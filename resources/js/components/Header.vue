<template>
     <div>  
        <v-navigation-drawer v-model="drawer" app>
            <template v-slot:prepend>
                <v-list-item two-line>
                    <v-list-item-avatar>
                        <img src="../assets/logo.png">
                    </v-list-item-avatar>
                    <v-list-item-content>
                        <v-list-item-title>Wallet System</v-list-item-title>
                        <v-list-item-subtitle>{{ authenticated.name }}</v-list-item-subtitle>
                    </v-list-item-content>
                </v-list-item>
            </template>
            <v-divider></v-divider>
            
            <v-list nav dense>
                <!--  Home -->
                <h3> Menu </h3>
                <v-list-item link router to="/">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-home</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Home</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <!-- Surat Jalan Pallet -->
                <v-list-item link router to="/sjp" v-if="$can('read sjps')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Surat Jalan Pallet</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/sjpstatus" v-if="$can('read sjpstatuss')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">SJP Status</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/pallettransfer" v-if="$can('read pallettransfers')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Pallet Transfer</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/bermissing" v-if="$can('read bermissingpallets')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">BER/Missing Pallet</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/newpallet" v-if="$can('read newpallet')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">New Pallet</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/damagedpallet" v-if="$can('read damagedpallet')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Damaged Pallet</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/repairedpallet" v-if="$can('read repairedpallet')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Repaired Pallet</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <!-- { title: 'Home', icon: 'mdi-home', route:'/' },
                { title: 'Surat Jalan Pallet', icon: 'mdi-file-document', route:'/sjp' },
                { title: 'SJP Status', icon: 'mdi-file-document', route:'/sjpstatus' },
                { title: 'Pallet Transfer', icon: 'mdi-call-received', route:'/pallettransfer' },
                { title: 'Missing/BER Pallet', icon: 'mdi-close-circle', route:'/bermissing' },
                { title: 'Add New Pallet', icon: 'mdi-plus', route:'/newpallet',},
                ], -->
                <!-- <v-list-item v-for="item in items" :key="item.title" link router :to="item.route">
                    <v-list-item-icon>
                        <v-icon color="black">{{ item.icon}}</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">{{ item.title}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item> -->

                <v-divider></v-divider>
                <h3> Report </h3>
                <v-list-item link router to="/dashboard" v-if="$can('read dashboard')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-monitor-dashboard</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Dashboard</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/poolpallet" v-if="$can('read poolpallets')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-numeric</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Pallet Quantity</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/transporter" v-if="$can('read transporters')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-domain</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Transporter</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/palletmovement" v-if="$can('read palletmovement')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-transfer</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Pallet Movement</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/sjpadjusment" v-if="$can('read sjpadjusment')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-truck</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">SJP Adjusment</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/sjppalletsend" v-if="$can('read sjppalletsend')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-send</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">SJP Pallet Send</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/sjppalletreceive" v-if="$can('read sjppalletreceive')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-send</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">SJP Pallet Receive</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/pallettransfersend" v-if="$can('read pallettransfersend')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-transfer</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black"> Pallet Transfer Send</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item link router to="/pallettransferreceive" v-if="$can('read pallettransferreceive')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-transfer</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black"> Pallet Transfer Receive</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <!-- <v-list-item link router to="/palletdeposit" v-if="$can('read palletdeposit')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-clipboard-flow</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Pallet Deposit</v-list-item-title>
                    </v-list-item-content>
                </v-list-item> -->
                <v-list-item link router to="/map" v-if="$can('read location')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-google-maps</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Pallet Geolocation</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>

                <!-- { title: 'Report Dashboard', icon: 'mdi-monitor-dashboard' },
                { title: 'Pallet Quantity', icon: 'mdi-numeric', route:'/poolpallet' },
                { title: 'Transporter', icon: 'mdi-numeric', route:'/transporter', permission: 'read transporter'},
                { title: 'Pallet Movement', icon: 'mdi-truck', route:'/palletmovement' },
                { title: 'Pallet Deposit', icon: 'mdi-clipboard-flow', route:'/' },
                { title: 'Pallet Geolocation', icon: 'mdi-google-maps', route:'/map' }, -->
                <!-- <v-list-item v-for="item in reports" :key="item.title" link router :to="item.route" v-if="$can('read transporter')">
                    <v-list-item-icon>
                        <v-icon color="black">{{ item.icon}}</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">{{ item.title}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item> -->

                
                <v-divider></v-divider>
                <h3> Setting </h3>
                <v-list-item link router to="/setting/role-permission" v-if="$can('read permission')">
                    <v-list-item-icon>
                        <v-icon color="black">mdi-lock</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">Role & Permission</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
        </v-navigation-drawer>

        <v-app-bar app color="primary"> 
            <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
            <router-link to="/">
            <v-toolbar-title link router to="/map" app class="text-uppercase font-weight-light">
                <v-col class="text-center">
                    <img src="../assets/logotoolbar.png">
                </v-col>
            </v-toolbar-title>
            </router-link>
            <v-spacer></v-spacer>
            <v-btn @click="logout"> 
                <span left>Logout</span>
                <v-icon right color="black">mdi-exit-to-app</v-icon>
            </v-btn>
        </v-app-bar>    

     </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import moment from 'moment'
export default {
    data(){
        return{
            drawer: false,
            items: [
                { title: 'Home', icon: 'mdi-home', route:'/' },
                { title: 'Surat Jalan Pallet', icon: 'mdi-file-document', route:'/sjp' },
                { title: 'SJP Status', icon: 'mdi-file-document', route:'/sjpstatus' },
                { title: 'Pallet Transfer', icon: 'mdi-call-received', route:'/pallettransfer' },
                { title: 'Missing/BER Pallet', icon: 'mdi-close-circle', route:'/bermissing' },
                { title: 'Add New Pallet', icon: 'mdi-plus', route:'/newpallet',},
                ],
            reports: [
                { title: 'Report Dashboard', icon: 'mdi-monitor-dashboard' },
                { title: 'Pallet Quantity', icon: 'mdi-numeric', route:'/poolpallet' },
                { title: 'Transporter', icon: 'mdi-numeric', route:'/transporter', permission: 'read transporter'},
                { title: 'Pallet Movement', icon: 'mdi-truck', route:'/palletmovement' },
                { title: 'Pallet Deposit', icon: 'mdi-clipboard-flow', route:'/' },
                { title: 'Pallet Geolocation', icon: 'mdi-google-maps', route:'/map' },
            ],
        }
    },
    right: null,
    computed: {
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
        ...mapState('notification', {
            notifications: state => state.notifications
        })
    },
    filters: {
        formatDate(val) {
            return moment(new Date(val)).fromNow()
        }
    },
    methods: {
        ...mapActions('notification', ['readNotification']),
        readNotif(row) {
            this.readNotification({ id: row.id}).then(() => this.$router.push({ name: 'expenses.view', params: {id: row.data.expenses.id} }))
        },
        logout() {
            return new Promise((resolve, reject) => {
                localStorage.removeItem('token')
                resolve()
            }).then(() => {
                this.$store.state.token = localStorage.getItem('token')
                this.$router.push('/login')
            })
        }
    }
}
</script>
