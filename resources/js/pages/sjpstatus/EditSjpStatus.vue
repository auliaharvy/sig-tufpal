<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT SJP STATUS
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <sjpstatus-form></sjpstatus-form>
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
    import FormSjpStatus from './Form.vue'
    export default {
        name: 'EditSjpStatus',
        created() {
            this.editSjpStatus(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus', 'updateSjpStatus']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateSjpStatus(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'sjpstatuss.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'sjpstatus-form': FormSjpStatus
        },
    }
</script>