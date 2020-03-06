<template>
    <div class="col-md-12">
        <div class="panel">
                <v-toolbar dark>
                <h1>
                    ADD NEW SJP
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <sjp-form></sjp-form>
                <div class="form-group">
                    <v-btn :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Add' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormSjp from './Form.vue'
    export default {
        name: 'AddSjp',
        data() {
            return {
               loading: false, 
            }
        },
        methods: {
            ...mapActions('sjp', ['submitSjp']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                this.loading = true
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitSjp().then(() => {
                    this.loading = false
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'sjps.data' })
                }).catch((error) => {
                //JIKA TERJADI ERROR VALIDASI, ASSIGN ERROR TERSEBUT KE DALAM STATE ERRORS
                    if (error.response.status == 404) {
                        this.loading = false
                    }
                })
            }
        },
        components: {
            'sjp-form': FormSjp //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>