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
                <div class="form-group px-7">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
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
        created() {
            this.editSjpStatus(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus', 'updateSjpStatus']),
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.updateSjpStatus().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
            },
        },
        computed: {
        ...mapState('sjpstatus', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'sjpstatus-form': FormSjpStatus
        },
    }
</script>