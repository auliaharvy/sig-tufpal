<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD NEW PALLET 
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <newpallet-form></newpallet-form>
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
    import FormNewpallet from './Form.vue'
    export default {
        name: 'AddNewpallet',
        data() {
            return {
                loading: false,
            }
        },
        methods: {
            ...mapActions('newpallet', ['submitNewpallet']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.loading = true
                this.submitNewpallet().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'newpallets.data' })
                })
            },
        },
        components: {
            'newpallet-form': FormNewpallet //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>