<template>
    <div class="col-md-12">
        <div class="panel">
            <v-toolbar dark>
                <h1>
                    DRIVER APPROVAL
                </h1>
            </v-toolbar>
            <div class="panel-body">
              	<!-- LOAD VIEW DARI FORM.VUE -->
                <driverapproval-form ref="FormDriverApproval"></driverapproval-form>
                <div class="form-group">
                    <v-btn :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Approve' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState, mapMutations } from 'vuex'
    import FormDriverApproval from './DriverApprovalForm.vue'
    export default {
        name: 'DriverApproval',
        created() {
            this.editSjpStatus(this.$route.params.id) //LOAD SINGLE DATA CUSTOMER BERDASARKAN ID
        },
        data() {
            return {
               loading: false, 
            }
        },
        methods: {
            ...mapActions('sjpstatus', ['editSjpStatus', 'submitSjpStatus']),
            ...mapActions('sjp', ['editSjp', 'updateSjp']),
            //KETIKA TOMBOL DITEKAN MAKA FUNGSI INI AKAN DIJALANKAN
            submit() {
                this.$refs.FormDriverApproval.submit()
                //MELAKUKAN REQUEST KE SERVER UNTUK MENAMBAHKAN DATA
                // this.submitBermissing().then(() => {
                //     //KEMUDIAN REDIRECT KE HALAMAN LIST CUSTOMERS
                //     this.$router.push({ name: 'bermissings.data' })
                // })
            },
        },
        components: {
            'driverapproval-form': FormDriverApproval //MEMBUAT CUSTOM TAG UNTUK ME-LOAD FILE FORM.VUE
        }
    }
</script>