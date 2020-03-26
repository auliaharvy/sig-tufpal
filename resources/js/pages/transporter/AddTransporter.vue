<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD TRANSPORTER
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <transporter-form></transporter-form>
                <div class="form-group">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Add' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormTransporter from './Form.vue'
    export default {
        name: 'AddTransporter',
        data() {
            return {
                
            }
        },
        methods: {
            ...mapActions('transporter', ['submitTransporters']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitTransporters().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'transporters.data' })
                })
            }
        },
        computed: {
        ...mapState('transporter', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'transporter-form': FormTransporter //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>