<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT DAMAGED PALLET RECORD
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <damagedpallet-form></damagedpallet-form>
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
    import FormDamagedpallet from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditDamagedpallet',
        created() {
            this.editDamagedpallet(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('damagedpallet', ['editDamagedpallet', 'upadateDamagedpallet']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.upadateDamagedpallet(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'damagedpallet.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'damagedpallet-form': FormDamagedpallet,
            Loading
        },
    }
</script>
