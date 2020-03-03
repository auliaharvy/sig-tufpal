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
    
       <!-- <div class="form-group" :class="{ 'has-error': errors.organization_id }">
            <label for="">Organization</label>
            <input type="text" class="form-control" v-model="pool.organization_id" :readonly="$route.name == 'pools.edit'">
            <p class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</p>
        </div> -->
        <div class="form-group">
            <label>Organization</label>
            <select class='form-control' v-model='transporters.organization_id'>
                <option value='0' >Select Organization</option>
                <option v-for='data in organizations.data' :value='data.organization_id'>{{ data.organization_name }}</option>
            </select>
        </div>
        <!-- <div class="form-group" :class="{ 'has-error': errors.code }">
            <label for="">Code</label>
            <input type="text" class="form-control" v-model="pool.code" :readonly="$route.name == 'pools.edit'">
            <p class="text-danger" v-if="errors.code">{{ errors.code[0] }}</p>
        </div> -->
        <!-- <div class="form-group">
            <label>Pool Pallet Type:</label>
            <select class='form-control' v-model='pool.type'>
                <option value='0' >Select Type</option>
                <option>{{ type }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.sjp_id }">
            <label for="">SJP Master</label>
            <input type="text" class="form-control" v-model="sjpstatus.sjp_id">
            <p class="text-danger" v-if="errors.sjp_id">{{ errors.sjp_id[0] }}</p>
        </div> -->
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    created() {
        this.getOrganization()//LOAD DATA SJP KETIKA COMPONENT DI-LOAD
    }, 
    data() {
        return {
            //FIELD YANG AKAN DITAMPILKAN PADA TABLE DIATAS
            // type: [
            //     POOL_PALLET_DLI,
            //     WAREHOUSE,
            //     STATION,
            //     DISTRIBUTOR/STORE,
            //     WORKSHOP
            // ],
            search: ''
        }
    },
    name: 'FormPool',   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('transporter', {
            transporter: state => state.transporter //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('transporter', {
            transporters: state => state.transporters //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('organization', {
            organizations: state => state.organizations
        }),
    },
    methods: {
        ...mapMutations('transporter', ['CLEAR_FORM']), 
        ...mapActions('transporter', ['getTransporters']),
        ...mapActions('organization', ['getOrganization']),
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

