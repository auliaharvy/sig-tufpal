<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                   Add SJP Status
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <sjpstatus-form></sjpstatus-form>
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
    export default {
        name: 'AddSjpStatusbyMaster',
        created() {
            this.addSjpStatusbyMaster(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
       methods: {
            ...mapActions('sjpstatus', ['addSjpStatusbyMaster', 'submitSjpStatus']),
            ...mapActions('sjp', ['editSjp', 'updateSjp']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitSjpStatus().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
            },
        },

        computed: {
        ...mapState('sjpstatus', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'sjpstatus-form': FormSjpStatus
        },
    }
</script>