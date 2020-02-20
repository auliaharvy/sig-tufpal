<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD NEW PALLET TRANSFER
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <pallettransfer-form></pallettransfer-form>
                <div class="form-group">
                    <v-btn class="success" @click.prevent="submit">
                        Add New
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormPalletTransfer from './Form.vue'
    export default {
        name: 'AddPalletTransfer',
        data() {
            return {
                
            }
        },
        methods: {
            ...mapActions('pallettransfer', ['submitPalletTransfer']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitPalletTransfer().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'pallettransfers.data' })
                })
            }
        },
        components: {
            'pallettransfer-form': FormPalletTransfer //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>