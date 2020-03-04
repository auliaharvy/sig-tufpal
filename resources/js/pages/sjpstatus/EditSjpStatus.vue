<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    RECEIVE SJP STATUS
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <sjpstatus-form></sjpstatus-form>
                <div class="form-group">
                    <v-btn :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Receive' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormSjpStatus from './Formedit.vue'
    export default {
        name: 'EditSjpStatus',
        data() {
            return {
               loading: false, 
            }
        },
        created() {
            this.editSjpStatus(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus', 'updateSjpStatus']),
            submit() {
                this.loading = true
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateSjpStatus(this.$route.params.id).then(() => {
                    this.loading = false
                    this.$router.push({ name: 'sjpstatuss.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'sjpstatus-form': FormSjpStatus
        },
    }
</script>