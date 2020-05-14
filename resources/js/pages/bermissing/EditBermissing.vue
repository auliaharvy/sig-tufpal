<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
        ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    APPROVAL BER MISSING
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <bermissing-form ref="FormBermissing"></bermissing-form>
                <div class="form-group px-7">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Approve' }}
                    </v-btn>
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="disapprove()">
                        {{ loading ? 'Loading...':'Disapprove' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormBermissing from './Formedit.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditPalletTransfer',
        created() {
            this.editBermissing(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('bermissing', ['editBermissing', 'updateBermissing', 'updateBermissingDisapprove']),
            submit() {
                this.$refs.FormBermissing.submit()
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                // this.updateBermissing(this.$route.params.id).then(() => {
                //     this.$router.push({ name: 'bermissings.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                // })
            },
            disapprove() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateBermissingDisapprove(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'bermissings.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            },
        },
        computed: {
        ...mapState('bermissing', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'bermissing-form': FormBermissing,
            Loading
        },
    }
</script>
