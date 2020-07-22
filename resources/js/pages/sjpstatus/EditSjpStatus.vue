<template>
    <div class="col-md-12">
        <loading :active.sync="loading" 
        :can-cancel="false">
        </loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    RECEIVE SJP STATUS
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <sjpstatus-form ref="FormSjpStatus"></sjpstatus-form>
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
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditSjpStatus',
        created() {
            this.editSjpStatus(this.$route.params.id)
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus', 'updateSjpStatus']),
            submit() {
                this.$refs.FormSjpStatus.receiveCheck()
            },
        },
        computed: {
        ...mapState('sjpstatus', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'sjpstatus-form': FormSjpStatus,
            Loading
        },
    }
</script>