<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT FILLRD TO GOOD PALLET RECORD
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <filledtogood-form></filledtogood-form>
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
    import FormFilledToGood from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditDamagedpallet',
        created() {
            this.editFilledtogood(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('filledtogood', ['editFilledtogood', 'updateFilledtogood']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateFilledtogood(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'filledtogoods.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'filledtogood-form': FormFilledToGood,
            Loading
        },
    }
</script>
