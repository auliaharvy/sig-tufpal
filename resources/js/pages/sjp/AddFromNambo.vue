<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false">
        </loading>
        <div class="panel">
                <v-toolbar dark>
                <h1>
                    ADD NEW SJP
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <sjp-form ref="FormSjp"></sjp-form>
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
    import FormSjp from './FormNambo.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'AddSjp',
        methods: {
            ...mapActions('sjp', ['submitSjp']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                this.$refs.FormSjp.submit()
            },
        },
        computed: {
        ...mapState('sjp', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'sjp-form': FormSjp,
            Loading
        }
    }
</script>
