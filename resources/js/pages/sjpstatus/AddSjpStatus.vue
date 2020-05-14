<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD NEW SJP STATUS
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <sjpstatus-form></sjpstatus-form>
                <div class="form-group">
                    <v-btn :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Send' }}
                    </v-btn>
                    <v-btn class="error px-5" @click.prevent="resetLoading()">
                        Reset
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import VueButtonSpinner from 'vue-button-spinner';
    import FormSjpStatus from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'AddSjpStatus',
        // created() {
        //     this.editSjpStatus(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        // },

        // created() {
        //     this.editSjpStatus(this.$route.params.id), this.editSjp(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        // },
        data() {
            return {
                loading: false,
            }
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus', 'submitSjpStatus']),
            ...mapActions('sjp', ['editSjp', 'updateSjp']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                this.$refs.FormSjpStatus.submit()
                // this.loading = true
                // //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                // this.submitSjpStatus().then(() => {
                //     //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                //     this.$router.push({ name: 'sjpstatuss.data' })
                // })
            },
            resetLoading() {
                this.loading = false
            }
        },
        components: {
            'sjpstatus-form': FormSjpStatus,
            VueButtonSpinner ,
            Loading
        }
    }
</script>
