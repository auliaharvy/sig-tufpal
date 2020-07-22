<template>
    <div>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.name }">
                    <label for="">Full Name</label>
                    <input type="text" class="form-control" v-model="courier.name" :readonly="$route.name == 'outlets.edit'">
                    <p class="text-danger" v-if="errors.name">{{ errors.name[0] }}</p>
                </div>
            </v-flex>
            <!-- <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.role }">
                    <label for="">Role</label>
                    <v-autocomplete
                    :items="roles"
                    dense
                    solo
                    v-model="courier.role"
                    item-text="roles"
                    item-value="id"
                    clearable
                    >
                    </v-autocomplete>
                </div>
            </v-flex> -->

        </v-layout>
        <v-layout row wrap class="px-5">
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.email }">
                    <label for="">Username</label>
                    <input type="text" class="form-control" v-model="courier.email">
                    <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                 <div class="form-group" :class="{ 'has-error': errors.password }">
                    <label for="">Password</label>
                    <input type="password" class="form-control" v-model="courier.password">
                    <!-- <p class="text-warning">Leave blank if you don't want to change password</p> -->
                    <p class="text-danger" v-if="errors.password">{{ errors.password[0] }}</p>
                </div>
            </v-flex>
            </v-layout>
            <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Pool Pallet</label>
                    <v-autocomplete
                    :items="pools.data"
                    dense
                    solo
                    v-model="courier.reference_pool_pallet_id"
                    item-text="pool_name"
                    item-value="pool_pallet_id"
                    clearable
                    >
                    </v-autocomplete>
                    <!-- <v-autocomplete
                    :items="pools.data"
                    dense
                    solo
                    v-model="courier.reference_pool_pallet_id"
                    item-text="pool_name"
                    item-value="pool_pallet_id"
                    clearable
                    >
                    </v-autocomplete> -->
                    <!-- <select class='form-control' v-model='bermissing.pool_pallet_id'>
                        <option value='0' >Select Pool Pallet</option>
                        <option v-for='data in pools.data' v-bind:key='data.pool_pallet_id' :value='data.pool_pallet_id'>{{ data.pool_name }}</option>
                    </select> -->
                </div>
            </v-flex>
             <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group">
                    <label>Transporter</label>
                    <v-autocomplete
                    :items="transporters.data"
                    dense
                    solo
                    v-model="courier.reference_transporter_id"
                    item-text="transporter_name"
                    item-value="transporter_id"
                    clearable
                    >
                    </v-autocomplete>
                    <!-- <v-autocomplete
                    :items="transporters.data"
                    dense
                    solo
                    v-model="courier.reference_transporter_id"
                    item-text="transporter_name"
                    item-value="transporter_id"
                    clearable
                    >
                    </v-autocomplete> -->
                </div>
            </v-flex>
            <!-- <v-flex class="px-5" xs12 md6 lg6>
               <div class="form-group">
                    <label>Roles</label>
                    <select class='form-control' v-model='courier.role_id'>
                        <option value='0' >Select Roles</option>
                        <option v-for='data in roles.data' v-bind:key='data.id' :value='data.id'>{{ data.name }}</option>
                    </select>
                </div>

            </v-flex> -->
        </v-layout>




        <!-- <div class="form-group" :class="{ 'has-error': errors.outlet_id }">
            <label for="">Role</label>
            <select name="outlet_id" class="form-control" v-model="courier.role_id">
                <option value="">Pilih</option>
                <option v-for="(row, index) in roles.data" :value="row.id" :key="index">{{ row.name }}</option>
            </select>
            <p class="text-danger" v-if="errors.role_id">{{ errors.role_id[0] }}</p>
        </div> -->
    </div>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex'
export default {
    name: 'FormCourier',
    created() {
        this.getPoolForm(),
        this.getDriverForm(),
        this.getTransporterForm(),
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
        ...mapActions('pool', ['getPoolForm']),
        ...mapActions('transporter', ['getTransporterForm']),
        ...mapActions('driver', ['getDriverForm']),
        ...mapActions('user', ['getUserLogin']),
        ...mapActions('outlet', ['getOutlets']),
        ...mapActions('courier', ['submitCourier', 'editCourier', 'updateCourier']),
        ...mapMutations('courier', ['SET_ID_UPDATE']),
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

                this.submitCourier(form).then(() => {
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
