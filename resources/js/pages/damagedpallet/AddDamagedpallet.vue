<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD DAMAGED PALLET 
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <damagedpallet-form></damagedpallet-form>
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
    import FormDamagedpallet from './Form.vue'
    export default {
        name: 'AddDamagedPallet',
        data() {
            return {
                loading: false,
            }
        },
        methods: {
            ...mapActions('damagedpallet', ['submitDamagedpallet']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.loading = true
                this.submitDamagedpallet().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'damagedpallet.data' })
                })
            },
        },
        components: {
            'damagedpallet-form': FormDamagedpallet //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>