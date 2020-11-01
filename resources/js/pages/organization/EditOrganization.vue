<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Edit Organization</h3>
            </div>
            <div class="panel-body">
                <organization-form></organization-form>
                <div class="form-group px-7">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Edit' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormOrganization from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditPool',
        created() {
            this.editOrganization(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('organization', ['editOrganization', 'updateOrganization']),
            submit() {
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateOrganization(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'organizations.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            }
        },
        computed: {
        ...mapState('organization', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'organization-form': FormOrganization,
            Loading
        },
    }
</script>
