<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT TRANSPORTER ADJUSMENT
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <transporteradjst-form></transporteradjst-form>
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
    import FormTransporterAdjst from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditNewpallet',
        created() {
            this.editTransporterAdjusment(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('transporterAdjusment', ['editTransporterAdjusment', 'updateTransporterAdjusment']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateTransporterAdjusment(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'transporterAdjusment.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'transporteradjst-form': FormTransporterAdjst,
            Loading
        },
    }
</script>
