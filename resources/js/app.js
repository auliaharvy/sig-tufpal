import Vue from 'vue'
import router from './router.js'
import store from './store.js'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import VueSweetalert2 from 'vue-sweetalert2'
import Permissions from './mixins/permission.js'
import vuetify from './plugins/vuetify'
import Vuetify from 'vuetify'
import JsonExcel from 'vue-json-excel'
import { LMap, LTileLayer, LMarker } from 'vue2-leaflet';
import { Icon } from 'leaflet';
import 'leaflet/dist/leaflet.css';
import QrcodeVue from 'qrcode.vue'
import { QrcodeStream, QrcodeDropZone, QrcodeCapture } from 'vue-qrcode-reader'
import VueBootstrapTypeahead from 'vue-bootstrap-typeahead'
import pdf  from 'vue-pdf'
import VueHtml2Canvas from 'vue-html2canvas';
import VueHtmlToPaper from 'vue-html-to-paper';

Vue.use(Vuetify);
Vue.use(VueSweetalert2)
Vue.use(BootstrapVue)
Vue.mixin(Permissions)
Vue.component('vue-bootstrap-typeahead', VueBootstrapTypeahead)
Vue.component('downloadExcel', JsonExcel)
Vue.component('QrcodeStream', QrcodeStream)
Vue.component('QrcodeDropZone', QrcodeDropZone)
Vue.component('QrcodeCapture', QrcodeCapture)
Vue.component('QrcodeVue', QrcodeVue)
Vue.component('l-map', LMap);
Vue.component('l-tile-layer', LTileLayer);
Vue.component('l-marker', LMarker);
Vue.component('pdf', pdf);
Vue.use(VueHtml2Canvas);
Vue.use(VueHtmlToPaper);


delete Icon.Default.prototype._getIconUrl;

Icon.Default.mergeOptions({
  iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
  iconUrl: require('leaflet/dist/images/marker-icon.png'),
  shadowUrl: require('leaflet/dist/images/marker-shadow.png')
});

import 'bootstrap-vue/dist/bootstrap-vue.css'
import { mapActions, mapGetters, mapState } from 'vuex'
import Echo from 'laravel-echo'
import Pusher from 'pusher-js'

new Vue({
    el: '#dw',
    router,
    store,
    vuetify,
    components: {
        App
    },
    render: h => h(App),
    computed: {
        ...mapGetters(['isAuth']),
        ...mapState(['token']),
        ...mapState('user', {
            user_authenticated: state => state.authenticated
        })
    },
    methods: {
        ...mapActions('user', ['getUserLogin']),
        ...mapActions('notification', ['getNotifications']),
        ...mapActions('expenses', ['getExpenses']),
        initialLister() {
            if (this.isAuth) {
                window.Echo = new Echo({
                    broadcaster: 'pusher',
                    key: process.env.MIX_PUSHER_APP_KEY,
                    cluster: process.env.MIX_PUSHER_APP_CLUSTER,
                    encrypted: false,
                    auth: {
                        headers: {
                            Authorization: 'Bearer ' + this.token
                        },
                    },
                });

                if (typeof this.user_authenticated.id != 'undefined') {
                    window.Echo.private(`App.User.${this.user_authenticated.id}`)
                    .notification(() => {
                        this.getNotifications()
                        this.getExpenses()
                    })
                }
            }
        }
    },
    watch: {
        token() {
            this.initialLister()
        },
        user_authenticated() {
            this.initialLister()
        }
    },
    created() {
        if (this.isAuth) {
            this.getUserLogin()
            this.initialLister()
            this.getNotifications()
        }
    }
})
