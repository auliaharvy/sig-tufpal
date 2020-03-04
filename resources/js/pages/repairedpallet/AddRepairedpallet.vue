<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD REPAIRED PALLET 
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <repairedpallet-form></repairedpallet-form>
                <div class="form-group">
                    <v-btn :loading="loading" class="success" @click="submit()">
                        {{ loading ? 'Loading...':'Add' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormRepairedpallet from './Form.vue'
    export default {
        name: 'AddRepairedpallet',
        data() {
            return {
                loading: false,
            }
        },
        methods: {
            ...mapActions('repairedpallet', ['submitRepairedpallet']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.loading = true
                this.submitRepairedpallet().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'repairedpallets.data' })
                })
            },
        },
        components: {
            'repairedpallet-form': FormRepairedpallet //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>