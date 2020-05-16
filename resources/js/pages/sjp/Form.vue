<template>
    <div >
        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id == 'pooldli'">
            <v-flex class="px-5" xs9 md10 lg11>
                <div class="form-group" :class="{ 'has-error': errors.vehicle_number }">
                    <label for="">Vehicle Number</label>
                    <input type="text" class="form-control" v-model="sjp.vehicle_number">
                    <p class="text-danger" v-if="errors.vehicle_number">{{ errors.vehicle_number[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="py-6" xs3 md2 lg1>
                <div>
                    <v-btn class="success" :disabled="loading" :loading="loading" @click="getdispatchdata()">Load</v-btn>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id != 'pooldli'">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.vehicle_number }">
                    <label for="">Vehicle Number</label>
                    <input type="text" class="form-control" v-model="sjp.vehicle_number">
                    <p class="text-danger" v-if="errors.vehicle_number">{{ errors.vehicle_number[0] }}</p>
                </div>
                <v-autocomplete
                    :items="vehicles.data"
                    dense
                    solo
                    v-model="sjp.vehicle_number"
                    item-text="vehicle_number"
                    item-value="vehicle_id"
                    clearable
                    >
                    </v-autocomplete>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id == 'pooldli'">
            <v-flex class="px-5" xs6 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.no_do }">
                    <label for="">No Dispatch</label>
                    <input type="text" class="form-control" v-model="sjp.no_do" :readonly="true">
                    <p class="text-danger" v-if="errors.no_do">{{ errors.no_do[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.product_name }">
                    <label for="">Product Name</label>
                    <input type="text" class="form-control" v-model="sjp.product_name" >
                    <p class="text-danger" v-if="errors.product_name">{{ errors.product_name[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id != 'pooldli'">
            <v-flex class="px-5" xs6 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.no_do }">
                    <label for="">No Dispatch</label>
                    <input type="text" class="form-control" v-model="sjp.no_do" >
                    <p class="text-danger" v-if="errors.no_do">{{ errors.no_do[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.product_name }">
                    <label for="">Product Name</label>
                    <input type="text" class="form-control" v-model="sjp.product_name" >
                    <p class="text-danger" v-if="errors.product_name">{{ errors.product_name[0] }}</p>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id == 'pooldli'">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.destination_pool_pallet_id }">
                    <label for="">Destination Pool Code</label>
                    <input type="text" class="form-control" v-model="sjp.destination_pool_pallet_id" :readonly="true">
                    <p class="text-danger" v-if="errors.destination_pool_pallet_id">{{ errors.destination_pool_pallet_id[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.dest_pool }">
                    <label for="">Destination Pool Name</label>
                    <input type="text" class="form-control" v-model="sjp.dest_pool" :readonly="true">
                    <p class="text-danger" v-if="errors.dest_pool">{{ errors.dest_pool[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id != 'pooldli'">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.destination_pool_pallet_id }">
                    <label for="">Destination Pool Code</label>
                    <input type="text" class="form-control" v-model="sjp.destination_pool_pallet_id" >
                    <p class="text-danger" v-if="errors.destination_pool_pallet_id">{{ errors.destination_pool_pallet_id[0] }}</p>
                </div>
                <v-autocomplete
                    :items="pools.data"
                    dense
                    solo
                    v-model="sjp.destination_pool_pallet_id"
                    item-text="pool_name"
                    item-value="pool_pallet_id"
                    clearable
                    >
                    </v-autocomplete>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.dest_pool }">
                    <label for="">Destination Pool Name</label>
                    <input type="text" class="form-control" v-model="sjp.dest_pool" >
                    <p class="text-danger" v-if="errors.dest_pool">{{ errors.dest_pool[0] }}</p>
                </div>
            </v-flex>
        </v-layout>

       <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id == 'pooldli'">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.transporter_id }">
                    <label for="">Transporter Code</label>
                    <input type="text" class="form-control" v-model="sjp.transporter_id" :readonly="true">
                    <p class="text-danger" v-if="errors.transporter_id">{{ errors.transporter_id[0] }}</p>
                </div>

            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.transporter_name }">
                    <label for="">Transporter Name</label>
                    <input type="text" class="form-control" v-model="sjp.transporter_name" :readonly="true">
                    <p class="text-danger" v-if="errors.transporter_name">{{ errors.transporter_name[0] }}</p>
                </div>

            </v-flex>
       </v-layout>
       <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id != 'pooldli'">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.transporter_id }">
                    <label for="">Transporter Code</label>
                    <input type="text" class="form-control" v-model="sjp.transporter_id" >
                    <p class="text-danger" v-if="errors.transporter_id">{{ errors.transporter_id[0] }}</p>
                </div>
                 <v-autocomplete
                    :items="transporters.data"
                    dense
                    solo
                    v-model="sjp.transporter_id"
                    item-text="transporter_name"
                    item-value="transporter_id"
                    clearable
                    >
                    </v-autocomplete>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.transporter_name }">
                    <label for="">Transporter Name</label>
                    <input type="text" class="form-control" v-model="sjp.transporter_name" >
                    <p class="text-danger" v-if="errors.transporter_name">{{ errors.transporter_name[0] }}</p>
                </div>
            </v-flex>
       </v-layout>

        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id == 'pooldli'">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.driver_id }">
                    <label for="">Driver ID</label>
                    <input type="text" class="form-control" v-model="sjp.driver_id" :readonly="true">
                    <p class="text-danger" v-if="errors.driver_id">{{ errors.driver_id[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.driver_name }">
                    <label for="">Driver Name</label>
                    <input type="text" class="form-control" v-model="sjp.driver_name" :readonly="true">
                    <p class="text-danger" v-if="errors.driver_name">{{ errors.driver_name[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id != 'pooldli'">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.driver_id }">
                    <label for="">Driver ID</label>
                    <input type="text" class="form-control" v-model="sjp.driver_id" >
                    <p class="text-danger" v-if="errors.driver_id">{{ errors.driver_id[0] }}</p>
                </div>
                <v-autocomplete
                    :items="drivers.data"
                    dense
                    solo
                    v-model="sjp.driver_id"
                    item-text="driver_name"
                    item-value="driver_id"
                    clearable
                    >
                    </v-autocomplete>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.driver_name }">
                    <label for="">Driver Name</label>
                    <input type="text" class="form-control" v-model="sjp.driver_name" >
                    <p class="text-danger" v-if="errors.driver_name">{{ errors.driver_name[0] }}</p>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id == 'pooldli'">
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.tonnage }">
                    <label for="">Tonnage</label>
                    <input type="text" class="form-control" v-model="sjp.tonnage" :readonly="true">
                    <p class="text-danger" v-if="errors.tonnage">{{ errors.tonnage[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.packaging }">
                    <label for="">Packaging (kg)</label>
                    <input type="text" class="form-control" v-model="sjp.packaging" :readonly="true">
                    <p class="text-danger" v-if="errors.packaging">{{ errors.packaging[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.product_quantity }">
                    <label for="">Product Quantity (zak)</label>
                    <input type="text" class="form-control" v-model="sjp.product_quantity" :readonly="true">
                    <p class="text-danger" v-if="errors.product_quantity">{{ errors.product_quantity[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.pallet_quantity }">
                    <label for=""><b>Pallet Quantity</b></label>
                    <input type="text" class="form-control" v-model="sjp.pallet_quantity" :readonly="true">
                    <p class="text-danger" v-if="errors.pallet_quantity">{{ errors.pallet_quantity[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5" v-if="authenticated.reference_pool_pallet_id != 'pooldli'">
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.tonnage }">
                    <label for="">Tonnage</label>
                    <input type="text" class="form-control" v-model="sjp.tonnage" >
                    <p class="text-danger" v-if="errors.tonnage">{{ errors.tonnage[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.packaging }">
                    <label for="">Packaging (kg)</label>
                    <input type="text" class="form-control" v-model="sjp.packaging" >
                    <p class="text-danger" v-if="errors.packaging">{{ errors.packaging[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.product_quantity }">
                    <label for="">Product Quantity (zak)</label>
                    <input type="text" class="form-control" v-model="sjp.product_quantity" >
                    <p class="text-danger" v-if="errors.product_quantity">{{ errors.product_quantity[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs6 md3 lg3>
                <div class="form-group" :class="{ 'has-error': errors.pallet_quantity }">
                    <label for=""><b>Pallet Quantity</b></label>
                    <input type="text" class="form-control" v-model="sjp.pallet_quantity" >
                    <p class="text-danger" v-if="errors.pallet_quantity">{{ errors.pallet_quantity[0] }}</p>
                </div>
            </v-flex>
        </v-layout>

        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.departure_time }">
                    <label for="">Departure Time</label>
                    <input type="date" class="form-control" v-model="sjp.departure_time" :readonly="true">
                    <p class="text-danger" v-if="errors.departure_time">{{ errors.departure_time[0] }}</p>
                </div>
            </v-flex>
            <v-flex class="px-5" xs12 md6 lg6>
                <div class="form-group" :class="{ 'has-error': errors.eta }">
                    <label for="">Estimated Time Arrival</label>
                    <input type="date" class="form-control" v-model="sjp.eta">
                    <p class="text-danger" v-if="errors.eta">{{ errors.eta[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
        <v-layout row wrap class="px-5">
            <v-flex class="px-5" xs12 md12 lg12>
                <div class="form-group" :class="{ 'has-error': errors.note }">
                    <label for="">Note</label>
                    <input type="text" class="form-control" v-model="sjp.note" >
                    <p class="text-danger" v-if="errors.note">{{ errors.note[0] }}</p>
                </div>
            </v-flex>
        </v-layout>
    </div>
</template>


<script>
import { mapState, mapActions, mapMutations } from 'vuex'
import $axios from '../../api.js'
import autocomplete from '../../components/Autocomplete.vue'

export default {
    name: 'FormSjp',
    created() {
        this.getVehicleForm(),
        this.getPoolForm(),
        this.getDriverForm(),
        this.getTransporterForm(),
        this.timeload(),
        this.getpoolautocomplete()
    },
    data() {
        return {
            loading: false,
            sjp: {
                date : new Date().toISOString().slice(0,10),
                departure_time: '',
                eta: '',
                dest_pool: '',
                destination_pool_pallet_id: '',
                driver_id: '',
                driver_name: '',
                no_do: '',
                packaging: '',
                pallet_quantity: '',
                product_quantity: '',
                tonnage: '',
                transporter_id: '',
                product_name: 'Portland Composite Cement',
                transporter_name: '',
                vehicle_number: 'B 9072XQ',
                note: '',
            },

        }
    },

    computed: {
        ...mapState(['errors']),
        // ...mapState('sjp', {
        //     sjp: state => state.sjp
        // }),
        ...mapState('pool', {
            pools: state => state.pools
        }),
        ...mapState('vehicle', {
            vehicles: state => state.vehicles
        }),
        ...mapState('driver', {
            drivers: state => state.drivers
        }),
         ...mapState('transporter', {
            transporters: state => state.transporters
        }),
        ...mapState('user', {
            authenticated: state => state.authenticated
        }),
        today(){
            this.sjp.departure_time = new Date ().toISOString().slice(0,10)
        }

    },
    components: {
            'autocomplete': autocomplete,
    },
    methods: {
        ...mapMutations('sjp', ['CLEAR_FORM']),
        ...mapActions('sjp', ['submitSjp']),
        ...mapActions('pool', ['getPoolForm']),
        ...mapActions('dispatchdata', ['submitGetData']),
        ...mapActions('vehicle', ['getVehicleForm']),
        ...mapActions('driver', ['getDriverForm']),
        ...mapActions('transporter', ['getTransporterForm']),
        submit() {
            let form = new FormData()
            form.append('destination_pool_pallet_id', this.sjp.destination_pool_pallet_id)
            form.append('pool_name', this.sjp.dest_pool)
            form.append('vehicle_id', this.sjp.vehicle_number)
            form.append('driver_id', this.sjp.driver_id)
            form.append('driver_name', this.sjp.driver_name)
            form.append('transporter_id', this.sjp.transporter_id)
            form.append('transporter_name', this.sjp.transporter_name)
            form.append('no_do', this.sjp.no_do)
            form.append('product_name', this.sjp.product_name)
            form.append('tonnage', this.sjp.tonnage)
            form.append('packaging', this.sjp.packaging)
            form.append('product_quantity', this.sjp.product_quantity)
            form.append('pallet_quantity', this.sjp.pallet_quantity)
            form.append('departure_time', this.sjp.departure_time)
            form.append('eta', this.sjp.eta)
            form.append('note', this.sjp.note)
                this.submitSjp(form).then(() => {
                    this.sjp = {
                        departure_time: '',
                        eta: '',
                        dest_pool: '',
                        destination_pool_pallet_id: '',
                        driver_id: '',
                        driver_name: '',
                        no_do: '',
                        packaging: '',
                        pallet_quantity: '',
                        product_quantity: '',
                        tonnage: '',
                        transporter_id: '',
                        product_name: '',
                        transporter_name: '',
                        vehicle_number: '',
                        note: '',
                    }
                    this.$router.push({ name: 'sjps.data' })
                })
        },
        timeload(){
            this.sjp.departure_time = new Date ().toISOString().slice(0,10)
            var tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            this.sjp.eta = tomorrow.toISOString().slice(0,10)
        },
        isLoading (loading) {
            this.loading = true

        },
        doneLoading (loading) {
            this.loading = false
        },
        getdispatchdata(){
            this.isLoading()
            let bodyFormData = new FormData()
            bodyFormData.set('vehicle_number', this.sjp.vehicle_number);
                $axios({
                    method: 'post',
                    url: 'getdispatch',
                    data: bodyFormData,
                    headers: {'Content-Type': 'multipart/form-data' }
                })
                .then((response) => {
                    if(response.data.Status == 0){
                        alert(response.data.Message)
                        var row = response.data.Payload
                        // data populate
                        var row = response.data.Payload
                        this.sjp.no_do = row.no_dispatch;
                        this.sjp.dest_pool = row.dest_pool;
                        this.sjp.destination_pool_pallet_id = row.destination_pool_pallet_id;
                        this.sjp.driver_id = row.driver_id;
                        this.sjp.driver_name = row.driver_name;
                        this.sjp.packaging = row.packaging;
                        this.sjp.pallet_quantity = row.pallet_quantity;
                        this.sjp.product_quantity = row.product_quantity;
                        this.sjp.tonnage = row.tonnage;
                        this.sjp.transporter_id = row.transporter_id;
                        this.sjp.transporter_name = row.transporter_name;
                        this.sjp.vehicle_number = row.vehicle_number;
                    }
                    // console.log(response.data); // works fine

                    var row = response.data.Payload

                    // data populate
                    var row = response.data.Payload
                    this.sjp.no_do = row.no_dispatch;
                    this.sjp.dest_pool = row.dest_pool;
                    this.sjp.destination_pool_pallet_id = row.destination_pool_pallet_id;
                    this.sjp.driver_id = row.driver_id;
                    this.sjp.driver_name = row.driver_name;
                    this.sjp.packaging = row.packaging;
                    this.sjp.pallet_quantity = row.pallet_quantity;
                    this.sjp.product_quantity = row.product_quantity;
                    this.sjp.tonnage = row.tonnage;
                    this.sjp.transporter_id = row.transporter_id;
                    this.sjp.transporter_name = row.transporter_name;
                    this.sjp.vehicle_number = row.vehicle_number;

                //jika data dispatch tidak ada
                }).catch((error) => {
                alert(error.response.data.message)
            }).finally(() => {
                this.doneLoading()
            })
        },
        getpoolautocomplete(){
            $axios.get('poolautocomplete')
                .then(function (response) {
                    // handle success
                    console.log(response.data);
                })
        }
    },
    destroyed() {
        this.CLEAR_FORM()
    },
}
</script>
