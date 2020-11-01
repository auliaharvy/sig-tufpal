<template>
    <div>
        <!-- <div class="form-group">
            <label>Select SJP</label>
            <select class='form-control' v-model='sjpstatus.sjp_id'>
                <option value='0' >Select SJP</option>
                <option v-for='data in sjps.data' :value='data.sjp_id'>{{ data.sjp_number }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group">
            <label>Checker Sender:</label>
            <select class='form-control' v-model='sjpstatus.checker_send_user_id'>
                <option value='0' >Select User</option>
                <option v-for='data in users.data' :value='data.id'>{{ data.name }}</option>
            </select>
        </div> -->
        <v-layout row wrap class="px-5">
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.organization_name }">
                    <label for="">Organization Name</label>
                    <input type="text" class="form-control" v-model="organization.organization_name">
                    <p class="text-danger" v-if="errors.organization_name">{{ errors.organization_name[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.organization_address }">
                    <label for="">organization Address</label>
                    <input type="text" class="form-control" v-model="organization.organization_address">
                    <p class="text-danger" v-if="errors.organization_address">{{ errors.organization_address[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                 <div class="form-group" :class="{ 'has-error': errors.phone_number }">
                    <label for="">Phone Number</label>
                    <input type="text" class="form-control" v-model="organization.phone_number">
                    <p class="text-danger" v-if="errors.phone_number">{{ errors.phone_number[0] }}</p>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.organization_email }">
                    <label for="">Organization Email</label>
                    <input type="text" class="form-control" v-model="organization.organization_email">
                    <p class="text-danger" v-if="errors.organization_email">{{ errors.organization_email[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormPool',
    created() {
        this.getOrganization()//LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    },
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('organization', {
            organization: state => state.organization //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('organization', {
            organizations: state => state.organizations
        }),
    },
    methods: {
        ...mapMutations('organization', ['CLEAR_FORM']),
        ...mapActions('organization', ['getOrganization']),
    },
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

