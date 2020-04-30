<template>
<v-app>
    <loading :active.sync="loading" 
        :can-cancel="false" 
        :is-full-page="fullPage"></loading>
    <!-- <v-parallax height="850" :src="require('../assets/pallet.jpg')"> -->
    <v-container class="fill-height" fluid >
        <v-row align="center" justify="center">
            <v-col cols="12" sm="8" md="4">
                <v-card class="elevation-12">
                    <v-toolbar color="primary" dark flat>
                        <v-toolbar-title><b>Tufpal</b>System</v-toolbar-title>
                    </v-toolbar>
                    <v-card-text>
                        <v-form>
                            <div class="form-group has-feedback" :class="{'has-error': errors.email}">
                            <v-text-field
                            label="Username"
                            v-model="data.email"
                            prepend-icon="mdi-account"
                            type="text"
                            required
                            />
                            <!-- <span class="glyphicon glyphicon-envelope form-control-feedback"></span> -->
                            <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
                            </div>
                            <!-- <v-text-field
                            label="Email"
                            v-model="data.email"
                            prepend-icon="mdi-account"
                            type="text"
                            required 
                            /> -->
                            <div class="form-group has-feedback" :class="{'has-error': errors.password}">
                            <v-text-field
                            id="password"
                            label="Password"
                            v-model="data.password"
                            prepend-icon="mdi-lock"
                            type="password"
                            required
                            />
                            <!-- <span class="glyphicon glyphicon-lock form-control-feedback"></span> -->
                            <p class="text-danger" v-if="errors.password">{{ errors.password[0] }}</p>
                            </div>
                            <div class="alert alert-danger" v-if="errors.invalid">{{ errors.invalid }}</div>
                            <!-- <v-text-field
                            id="password"
                            label="Password"
                            v-model="data.password"
                            prepend-icon="mdi-lock"
                            type="password"
                            required
                            /> -->
                        </v-form>
                    </v-card-text>
                    <v-card-actions>
                        <v-checkbox v-model="data.remember_me" label="Remember Me"></v-checkbox>
                        <v-spacer />
                        <v-btn :disabled="loading" :loading="loading" type="submit" color="primary" @click="postLogin">Login</v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
    <!-- </v-parallax> -->
</v-app>
    <!-- <div class="container">
        <div class="login-box">
            <div class="login-logo">
                <router-link :to="{ name: 'home' }"><b>DW</b>Laundry</router-link>
            </div>
            <div class="login-box-body">
                <p class="login-box-msg">Sign in to start your session</p>

                <div class="form-group has-feedback" :class="{'has-error': errors.email}">
                    <input type="email" class="form-control" placeholder="Email" v-model="data.email">
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
                </div>
                <div class="form-group has-feedback" :class="{'has-error': errors.password}">
                    <input type="password" class="form-control" placeholder="Password" v-model="data.password">
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    <p class="text-danger" v-if="errors.password">{{ errors.password[0] }}</p>
                </div>
                <div class="alert alert-danger" v-if="errors.invalid">{{ errors.invalid }}</div>
                <div class="row">
                    <div class="col-xs-8">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" v-model="data.remember_me"> Remember Me
                            </label>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <button type="submit" class="btn btn-primary btn-block btn-flat" @click.prevent="postLogin">Login</button>
                    </div>
                </div>

                <a href="#">I forgot my password</a><br>
            </div>
        </div>
    </div> -->
</template>

<script>
import { mapActions, mapMutations, mapGetters, mapState } from 'vuex';
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default {
    data() {
        return {
            data: {
                email: '',
                password: '',
                remember_me: false
            }
        }
    },
    components: {
            Loading
        },
    created() {
        if (this.isAuth) {
            this.$router.push({ name: 'home' })
        }
    },
    computed: {
        ...mapGetters(['isAuth']),
        ...mapState(['errors']),
        ...mapState('auth', {
            loading: state => state.loading //LOAD DATA CUSTOMER DARI STATE CUSTOMER
        }),
    },
    methods: {
        ...mapActions('auth', ['submit']),
        ...mapActions('user', ['getUserLogin']),
        ...mapMutations(['CLEAR_ERRORS']),
        postLogin() {
            this.submit(this.data).then(() => {
                if (this.isAuth) {
                    this.CLEAR_ERRORS()
                    this.$router.push({ name: 'home' })
                }
            })
        }
    },
    destroyed() {
        this.getUserLogin()
    }
}
</script>
