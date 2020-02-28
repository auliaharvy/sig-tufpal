<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT BER MISSING
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <bermissing-form></bermissing-form>
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
    import FormBermissing from './Form.vue'
    export default {
        name: 'EditPalletTransfer',
        created() {
            this.editBermissing(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('bermissing', ['editBermissing', 'updateBermissing']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateBermissing(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'bermissings.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'bermissing-form': FormBermissing
        },
    }
</script>