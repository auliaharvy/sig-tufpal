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
                    <v-btn :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Receive' }}
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
    import FormPalletTransfer from './EditForm.vue'
    export default {
        name: 'EditPalletTransfer',
        data() {
            return {
               loading: false, 
            }
        },
        created() {
            this.editPalletTransfer(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('pallettransfer', ['editPalletTransfer', 'updatePalletTransfer']),
            submit() {
                this.loading = true
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updatePalletTransfer(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'pallettransfers.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            },
            resetLoading() {
                this.loading = false
            }
        },
        components: {
            'pallettransfer-form': FormPalletTransfer
        },
    }
</script>