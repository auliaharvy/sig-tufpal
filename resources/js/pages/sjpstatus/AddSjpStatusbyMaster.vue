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
                <div class="form-group">
                    <v-btn :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Add' }}
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
    import { mapActions, mapState } from 'vuex'
    import FormSjpStatus from './Form.vue'
    export default {
        name: 'AddSjpStatusbyMaster',
        data() {
            return {
               loading: false, 
            }
        },
        created() {
            this.addSjpStatusbyMaster(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
       methods: {
            ...mapActions('sjpstatus', ['addSjpStatusbyMaster', 'submitSjpStatus']),
            ...mapActions('sjp', ['editSjp', 'updateSjp']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                this.loading = true
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitSjpStatus().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
            },
            resetLoading() {
                this.loading = false
            }
        },
        components: {
            'sjpstatus-form': FormSjpStatus
        },
    }
</script>