<template>
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <router-link v-if="$can('create users')" :to="{ name: 'user.add' }"><v-btn>Add User</v-btn></router-link>
            </div>
            <div class="panel-body">
                <v-card>
                    <v-card-title>
                    User
                    <v-spacer></v-spacer>
                    <v-text-field
                        v-model="search"
                        prepend-icon="mdi-search"
                        label="Search"
                        single-line
                        hide-details
                    ></v-text-field>
                    </v-card-title>
                    <v-data-table
                    :headers="headers"
                    :items="couriers.data"
                    :search="search"
                    >
                    </v-data-table>
                </v-card>
            </div>
        </div>
    </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

export default {
    name: 'DataCourier',
    created() {
        this.getCouriers()
    },
    data() {
        return {
            headers: [
                { value: 'name', text: 'Full Name' },
                { value: 'email', text: 'Username' },
                { value: 'pool_name', text: 'Pool Name' },
                { value: 'transporter_name', text: 'Transporter Name' },
                // { value: 'actions', text: 'Action'}
            ],
            search: ''
        }
    },
    computed: {
        ...mapState('courier', {
            couriers: state => state.couriers
        }),
        page: {
            get() {
                return this.$store.state.courier.page
            },
            set(val) {
                this.$store.commit('courier/SET_PAGE', val)
            }
        }
    },
    watch: {
        page() {
            this.getCouriers()
        },
        search() {
            this.getCouriers(this.search)
        }
    },
    methods: {
        ...mapActions('courier', ['getCouriers', 'removeCourier']),
        deleteCourier(id) {
            this.$swal({
                title: 'Kamu Yakin?',
                text: "Tindakan ini akan menghapus secara permanent!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Iya, Lanjutkan!'
            }).then((result) => {
                if (result.value) {
                    this.removeCourier(id)
                }
            })
        }
    }
}
</script>
