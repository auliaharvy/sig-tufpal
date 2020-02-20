<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    ADD NEW SJP STATUS
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <sjpstatus-form></sjpstatus-form>
                <div class="form-group">
                    <v-btn class="success" @click.prevent="submit">
                        Add New
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormSjpStatus from './Form.vue'
    export default {
        name: 'AddSjpStatus',
        data() {
            return {
                
            }
        },
        methods: {
            ...mapActions('sjpstatus', ['submitSjpStatus']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitSjpStatus().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'sjpstatuss.data' })
                })
            }
        },
        components: {
            'sjpstatus-form': FormSjpStatus //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>