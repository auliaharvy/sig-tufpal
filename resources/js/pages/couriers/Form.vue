<template>
    <div>
        <div class="form-group" :class="{ 'has-error': errors.name }">
            <label for="">Full Name</label>
            <input type="text" class="form-control" v-model="courier.name" :readonly="$route.name == 'outlets.edit'">
            <p class="text-danger" v-if="errors.name">{{ errors.name[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.email }">
            <label for="">Username</label>
            <input type="text" class="form-control" v-model="courier.email">
            <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.password }">
            <label for="">Password</label>
            <input type="password" class="form-control" v-model="courier.password">
            <p class="text-warning">Leave blank if you don't want to change password</p>
            <p class="text-danger" v-if="errors.password">{{ errors.password[0] }}</p>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.outlet_id }">
            <label for="">Role</label>
            <select name="outlet_id" class="form-control" v-model="courier.role_id">
                <option value="">Pilih</option>
                <option v-for="(row, index) in roles.data" :value="row.id" :key="index">{{ row.name }}</option>
            </select>
            <p class="text-danger" v-if="errors.role_id">{{ errors.role_id[0] }}</p>
        </div>
    </div>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex'
export default {
    name: 'FormCourier',
    created() {
        this.getOutlets(),
        this.getRoles()
        if (this.$route.name == 'couriers.edit') {
            this.editCourier(this.$route.params.id).then((res) => {
                this.courier = {
                    name: res.data.name,
                    email: res.data.email,
                    password: '',
                    photo: '',
                    outlet_id: res.data.outlet_id
                }
            })
        }
    },
    data() {
        return {
            courier: {
                name: '',
                email: '',
                password: '',
                photo: '',
                outlet_id: ''
            }
        }
    },
    computed: {
        ...mapState(['errors']),
        ...mapState('outlet', {
            outlets: state => state.outlets
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
            form.append('outlet_id', this.courier.outlet_id)
            form.append('photo', this.courier.photo)

            if (this.$route.name == 'couriers.add') {
                this.submitCourier(form).then(() => {
                    this.courier = {
                        name: '',
                        email: '',
                        password: '',
                        photo: '',
                        outlet_id: ''
                    }
                    this.$router.push({ name: 'couriers.data' })
                })
            } else if (this.$route.name == 'couriers.edit') {
                this.SET_ID_UPDATE(this.$route.params.id)
                this.updateCourier(form).then(() => {
                    this.courier = {
                        name: '',
                        email: '',
                        password: '',
                        photo: '',
                        outlet_id: ''
                    }
                    this.$router.push({ name: 'couriers.data' })
                })
            }
        }
    }
}
</script>
