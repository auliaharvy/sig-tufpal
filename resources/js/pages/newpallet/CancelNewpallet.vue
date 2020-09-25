<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    CANCEL NEW PALLET
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <newpallet-form></newpallet-form>
                <div class="form-group">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Cancel New Pallet' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormNewpallet from './FormCancelNewpallet.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'CancelNewpallet',
        created() {
            this.editNewpallet(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('newpallet', ['editNewpallet','cancelNewpallet']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.cancelNewpallet().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'newpallets.data' })
                })
            },
        },
        computed: {
        ...mapState('newpallet', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'newpallet-form': FormNewpallet,
            Loading
        }
    }
</script>
