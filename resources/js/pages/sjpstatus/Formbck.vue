<template>
    <div>
        <!-- <div class="form-group">
            <label>SJP Master</label>
            <select class='form-control' v-model='sjpstatus.sjp_id'>
                <option value='0' >Select Departure</option>
                <option v-for='data in sjps.data' :value='data.sjp_id'>{{ data.sjp_number }}</option>
            </select>
        </div> -->
        <div class="form-group" :class="{ 'has-error': errors.sjp_id }">
            <label for="">SJP</label>
            <input type="text" class="form-control" v-model="sjpstatus.sjp_id">
            <p class="text-danger" v-if="errors.sjp_id">{{ errors.sjp_id[0] }}</p>
        </div>
        <!-- <div class="form-group" :class="{ 'has-error': errors.packaging }">
            <label for="">Transaction</label>
            <input type="text" class="form-control" v-model="sjpstatus.transaction_id">
            <p class="text-danger" v-if="errors.transaction_id">{{ errors.transaction_id[0] }}</p>
        </div> -->
        <div class="form-group">
            <label>Select Transaction Type</label>
            <select class='form-control' v-model='sjpstatus.transaction_id'>
                <option v-for='data in msttransactions.data' v-bind:key='data.transaction_id' :value='data.transaction_id'>{{ data.transaction }}</option>
            </select>
        </div>
        <!-- <div class="form-group">
            <label>Checker Sender:</label>
            <select class='form-control' v-model='sjpstatus.checker_send_user_id'>
                <option value='0' >Select User</option>
                <option v-for='data in users.data' :value='data.id'>{{ data.name }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group">
            <label>Checker Sender</label>
            <select class='form-control' v-model='sjpstatus.checker_send_user_id'>
                <option v-for='data in authenticated' :value='authenticated.id'>{{ authenticated.name }}</option>
            </select>
        </div> -->
       <div class="form-group" :class="{ 'has-error': errors.checker_send_user_id }">
            <label for="">Checker</label>
            <input  type="text" class="form-control" v-model="sjpstatus.checker_send_user_id" :readonly="$route.name == 'sjpstatuss.edit'">
            <p class="text-danger" v-if="errors.checker_send_user_id">{{ errors.checker_send_user_id[0] }}</p>
        </div>
        <!-- <div class="form-group" :class="{ 'has-error': errors.checker_receive_user_id }" >
            <label for="">Checker Receive</label>
            <input type="text" class="form-control" v-model="sjpstatus.checker_receive_user_id" :readonly="$route.name == 'sjpstatuss.add'">
            <p class="text-danger" v-if="errors.checker_receive_user_id">{{ errors.checker_receive_user_id[0] }}</p>
        </div> -->
        <!-- <div class="form-group" :readonly="$route.name == 'sjpstatuss.add'">
            <label>Checker Receive</label>
            <select class='form-control' v-model='sjpstatus.checker_receive_user_id' :readonly="$route.name == 'sjpstatuss.add'">
                <option v-for='data in authenticated'  :value='authenticated.id'>{{ authenticated.name }}</option>
            </select>
        </div> -->
        <!-- <div class="form-group" :class="{ 'has-error': errors.sjp_id }">
            <label for="">SJP Master</label>
            <input type="text" class="form-control" v-model="sjpstatus.sjp_id">
            <p class="text-danger" v-if="errors.sjp_id">{{ errors.sjp_id[0] }}</p>
        </div> -->
        <div class="form-group" :class="{ 'has-error': errors.good_pallet }">
            <label for="">Good Pallet</label>
            <input type="text" class="form-control" v-model="sjpstatus.good_pallet">
            <p class="text-danger" v-if="errors.good_pallet">{{ errors.good_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.tbr_pallet }">
            <label for="">Tbr Pallet</label>
            <input type="text" class="form-control" v-model="sjpstatus.tbr_pallet">
            <p class="text-danger" v-if="errors.tbr_pallet">{{ errors.tbr_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.ber_pallet }">
            <label for="">Ber Pallet</label>
            <input type="text" class="form-control" v-model="sjpstatus.ber_pallet">
            <p class="text-danger" v-if="errors.ber_pallet">{{ errors.ber_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.missing_pallet }">
            <label for="">Missing Pallet</label>
            <input type="text" class="form-control" v-model="sjpstatus.missing_pallet">
            <p class="text-danger" v-if="errors.missing_pallet">{{ errors.missing_pallet[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.good_cement }">
            <label for="">Good Cement</label>
            <input type="text" class="form-control" v-model="sjpstatus.good_cement">
            <p class="text-danger" v-if="errors.good_cement">{{ errors.good_cement[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.bad_cement }">
            <label for="">Bad Cement</label>
            <input type="text" class="form-control" v-model="sjpstatus.bad_cement">
            <p class="text-danger" v-if="errors.bad_cement">{{ errors.bad_cement[0] }}</p>
        </div>
        
        <div class="form-group" :class="{ 'has-error': errors.note }">
            <label for="">Note</label>
            <input type="text" class="form-control" v-model="sjpstatus.note">
            <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
        </div>
        
    </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
export default {
    name: 'FormSjpStatus',
    created() {
        this.getSjp(), 
        this.getMstTransaction(), 
        this.getUserLogin() //LOAD DATA
    },
   
    computed: {
        ...mapState(['errors']), //LOAD STATE ERROR UNTUK DITAMPILKAN KETIKA TERJADI ERROR VALIDASI
        ...mapState('sjpstatus', {
            sjpstatus: state => state.sjpstatus //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('sjp', {
            sjps: state => state.sjps //MENGAMBIL DATA CUSTOMER DARI STATE CUSTOMER
        }),
        ...mapState('msttransaction', {
            msttransactions: state => state.msttransactions
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
    },
    methods: {
        sendBackCheck(){
            this.editSjp(this.sjpstatus.sjp_id).then((res) => {
                let row = res.data
                var sendData = this.sendSjpStatus
                var data = this.sjpstatus
                var checkContent = 
                "<div><strong><span>" + 
                "<p> | Send Good Pallet : <b>" + sendData.good_pallet + " </b> | Receive Good Pallet : <b> " + data.good_pallet + " </b> | </p>" + 
                "<p> | Send TBR Pallet : <b> " + sendData.tbr_pallet  + " </b> | Receive TBR Pallet : <b> " + data.tbr_pallet + " </b> | </p>" +
                "<p> | Send BER Pallet : <b> " + sendData.ber_pallet  + " </b> | Receive BER Pallet : <b> " + data.ber_pallet + " </b> | </p>" +
                "<p> | Send Missing Pallet : <b> " + sendData.missing_pallet  + " </b> | Receive Missing Pallet : <b> " + data.missing_pallet + " </b> | </p>" +
                "</span> </strong></div>"
                        
                this.$swal({
                    title: "Receive " + row.sjp_number,
                    text: "...<div>" + checkContent + "</div>...",
                    html: "...<div>" + checkContent +   "</div>...",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Receive!'
                }).then((result) => {
                    if (result.value) {
                        this.submit() //JIKA SETUJU MAKA PERMINTAAN HAPUS AKAN DI EKSEKUSI
                    }
                })
            })
        },
        ...mapMutations('sjpstatus', ['CLEAR_FORM']), 
        ...mapActions('sjp', ['getSjp']),
        ...mapActions('msttransaction', ['getMstTransaction']),
        ...mapActions('user', ['getUserLogin']),
       
    },
   
    destroyed() {
        this.CLEAR_FORM() //KETIKA COMPONENT DITINGGALKAN, BERSIHKAN DATA
    }
}
</script>

