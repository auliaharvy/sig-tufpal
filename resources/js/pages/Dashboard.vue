<template>
        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="row">
                                <v-layout row wrap class="px-5">
                                    <v-btn  v-if=" authenticated.reference_pool_pallet_id == 'pooldli' " class="ma-5" @click.prevent="exportData()">
                                        Download Today Transaction
                                    </v-btn>
                                    <v-flex class="pa-5" xs12 md12 lg12>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>All Pallet : <span>{{totalallpallet}}</span></v-toolbar-title>
                                            
                                        </v-toolbar>
                                        <div>
                                            <bar-chart v-if="globalpallet.length > 0" :data="dataglobalpallet" :options="barChartOptions" :labels="labelsglobalpallet"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                </v-layout>
                        </div>
                        <div class="row">
                                <v-layout row wrap class="px-5">
                                <v-flex class="pa-5" xs12 md6 lg6>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>Pallet Pool</v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <pie-chart v-if="datapallet.length > 0" :data="datapallet" :options="chartOptions" :labels="labelspallet"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                <v-flex class="pa-5" xs12 md6 lg6>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>Pallet Transporter</v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <pie-chart v-if="datapallettransporter.length > 0" :data="datapallettransporter" :options="chartOptions" :labels="labelspallet"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                </v-layout>
                        </div>
                        <div class="row">
                                <v-layout row wrap class="px-5">
                                    <v-flex class="pa-5" xs12 md9 lg9>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>Warehouse Detail</v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <bar-chart v-if="poolpalletdetail.length > 0" :data="datapoolpalletdetail" :options="barChartPoolOptions" :labels="labelspoolpalletdetail"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                <v-flex class="pa-5" xs12 md3 lg3>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>
                                                <v-autocomplete
                                                :items="labelspoolpalletdetail"
                                                dense
                                                solo
                                                v-model="detail_pool_name"
                                                item-text="label"
                                                item-value="label"
                                                clearable
                                                >
                                                </v-autocomplete>
                                            </v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <pie-chart v-if="datadetailpoolpallet.length > 0" :data="datadetailpoolpallet" :options="chartOptions" :labels="labelspallet"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                </v-layout>
                        </div>
                        <div class="row">
                                <v-layout row wrap class="px-5">
                                    <v-flex class="pa-5" xs12 md9 lg9>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>Transporter Detail</v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <bar-chart v-if="transporterdetail.length > 0" :data="datatransporterdetail" :options="barChartOptions" :labels="labelstransporterdetail"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                <v-flex class="pa-5" xs12 md3 lg3>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>
                                                <v-autocomplete
                                                :items="labelstransporterdetail"
                                                dense
                                                solo
                                                v-model="detail_transporter_name"
                                                item-text="label"
                                                item-value="label"
                                                clearable
                                                >
                                                </v-autocomplete>
                                            </v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <pie-chart v-if="datadetailtransporter.length > 0" :data="datadetailtransporter" :options="chartOptions" :labels="labelspallet"/>
                                        </div>
                                    </v-card>
                                </v-flex>

                                </v-layout>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <v-layout>
                                <v-flex xs12 md6 lg6>
                                    <div class="form-group px-5 pt-3">
                                        <label for="">Bulan</label>
                                        <select v-model="month" class="form-control">
                                            <option value="01">Januari</option>
                                            <option value="02">Februari</option>
                                            <option value="03">Maret</option>
                                            <option value="04">April</option>
                                            <option value="05">Mei</option>
                                            <option value="06">Juni</option>
                                            <option value="07">Juli</option>
                                            <option value="08">Agustus</option>
                                            <option value="09">September</option>
                                            <option value="10">Oktober</option>
                                            <option value="11">November</option>
                                            <option value="12">Desember</option>
                                        </select>
                                    </div>
                                </v-flex>
                                <v-flex xs12 md6 lg6>
                                    <div class="form-group px-5 pt-3">
                                        <label for="">Tahun</label>
                                        <select v-model="year" class="form-control">
                                            <option v-for="(y, i) in years" :key="i" :value="y">{{ y }}</option>
                                        </select>
                                    </div>
                                </v-flex>
                            </v-layout>
                            <div class="row">
                                <v-layout row wrap class="px-5">
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>Pallet Send</v-toolbar-title>
                                            </v-toolbar>

                                            <div class="panel-body">
                                                <line-chart v-if="transactions.length > 0" :data="transaction_data" :options="barChartOptions" :labels="labels"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>Pallet Receive</v-toolbar-title>
                                            </v-toolbar>
                                            <div class="panel-body">
                                                <line-chart v-if="transactions.length > 0" :data="transaction_receive_data" :options="barChartOptions" :labels="labels"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                </v-layout>
                                <v-layout row wrap class="px-5">
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>Pallet Sendback</v-toolbar-title>
                                            </v-toolbar>

                                            <div class="panel-body">
                                                <line-chart v-if="transactionssendback.length > 0" :data="transaction_senback_data" :options="barChartOptions" :labels="labels"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>Pallet Receive Sendback</v-toolbar-title>
                                            </v-toolbar>
                                            <div class="panel-body">
                                                <line-chart v-if="transactionssendback.length > 0" :data="transaction_receive_sendback_data" :options="barChartOptions" :labels="labels"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                </v-layout>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
</template>
<script>
    import moment from 'moment'
    import _ from 'lodash'
    import LineChart from '../components/LineChart.vue'
    import BarChart from '../components/BarChart.vue'
    import PieChart from '../components/PieChart.vue'
    import { mapActions, mapState } from 'vuex'
    import ChartDataLabels from 'chartjs-plugin-datalabels';

    export default {
        created() {
            this.getChart2Data({
                month: this.month,
                year: this.year
            }),
            this.getChartData({
                month: this.month,
                year: this.year
            }),
            this.getChartDataGlobalPalllet().then((res) => {
                let row = res.data
            }),
            this.getTotalAllPallet().then((res) => {
                let row = res.data
            }),
            this.getChartDataPoolPalletDetail().then((res) => {
                let row = res.data
            }),
            this.getChartDataTransporterDetail().then((res) => {
                let row = res.data
            }),
            this.getChartDataPallet().then((res) => {
                let row = res.data
            }),
            this.getChartDataPalletTransporter().then((res) => {
                let row = res.data
            }),
            this.getChartDataDetailPoolPallet({
                detail_pool_name: this.detail_pool_name,
            }).then((res) => {
                let row = res.data
            }),
            this.getChartDataDetailTransporter({
                detail_transporter_name: this.detail_transporter_name,
            }).then((res) => {
                let row = res.data
            }),

            this.getPools()
        },
        data() {
            return {
                totalGlobal: 0,
                barChartOptions: {
                    onClick: function(evt, array) {
                        if (array.length != 0) {
                            var position = array[0]._index;
                            var activeElement = this.tooltip._data.labels[position]
                            console.log(activeElement);
                        } else {
                            console.log("You selected the background!");            
                        }  
                    },    
                    scales: {
                            yAxes: [{
                                ticks: {
                                    // stepSize: 50,
                                    // maxTicksLimit: 3,
                                    suggestedMin: 0
                                }
                            }]
                        },
                     plugins: {
                        datalabels: {
                            display: true,
                            align: 'center',
                            anchor: 'center'
                        },
                        
                    },
                    responsive: true,
                    maintainAspectRatio: false
                },
                barChartPoolOptions: {
                    onClick: function(evt, array) {
                        if (array.length != 0) {
                            var position = array[0]._index;
                            var activeElement = this.tooltip._data.labels[position]
                            console.log(activeElement)
                        } else {
                            console.log("You selected the background!");            
                        }  
                    },    
                    scales: {
                            yAxes: [{
                                ticks: {
                                    // stepSize: 50,
                                    // maxTicksLimit: 3,
                                    suggestedMin: 0
                                }
                            }]
                        },
                     plugins: {
                        datalabels: {
                            display: true,
                            align: 'center',
                            anchor: 'center'
                        },
                        
                    },
                    responsive: true,
                    maintainAspectRatio: false
                },
                chartOptions: {
                     plugins: {
                        datalabels: {
                            display: true,
                            align: 'center',
                            anchor: 'center'
                        }
                    },
                    responsive: true,
                    maintainAspectRatio: false
                },
                detail_pool_name: 'BCTD',
                detail_transporter_name: 'ANGGADA PERKASA, P.T.',
                month: moment().format('MM'),
                year: moment().format('Y'),
                monthReceive: moment().format('MM'),
                yearReceive: moment().format('Y'),
            }
        },
        watch: {
            month() {
                this.getChartData({
                    month: this.month,
                    year: this.year
                })
                this.getChart2Data({
                    month: this.month,
                    year: this.year
                })
            },
            year() {
                this.getChartData({
                    month: this.month,
                    year: this.year
                })
                this.getChart2Data({
                    month: this.month,
                    year: this.year
                })
            },
            month_receive() {
                this.getChartDataReceive({
                    month: this.monthReceive,
                    year: this.yearReceive
                })
            },
            year_receive() {
                this.getChartDataReceive({
                    month: this.monthReceive,
                    year: this.yearReceive
                })
            },
            detail_pool_name() {
                this.getChartDataDetailPoolPallet({
                    detail_pool_name: this.detail_pool_name
                })
            },
            detail_transporter_name() {
                this.getChartDataDetailTransporter({
                    detail_transporter_name: this.detail_transporter_name
                })
            }
        },
        computed: {
            ...mapState('dashboard', {
                transactions: state => state.transactions,
                transactionssendback: state => state.transactionssendback,
                globalpallet: state => state.globalpallet,
                totalallpallet: state => state.totalallpallet,
                poolpalletdetail: state => state.poolpalletdetail,
                transporterdetail: state => state.transporterdetail,
                pallet: state => state.pallet,
                pallettransporter: state => state.pallettransporter,
                detailpoolpallet: state => state.detailpoolpallet,
                detailtransporter: state => state.detailtransporter,
            }),
            ...mapState('pool', {
                pools: state => state.pools
            }),
            ...mapState(['token']),
            years() {
                return _.range(2010, moment().add(1, 'years').format('Y'))
            },
            
            labels() {
                return _.map(this.transactions, function(o) {
                    return moment(o.date).format('DD')
                });
            },
            labelsglobalpallet() {
                return _.map(this.globalpallet, function(o) {
                    return o.type
                });
            },
            labelspoolpalletdetail() {
                return _.map(this.poolpalletdetail, function(o) {
                    return o.pool_name
                });
            },
            labelstransporterdetail() {
                return _.map(this.transporterdetail, function(o) {
                    return o.transporter_name
                });
            },
            labelspallet() {
                let label = ['Good Pallet','TBR Pallet','BER Pallet','Missing Pallet' ]
                return label
            },
            transaction_data() {
                return _.map(this.transactions, function(o) {
                    return o.total
                });
            },
            transaction_senback_data() {
                return _.map(this.transactionssendback, function(o) {
                    return o.total
                });
            },
            transaction_receive_data() {
                return _.map(this.transactions, function(o) {
                    return o.totalreceive
                });
            },
            transaction_receive_sendback_data() {
                return _.map(this.transactionssendback, function(o) {
                    return o.totalreceive
                });
            },
            dataglobalpallet() {
                return _.map(this.globalpallet, function(o) {
                    return o.total
                });
            },
            datapoolpalletdetail() {
                return _.map(this.poolpalletdetail, function(o) {
                    return o.total
                });
            },
            datadetailpoolpallet() {
                return _.map(this.detailpoolpallet, function(o) {
                    return o.total
                });
            },
            datadetailtransporter() {
                return _.map(this.detailtransporter, function(o) {
                    return o.total
                });
            },
            datatransporterdetail() {
                return _.map(this.transporterdetail, function(o) {
                    return o.total
                });
            },
            datapallet() {
                return _.map(this.pallet, function(o) {
                    return o.total
                });
            },
            datapallettransporter() {
                return _.map(this.pallettransporter, function(o) {
                    return o.total
                });
            },
        },
        methods: {
            ...mapActions('dashboard', ['getChartData', 'getChart2Data',
                            'getChartDataGlobalPalllet', 'getChartDataPallet',
                            'getChartDataPoolPalletDetail', 'getChartDataTransporterDetail',
                            'getChartDataPalletTransporter', 'getTotalAllPallet', 'getChartDataDetailPoolPallet',
                            'getChartDataDetailTransporter']),
            ...mapActions('pool', ['getPools', 'removePools']),
            exportData() {
                window.open(`api/exportalltransactiontoday?api_token=${this.token}`)
            }
        },
        components: {
            'line-chart': LineChart,
            'pie-chart' : PieChart,
            'bar-chart' :BarChart,
        },
    }
</script>
