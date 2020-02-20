<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Add Pool Pallet</h3>
            </div>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <pool-form></pool-form>
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
    import FormPool from './Form.vue'
    export default {
        name: 'AddPool',
        data() {
            return {
                
            }
        },
        methods: {
            ...mapActions('pool', ['submitPools']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                this.submitPools().then(() => {
                    //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                    this.$router.push({ name: 'pools.data' })
                })
            }
        },
        components: {
            'pool-form': FormPool //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>