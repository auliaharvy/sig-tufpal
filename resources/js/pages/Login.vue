
<style>
html, body, h1, h2, h3, h4, h5 {font-family: "Open Sans", sans-serif}
.login-page {
  width: 360px;
  padding: 8% 0 0;
  margin-left: 70%;
  margin-top: -250px;
}
.top{
  height: 55px;
  background-color: white;
}
.first{
  height: 500px;
  background-color: black;
  
}
.first img{
  opacity: 0.8;
}
.firstone{
  font: 40px/40px arial;
  color: white;
  text-shadow: 2px 2px orangered;
}
.firstoneone{
  position: relative;
  font: 20px/20px arial;
  color: white;
}
.second{
  margin-top: 70px;
  height: 500px;
  width: 99%;
  background-color: black;
  position: absolute;
}
.secondone{
  font: 40px/40px arial;
  color: white;
  text-shadow: 2px 2px orangered;
}
.secondoneone{
  position: relative;
  font: 20px/20px arial;
  color: white;
}
.second img{
  opacity: 0.8;
}
.third{
  margin-top: 485px;
  height: 700px;
  width: 99%;
  background-color: black;
  position: absolute;
}
.thirdone{
  font: 40px/40px arial;
  color: white;
  text-shadow: 2px 2px orangered;
}
.thirdoneone{
  position: relative;
  font: 20px/20px arial;
  color: white;
}
.third img{
  opacity: 0.8;
}
.fourth{
  margin-top: 1100px;
  height: 800px;
  width: 99%;
  background-color: black;
  position: absolute;
}
.fourthone{
  top: 1300px;
  left: 650px;	
  height: 100px;
  width: 600px;
  position: relative;
  font: 40px/40px arial;
  color: white;
}
.fourthoneone{
  position: relative;
  font: 20px/20px arial;
  color: white;
}
.fourth img{
  opacity: 0.8;
}
.footer{
  margin-top: 1810px;
  padding-left: 25px;
  padding-top: 15px;
  width: 97.2%;
  height: 45px;
  background-color: black;
  color: white;
  position: absolute;
  font: 20px/20px arial;
}
.footerimage{
  background-color: green;
  width: 150px;
  height: 42px;
}
.logo{
  width: 58px;
  height: 37px;
  background-color: red;
  position: absolute;
  margin-top: 10px;
  margin-left: 10px;
}
.logotext{
  width: 58px;
  height: 37px;
  position: absolute;
  margin-left: 80px;
  margin-top: 15px;
  font: 30px/30px verdana;
}
.dli{
  left: 90%;
  top: 3%;
  width: 240px;
  height: 67px;
  position: absolute;
}
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 300px;
  max-height: 300px;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #FD6302;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: #000000;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #FD6302;
  text-decoration: none;
}
.form .register-form {
  display: none;
}

.gambar{
  position: absolute !important;
  border: 1px solid black;
}
body {
  background: #FFFFFF; /* fallback for old browsers */
  background: -webkit-linear-gradient(right, #FFFFFF, #FFFFFF);
  background: -moz-linear-gradient(right, #FFFFFF, #FFFFFF);
  background: -o-linear-gradient(right, #FFFFFF, #FFFFFF);
  background: linear-gradient(to left, #FFFFFF, #FFFFFF);
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;      
}
</style>
<template>
<v-app>
    <loading :active.sync="loading" 
        :can-cancel="false">
    </loading>
    <v-app-bar app color="white">
        <router-link to="/">
            <v-toolbar-title link router to="/map" app class="text-uppercase font-weight-light">
                <v-col class="text-center">
                    <img height="50px" width="50px" src="../assets/android-chrome 512x512.png">
                    <a style="width: 58px;
                            height: 37px;
                            position: absolute;
                            margin-left: 20px;
                            margin-top: 13px;
                            font: 30px/30px verdana;
                            color: black;"
                    >
                        Tufpal
                    </a>
                </v-col>
            </v-toolbar-title>
        </router-link>
        <v-spacer></v-spacer>
        <v-btn text @click="dialog = true">
            <span left>Login</span>
            <v-icon right color="black">mdi-account-arrow-right</v-icon>
        </v-btn>
    </v-app-bar>
    <v-dialog v-model="dialog" persistent max-width="600px">
        <v-container class="fill-height" fluid >
            <v-row align="center" justify="center">
                <v-col cols="12" sm="12" md="12">
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
                                <p class="text-danger" v-if="errors.email">{{ errors.email[0] }}</p>
                                </div>
                                <div class="form-group has-feedback" :class="{'has-error': errors.password}">
                                <v-text-field
                                id="password"
                                label="Password"
                                v-model="data.password"
                                prepend-icon="mdi-lock"
                                type="password"
                                required
                                />
                                <p class="text-danger" v-if="errors.password">{{ errors.password[0] }}</p>
                                </div>
                                <div class="alert alert-danger" v-if="errors.invalid">{{ errors.invalid }}</div>
                            </v-form>
                        </v-card-text>
                        <v-card-actions>
                            <v-checkbox v-model="data.remember_me" label="Remember Me"></v-checkbox>
                            <v-spacer />
                            <v-btn
                                color="red darken-1"
                                text
                                @click="dialog = false"
                            >
                                Close
                            </v-btn>
                            
                            <v-btn :disabled="loading" :loading="loading" type="submit" color="primary" @click="postLogin">Login</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </v-dialog>
    <v-container fluid>
        <v-card>
            <v-parallax dark height="500" :src="require('../assets/gambarpallet2.jpg')">
            <div class="firstone">
                Pallet Management by <img class="pb-5" src="../assets/logotoolbar.png">
                <div class="firstoneone">
                    Deep visibility and control for supply chain
                </div>
            </div>
            </v-parallax>
        </v-card>
    </v-container>
    <v-container fluid>
        <v-card>
            <v-parallax dark height="500" :src="require('../assets/gudang pallet1.jpg')">
            <v-card flat img="../assets/gudang pallet1.jpg'" class="px-10">
                <v-row align="center" justify="end">
                    <v-flex  xs12 md6 lg6>
                        <div class="secondone">
                            Gudang Pallet
                            <div class="secondoneone">
                                <p>
                                Pallet manajemen adalah pelayanan kami untuk mengatur dan memonitor keberadaan palet, baik palet bagus, rusak maupun palet hilang. Lalu lintas keluar masuk palet dimulai dari pool palet, berupa gudang seluas kira 2160 meter persegi, untuk siap dikirim ke pabrik atau workshop perbaikan palet, sampai dengan kembali lagi ke pool palet.
                                </p>
                            </div>
                        </div>
                    </v-flex>
                </v-row>
                </v-card>
            </v-parallax>
        </v-card>
    </v-container>
    <v-container fluid>
      <v-parallax dark height="700" :src="require('../assets/handling pallet1.jpg')">
        <v-card flat img="../assets/handling pallet1.jpg'" class="px-10">
            <v-row align="center" justify="start">
              <v-flex  xs12 md6 lg6>
                <div class="thirdone">
                    Handling Pallet
                    <div class="thirdoneone">
                        <p>
                        Dengan tenaga yang sudah profesional untuk menyusun dan menyimpan palet digudang, menggunakan Forklift, menurunkan palet dari truk jika palet kembali ke pool dan memuat palet keatas truk untuk siap dikirim ke pabrik.
                        </p>
                    </div>
                </div>
              </v-flex>
            </v-row>
        </v-card>
        </v-parallax>
    </v-container>
    <v-container fluid>
        <v-card>
            <v-parallax dark height="800" :src="require('../assets/security pallet1.jpg')">
            <v-card flat img="../assets/security pallet1.jpg'" class="px-10">
                <v-row align="center" justify="end">
                    <v-flex  xs12 md6 lg6>
                        <div class="secondone">
                            Keamanan
                            <div class="secondoneone">
                                <p>
                                  Kami juga mendesain jalan keluar masuk palet, lalulintas palet didalam pool, dengan perhitungan keamanan yang memadai sesuai dengan standard HSE (Health, Safety, Environment) atau juga yang dikenal dengan nama K3 (Kesehatan, Keselamatan dan Keamanan Lingkungan)
                                </p>
                            </div>
                        </div>
                    </v-flex>
                </v-row>
                </v-card>
            </v-parallax>
        </v-card>
    </v-container>
     <v-footer  dark absolute class="pt-5 font-weight-light">
        <v-col class="text-center">
            A <a href="https://dinamikalogistindo.com"> PT Dinamika Logistindo</a> Product
            <!-- <p>{{dateNow}}</p> -->
        </v-col>
    </v-footer>
</v-app>
</template>

<script>
import { mapActions, mapMutations, mapGetters, mapState } from 'vuex';
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default {
    data() {
        return {
            dialog: false,
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
        },
    },
    destroyed() {
        this.getUserLogin()
    }
}
</script>
