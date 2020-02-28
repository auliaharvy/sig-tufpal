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
                <v-list-item v-for="item in items" :key="item.title" link router :to="item.route">
                    <v-list-item-icon>
                        <v-icon color="black">{{ item.icon}}</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">{{ item.title}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-divider></v-divider> 
                <v-list-item v-for="item in reports" :key="item.title" link router :to="item.route">
                    <v-list-item-icon>
                        <v-icon color="black">{{ item.icon}}</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">{{ item.title}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-divider></v-divider> 
                <v-list-item v-for="item in settings" :key="item.title" link router :to="item.route">
                    <v-list-item-icon>
                        <v-icon color="black">{{ item.icon}}</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title color="black">{{ item.title}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
        </v-navigation-drawer>

        <v-app-bar app color="primary"> 
            <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
            <v-toolbar-title app class="text-uppercase font-weight-light">
                <v-col class="text-center">
                    <img src="../assets/logotoolbar.png">
                </v-col>
            </v-toolbar-title>
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
            settings: [
                { title: 'Setting', icon: 'mdi-monitor-dashboard', route:'/setting' },
               
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
