<template>
<v-app>
    <div class="wrapper">
        <app-header v-if="isAuth" />
        <v-content>
        <div class="content-wrapper">
            <router-view></router-view>
        </div>
        </v-content>
        <app-footer v-if="isAuth" />
    </div>
</v-app>
</template>
<script>
    import { mapState, mapGetters } from 'vuex'
    import Header from './components/Header.vue'
    import Footer from './components/Footer.vue'
    export default {
        computed: {
            ...mapState(['token']),
            ...mapGetters(['isAuth'])
        },
        components: {
            'app-header': Header,
            'app-footer': Footer
        }
    }
</script>
