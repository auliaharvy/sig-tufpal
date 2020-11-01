<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD ORGANIZATION
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <organization-form></organization-form>
                <div class="form-group px-7">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Add' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormOrganization from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'AddOrganization',
        data() {
            return {

            }
        },
        methods: {
            ...mapActions('organization', ['submitOrganization']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitOrganization().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'organizations.data' })
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
        }
    }
</script>
