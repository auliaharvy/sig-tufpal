<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT NEW PALLET RECORD
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <newpallet-form></newpallet-form>
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
    import FormNewpallet from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditNewpallet',
        created() {
            this.editNewpallet(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('newpallet', ['editNewpallet', 'updateNewpallet']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateNewpallet(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'newpallets.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'newpallet-form': FormNewpallet,
            Loading
        },
    }
</script>
