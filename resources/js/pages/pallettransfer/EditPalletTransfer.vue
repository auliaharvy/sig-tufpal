<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT PALLET TRANSFER
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <pallettransfer-form></pallettransfer-form>
                <div class="form-group">
                    <v-btn class="success" @click.prevent="submit">
                        Receive
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormPalletTransfer from './Form.vue'
    export default {
        name: 'EditPalletTransfer',
        created() {
            this.editPalletTransfer(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('pallettransfer', ['editPalletTransfer', 'updatePalletTransfer']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updatePalletTransfer(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'pallettransfers.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'pallettransfer-form': FormPalletTransfer
        },
    }
</script>