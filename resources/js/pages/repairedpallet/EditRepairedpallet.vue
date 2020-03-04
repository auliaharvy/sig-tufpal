<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    EDIT REPAIRED PALLET RECORD
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <repairedpallet-form></repairedpallet-form>
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
    import FormRepairedpallet from './Form.vue'
    export default {
        name: 'EditRepairedpallet',
        created() {
            this.editRepairedpallet(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('repairedpallet', ['editRepairedpallet', 'upadateRepairedpallet']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.upadateRepairedpallet(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'repairedpallet.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        components: {
            'repairedpallet-form': FormRepairedpallet
        },
    }
</script>