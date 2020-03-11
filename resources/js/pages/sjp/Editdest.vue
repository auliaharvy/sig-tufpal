<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    SJP CHANGE DESTIANTION
                </h1>
            </v-toolbar>
            <div class="panel-body">
                <sjp-form></sjp-form>
                <div class="form-group">
                    <v-btn :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Adjust' }}
                    </v-btn>
                    <v-btn class="error px-5" @click.prevent="resetLoading()">
                        Reset
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormSjp from './Formeditdest.vue'
    export default {
        name: 'EditSjpdest',
        data() {
            return {
               loading: false, 
            }
        },
        created() {
            this.editSjp(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        methods: {
            ...mapActions('sjp', ['editSjp', 'updateSjpchangedest']),
            submit() {
                this.loading = true
                //MENGIRIM PERMINTAAN KE SERVER UNTUK ME-NGUBAH DATA
                this.updateSjpchangedest(this.$route.params.id).then(() => {
                    this.$router.push({ name: 'sjps.data' }) //KETIKA UPDATE BERHASIL, MAKA REDIRECT KE HALAMAN LIST CUSTOMER
                })
            },
            resetLoading() {
                this.loading = false
            }
        },
        components: {
            'sjp-form': FormSjp
        },
    }
</script>