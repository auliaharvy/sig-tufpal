<template>
    <div class="col-md-12">
        <loading :active.sync="loading"
        :can-cancel="false"
       ></loading>
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Edit User</h3>
            </div>
            <div class="panel-body">
                <courier-form ref="courierForm"></courier-form>
                <div class="form-group px-7">
                    <v-btn :disabled="loading" :loading="loading" class="success" @click.prevent="submit()">
                        {{ loading ? 'Loading...':'Submit' }}
                    </v-btn>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions, mapState } from 'vuex'
    import FormCourier from './FormeditProfile.vue'
    import Loading from 'vue-loading-overlay';
    import 'vue-loading-overlay/dist/vue-loading.css';

    export default {
        name: 'EditCourier',
        methods: {
            submit() {
                this.$refs.courierForm.submit()
            }
        },
        computed: {
        ...mapState('courier', {
            loading: state => state.loading
        }),
        },
        components: {
            'courier-form': FormCourier,
            Loading
        }
    }
</script>
