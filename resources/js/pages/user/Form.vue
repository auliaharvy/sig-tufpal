<template>
    <div>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.name }">
                    <label for="">Full Name</label>
                    <input type="text" class="form-control" v-model="courier.name" :readonly="$route.name == 'outlets.edit'">
                    <p class="text-danger" v-if="errors.name">{{ errors.name[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.email }">
                    <label for="">Username</label>
                    <input type="text" class="form-control" v-model="courier.email">
                    <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
                </div>

            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                 <div class="form-group" :class="{ 'has-error': errors.password }">
                    <label for="">Password</label>
                    <input type="password" class="form-control" v-model="courier.password">
                    <!-- <p class="text-warning">Leave blank if you don't want to change password</p> -->
                    <p class="text-danger" v-if="errors.password">{{ errors.password[0] }}</p>
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
        this.getOutlets(),
        this.getRoles()
    },
    data() {
        return {
            courier: {
                name: '',
                email: '',
                password: '',
                photo: '',
                role: ''
            }
        }
    },
    computed: {
        ...mapState(['errors']),
        ...mapState('user', {
            roles: state => state.roles
        })
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
            form.append('role', this.courier.role)
            form.append('photo', this.courier.photo)

                this.submitCourier(form).then(() => {
                    this.courier = {
                        name: '',
                        email: '',
                        password: '',
                        photo: '',
                        role: ''
                    }
                    this.$router.push({ name: 'users.data' })
                })
        }
    }
}
</script>
