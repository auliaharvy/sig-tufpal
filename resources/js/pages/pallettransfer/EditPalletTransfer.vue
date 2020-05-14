<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT PALLET TRANSFER
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <pallettransfer-form></pallettransfer-form>
                <div class="form-group px-7">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Receive' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormPalletTransfer from './EditForm.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

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
            },
        },
        computed: {
        ...mapState('pallettransfer', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'pallettransfer-form': FormPalletTransfer,
            Loading
        },
    }
</script>
