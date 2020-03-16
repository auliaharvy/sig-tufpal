<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD NEW BER/MISSING PALLET
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <bermissing-form ref="FormBermissing"></bermissing-form>
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
    import FormBermissing from './Form.vue'
    export default {
        name: 'AddBermissing',
        methods: {
            ...mapActions('bermissing', ['submitBermissing']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                this.$refs.FormBermissing.submit()
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                // this.submitBermissing().then(() => {
                //     //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                //     this.$router.push({ name: 'bermissings.data' })
                // })
            },
        },
        computed: {
        ...mapState('bermissing', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        },
        components: {
            'bermissing-form': FormBermissing //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>