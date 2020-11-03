<template>
    <div>
        <v-layout row wrap class="px-5">
             <v-flex class="px-5" xs12 md4 lg4>
                <div class="form-group" :class="{ 'has-error': errors.email }">
                    <label for="">Username</label>
                    <input type="text" class="form-control" v-model="courier.email" :readonly="true">
                    <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md4 lg4>
                <div class="form-group">
                    <label>Pool Pallet</label>
                    <template v-if="courier.reference_pool_pallet_id == null">
                        <select class='form-control' v-model='courier.reference_pool_pallet_id' :readonly="true">
                            <option disabled v-for='data in pools.data' v-bind:key='data.pool_pallet_id' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
                        </select>
                    </template>
                    <template v-if="courier.reference_pool_pallet_id != null">
                        <select class='form-control' v-model='courier.reference_pool_pallet_id'>
                            <option v-for='data in pools.data' v-bind:key='data.pool_pallet_id' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
                        </select>
                    </template>
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md4 lg4>
                <div class="form-group">
                    <label>Transporter</label>
                    <template v-if="courier.reference_transporter_id == null">
                        <select class='form-control' v-model='courier.reference_transporter_id' :readonly="true">
                            <option disabled v-for='data in transporters.data' v-bind:key='data.transporter_id' :value='data.transporter_id'>{{ data.transporter_name }}</option>
                        </select>
                    </template>
                    <template v-if="courier.reference_transporter_id != null">
                        <select class='form-control' v-model='courier.reference_transporter_id'>
                            <option v-for='data in transporters.data' v-bind:key='data.transporter_id' :value='data.transporter_id'>{{ data.transporter_name }}</option>
                        </select>
                    </template>
                </div>
            </v-flex>
            </v-layout>
        <v-layout row wrap class="px-5">
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.name }">
                    <label for="">Full Name</label>
                    <input type="text" class="form-control" v-model="courier.name">
                    <p class="text-danger" v-if="errors.name">{{ errors.name[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                 <div class="form-group" :class="{ 'has-error': errors.password }">
                    <label for="">Password</label>
                    <input type="password" id="password" class="form-control" v-model="courier.password">
                    <!-- <p class="text-warning">Leave blank if you don't want to change password</p> -->
                    <p class="text-danger" v-if="errors.password">{{ errors.password[0] }}</p>
                    <v-btn  @click="passwordHide()">
                        show password
                    </v-btn>
                </div>
            </v-flex>
            </v-layout>
    </div>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex'
export default {
    name: 'FormCourier',
    created() {
        this.editCourier(this.$route.params.id).then((res) => {
                this.courier = {
                    name: res.data.name,
                    email: res.data.email,
                    password: '',
                    reference_pool_pallet_id: res.data.reference_pool_pallet_id,
                    reference_transporter_id: res.data.reference_transporter_id,
                    reference_driver_id: res.data.reference_driver_id,
                    }
            }),
        this.getPools(),
        this.getTransporters(),
        this.getDrivers(),
        this.getUserLogin(),
        this.getOutlets(),
        this.getRoles()
    },
    data() {
        return {
            courier: {
                name: '',
                email: '',
                password: '',
                reference_pool_pallet_id: '',
                reference_transporter_id: '',
                reference_driver_id:'',
                photo: '',
                // role: ''
            }
        }
    },
    computed: {
        ...mapState(['errors']),
        ...mapState('user', {
            roles: state => state.roles
        }),
        ...mapState('pool', {
            pools: state => state.pools
        }),
        ...mapState('transporter', {
            transporters: state => state.transporters
        }),
        ...mapState('driver', {
            drivers: state => state.drivers
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
    },
    methods: {
        ...mapActions('user', [
                'getUserLists',
                'getRoles',
                'getAllPermission',
                'getRolePermission',
                'setRolePermission',
                'setRoleUser'
            ]),
        ...mapActions('pool', ['getPools']),
        ...mapActions('transporter', ['getTransporters']),
        ...mapActions('driver', ['getDrivers']),
        ...mapActions('user', ['getUserLogin']),
        ...mapActions('outlet', ['getOutlets']),
        ...mapActions('courier', ['editCourier', 'updateCourier', 'getCouriers']),
        ...mapMutations('courier', ['SET_ID_UPDATE']),
        passwordHide(){
            let passwordField = document.querySelector('#password')

            if(passwordField.getAttribute('type') === 'password') passwordField.setAttribute('type', 'text')
            else passwordField.setAttribute('type', 'password')
        },
        uploadImage(event) {
            this.courier.photo = event.target.files[0]
        },
        submit() {
            let form = new FormData()
            form.append('name', this.courier.name)
            form.append('email', this.courier.email)
            form.append('password', this.courier.password)
            form.append('reference_pool_pallet_id', this.courier.reference_pool_pallet_id)
            form.append('reference_transporter_id', this.courier.reference_transporter_id)
            form.append('reference_driver_id', this.courier.reference_driver_id)
            // form.append('role', this.courier.role)
            form.append('photo', this.courier.photo)
                this.SET_ID_UPDATE(this.$route.params.id)
                this.updateCourier(form).then(() => {
                    this.courier = {
                        name: '',
                        email: '',
                        password: '',
                        reference_pool_pallet_id: '',
                        reference_transporter_id: '',
                        reference_driver_id:'',
                        photo: '',
                        // role: ''
                    }
                    this.$router.push({ name: 'user.data' })
                })
        }
    }
}
</script>
