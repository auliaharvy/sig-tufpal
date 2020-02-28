<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Edit Transporter</h3>
            </div>
            <div class="panel-body">
                <transporter-form></transporter-form>
                <div class="form-group">
                    <v-btn class="success" @click.prevent="submit">
                        Edit
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormTransporter from './Form.vue'
    export default {
        name: 'EditTransporter',
        created() {
            this.editTransporters(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('transporter', ['editTransporter', 'updateTransporter']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateTransporters(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'transporters.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'transporter-form': FormTransporter
        },
    }
</script>