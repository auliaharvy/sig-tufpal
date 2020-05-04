<template>
    <div class="col-md-12">
        <loading :active.sync="loading" 
        :can-cancel="false" 
        :is-full-page="fullPage">
        </loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                   Add SJP Status
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <sjpstatus-form ref="FormSjpStatus"></sjpstatus-form>
                <div class="form-group px-7">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Send' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormSjpStatus from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'AddSjpStatusbyMaster',
        created() {
            this.addSjpStatusbyMaster(this.$route.params.id)
        },
       methods: {
            ...mapActions('sjpstatus', ['addSjpStatusbyMaster', 'submitSjpStatus']),
            ...mapActions('sjp', ['editSjp', 'updateSjp']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                this.$refs.FormSjpStatus.submit()
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                // this.submitSjpStatus().then(() => {
                //     //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                //     this.$router.push({ name: 'sjpstatuss.data' })
                // })
            },
        },

        computed: {
        ...mapState('sjpstatus', {
            loading: state => state.loading 
        }),
        },
        components: {
            'sjpstatus-form': FormSjpStatus,
            Loading
        },
    }
</script>