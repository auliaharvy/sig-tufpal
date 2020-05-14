<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Edit Pool Pallet</h3>
            </div>
            <div class="panel-body">
                <pool-form></pool-form>
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
    import FormPool from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditPool',
        created() {
            this.editPools(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('pool', ['editPools', 'updatePools']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updatePools(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'pools.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'pool-form': FormPool,
            Loading
        },
    }
</script>
