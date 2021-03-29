<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD DAMAGED PALLET
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <damagedpallet-form></damagedpallet-form>
                <div class="form-group">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'add' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormDamagedpallet from './Form.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'AddDamagedPallet',
        methods: {
            ...mapActions('damagedpallet', ['submitDamagedpallet']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitDamagedpallet().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'damagedpallets.data' })
                })
            },
        },
        computed: {
        ...mapState('damagedpallet', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'damagedpallet-form': FormDamagedpallet,
            Loading
        }
    }
</script>
