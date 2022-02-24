<template>
        <section class="content" >
            <div class="row" ref="printMe">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="row">
                                <v-layout row wrap class="px-5">
                                    <div>
                                    <v-btn  class="ma-5" @click.prevent="exportData()">
                                        Download Today Transaction
                                    </v-btn>
                                    <v-btn  class="" @click.prevent="allDataExport()">
                                        All Data Export
                                    </v-btn>
                                    <!-- <v-btn class="ma-5" @click="print">
                                        Print
                                    </v-btn> -->
                                    </div>
                                    <v-flex class="pa-5" xs12 md12 lg12>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>All Pallet : <span>{{totalallpallet}}</span></v-toolbar-title>
                                            
                                        </v-toolbar>
                                        <div class="panel-body">
                                            <v-btn class="mx-2">
                                                <download-excel
                                                ref="all_pallet"
                                                :data= "globalpallet"
                                                :name="allPalletExportName()">
                                                    Download Data
                                                </download-excel>
                                            </v-btn>
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
                                            <v-toolbar-title>Pool Pallet DLI Detail</v-toolbar-title>
                                        </v-toolbar>
                                        <div class="panel-body">
                                            <v-btn class="mx-2">
                                                <download-excel
                                                ref="warehouse_detail"
                                                :data= "pooldliinout"
                                                :name="poolDliDetailExportName()">
                                                    Download Data
                                                </download-excel>
                                            </v-btn>
                                            <bar-chart-warehouse v-if="pooldliinout.length > 0"  :data1="datapooldliinoutpalletin" :data2="datapooldliinoutpalletout" :data="datapooldliinoutstock" :options="barChartPoolInOutOptions" :labels="labelspooldliinout"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                <v-flex class="pa-5" xs12 md3 lg3>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>
                                                <v-autocomplete
                                                :items="labelspooldliinout"
                                                dense
                                                solo
                                                v-model="detail_pool_dli_name"
                                                item-text="label"
                                                item-value="label"
                                                clearable
                                                >
                                                </v-autocomplete>
                                            </v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <pie-chart v-if="datadetailpoolpalletdli.length > 0" :data="datadetailpoolpalletdli" :options="chartOptions" :labels="labelspallet"/>
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
                                        <div class="panel-body">
                                            <v-btn class="mx-2">
                                                <download-excel
                                                ref="warehouse_detail"
                                                :data= "warehouseinout"
                                                :name="warehouseDetailExportName()">
                                                    Download Data
                                                </download-excel>
                                            </v-btn>
                                            <bar-chart-warehouse v-if="warehouseinout.length > 0"  :data1="datawarehouseinoutpalletin" :data2="datawarehouseinoutpalletout" :data="datawarehouseinoutstock" :options="barChartPoolInOutOptions" :labels="labelswarehouseinout"/>
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
                        <!-- <div class="row">
                                <v-layout row wrap class="px-5">
                                    <v-flex class="pa-5" xs12 md12 lg12>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>Warehouse In & Out</v-toolbar-title>
                                        </v-toolbar>
                                        <div>
                                            <bar-chart-warehouse v-if="warehouseinout.length > 0"  :data1="datawarehouseinoutpalletin" :data2="datawarehouseinoutpalletout" :data="datawarehouseinoutstock" :options="barChartPoolInOutOptions" :labels="labelswarehouseinout"/>
                                        </div>
                                    </v-card>
                                </v-flex>
                                </v-layout>
                        </div> -->
                        <div class="row">
                            <v-layout row wrap class="px-5">
                                <v-flex class="pa-5" xs12 md9 lg9>
                                    <v-card>
                                        <v-toolbar>
                                            <v-toolbar-title>Transporter Detail</v-toolbar-title>
                                        </v-toolbar>
                                        <div class="panel-body">
                                            <v-btn class="mx-2">
                                                <download-excel
                                                ref="transporter_detail"
                                                :data= "transportersendsendback"
                                                :name="transDetailExportName()">
                                                    Download Data
                                                </download-excel>
                                            </v-btn>
                                            <bar-chart-transporter v-if="transportersendsendback.length > 0"  :data1="datatransportersendsendbackpalletsendback"  :data="datatransportersendsendbackpalletsend" :options="barChartPoolInOutOptions" :labels="labelstransportersendsendback"/>
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
                            <v-layout>
                                <v-flex class="px-3" xs12 md6 lg6>
                                    <v-btn class="mx-2">
                                        <download-excel
                                        ref="pallet_send"
                                        :data= "transactions"
                                        :name="palletSendExportName()">
                                            Download Data Send
                                        </download-excel>
                                    </v-btn>
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
                            </div>
                            <v-layout>
                                <v-flex class="px-3" xs12 md6 lg6>
                                    <v-btn class="mx-2">
                                        <download-excel
                                        ref="pallet_sendback"
                                        :data= "transactionssendback"
                                        :name="palletSendbackExportName()">
                                            Download Data Sendback
                                        </download-excel>
                                    </v-btn>
                                </v-flex>
                            </v-layout>
                            <div class="row">
                                <v-layout row wrap class="px-5">
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>Pallet Sendback</v-toolbar-title>
                                            </v-toolbar>

                                            <div class="panel-body">
                                                <line-chart v-if="transactions.length > 0" :data="transaction_senback_data" :options="barChartOptions" :labels="labels"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>Pallet Receive Sendback</v-toolbar-title>
                                            </v-toolbar>
                                            <div class="panel-body">
                                                <line-chart v-if="transactions.length > 0" :data="transaction_receive_sendback_data" :options="barChartOptions" :labels="labels"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                </v-layout>
                                <v-layout row wrap class="px-5">
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>
                                                    Tonnase Out Ciwandan
                                                </v-toolbar-title>
                                            </v-toolbar>
                                            <div class="panel-body">
                                                <v-btn class="mx-2">
                                                    <download-excel
                                                    ref="tonnase_out"
                                                    :data= "tonnase_out"
                                                    :name="tonnaseExportName()">
                                                    Download Data
                                                    </download-excel>
                                                </v-btn>
                                                <line-chart-tonnase v-if="tonnase_out.length > 0" :data="tonnase_out_data" :options="barChartOptions" :labels="labelsTonnaseOut"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>
                                            <v-toolbar>
                                                <v-toolbar-title>
                                                    Tonnase Out bayah
                                                </v-toolbar-title>
                                            </v-toolbar>
                                            <div class="panel-body">
                                                <v-btn class="mx-2">
                                                    <download-excel
                                                    ref="tonnase_out"
                                                    :data= "tonnase_out_1"
                                                    :name="tonnaseExportName()">
                                                    Download Data
                                                    </download-excel>
                                                </v-btn>
                                                <line-chart-tonnase v-if="tonnase_out_1.length > 0" :data="tonnase_out_1_data" :options="barChartOptions" :labels="labelsTonnaseOut1"/>
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
    import LineChartTonnase from '../components/LineChartTonnase.vue'
    import BarChart from '../components/BarChart.vue'
    import BarChartWarehouse from '../components/BarChartWarehouse.vue'
    import BarChartTransporter from '../components/BarChartTransporter.vue'
    import PieChart from '../components/PieChart.vue'
    import jsPDF from 'jspdf'
    import { mapActions, mapState } from 'vuex'
    import ChartDataLabels from 'chartjs-plugin-datalabels';


    export default {
        created() {
            this.getTonnaseOut({
                month: this.month,
                year: this.year
            }),
            this.getTonnaseOut1({
                month: this.month,
                year: this.year
            }),
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
            this.getChartDataWarehouseInOut().then((res) => {
                let row = res.data
            }),
            this.getChartDataPoolDliInOut().then((res) => {
                let row = res.data
            }),
            this.getChartDataTransporterSendSendback().then((res) => {
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
            this.getChartDataDetailPoolPalletDli({
                detail_pool_dli_name: this.detail_pool_dli_name,
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
                barChartPoolInOutOptions: {
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
                            xAxes:[{
                                stacked: true
                            }],
                            yAxes: [{
                                stacked: true,
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
                detail_pool_name: 'JATI ASIH WH',
                detail_pool_dli_name: 'Pool Pallet Ciwandan',
                detail_transporter_name: 'ARK LOGISTIC',
                month: moment().format('MM'),
                year: moment().format('Y'),
                monthReceive: moment().format('MM'),
                yearReceive: moment().format('Y'),
            }
        },
        watch: {
            
            month() {
                this.getTonnaseOut({
                    month: this.month,
                    year: this.year
                })
                this.getTonnaseOut1({
                    month: this.month,
                    year: this.year
                })
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
                this.getTonnaseOut({
                    month: this.month,
                    year: this.year
                })
                this.getTonnaseOut1({
                    month: this.month,
                    year: this.year
                })
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
            detail_pool_dli_name() {
                this.getChartDataDetailPoolPalletDli({
                    detail_pool_dli_name: this.detail_pool_dli_name
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
                tonnase_out: state => state.tonnase_out,
                tonnase_out_1: state => state.tonnase_out_1,
                transactions: state => state.transactions,
                transactionssendback: state => state.transactionssendback,
                globalpallet: state => state.globalpallet,
                totalallpallet: state => state.totalallpallet,
                poolpalletdetail: state => state.poolpalletdetail,
                transporterdetail: state => state.transporterdetail,
                pallet: state => state.pallet,
                pallettransporter: state => state.pallettransporter,
                detailpoolpallet: state => state.detailpoolpallet,
                detailpoolpalletdli: state => state.detailpoolpalletdli,
                detailtransporter: state => state.detailtransporter,
                warehouseinout: state => state.warehouseinout,
                pooldliinout: state => state.pooldliinout,
                transportersendsendback: state => state.transportersendsendback,
            }),
            ...mapState('pool', {
                pools: state => state.pools
            }),
            ...mapState('user', {
                authenticated: state => state.authenticated
            }),
            ...mapState(['token']),
            years() {
                return _.range(2010, moment().add(1, 'years').format('Y'))
            },
            
            labelsTonnaseOut() {
                return _.map(this.tonnase_out, function(o) {
                    return moment(o.date).format('DD')
                });
            },
            labelsTonnaseOut1() {
                return _.map(this.tonnase_out_1, function(o) {
                    return moment(o.date).format('DD')
                });
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
            labelswarehouseinout() {
                return _.map(this.warehouseinout, function(o) {
                    return o.pool_name
                });
            },
            labelspooldliinout() {
                return _.map(this.pooldliinout, function(o) {
                    return o.pool_name
                });
            },
            labelstransportersendsendback() {
                return _.map(this.transportersendsendback, function(o) {
                    return o.transporter_name
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
            tonnase_out_data() {
                return _.map(this.tonnase_out, function(o) {
                    return o.tonnase
                });
            },
            tonnase_out_1_data() {
                return _.map(this.tonnase_out_1, function(o) {
                    return o.tonnase
                });
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
            datawarehouseinoutstock() {
                return _.map(this.warehouseinout, function(o) {
                    return o.stock
                });
            },
            datawarehouseinoutpalletin() {
                return _.map(this.warehouseinout, function(o) {
                    return o.pallet_in
                });
            },
            datawarehouseinoutpalletout() {
                return _.map(this.warehouseinout, function(o) {
                    return o.pallet_out
                });
            },
            datapooldliinoutstock() {
                return _.map(this.pooldliinout, function(o) {
                    return o.stock
                });
            },
            datapooldliinoutpalletin() {
                return _.map(this.pooldliinout, function(o) {
                    return o.pallet_in
                });
            },
            datapooldliinoutpalletout() {
                return _.map(this.pooldliinout, function(o) {
                    return o.pallet_out
                });
            },
            datatransportersendsendbackpalletsend() {
                return _.map(this.transportersendsendback, function(o) {
                    return o.pallet_send
                });
            },
            datatransportersendsendbackpalletsendback() {
                return _.map(this.transportersendsendback, function(o) {
                    return o.pallet_sendback
                });
            },
            datadetailpoolpallet() {
                return _.map(this.detailpoolpallet, function(o) {
                    return o.total
                });
            },
            datadetailpoolpalletdli() {
                return _.map(this.detailpoolpalletdli, function(o) {
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
                            'getChartDataPalletTransporter', 'getTotalAllPallet', 'getChartDataDetailPoolPallet','getChartDataDetailPoolPalletDli',
                            'getChartDataDetailTransporter','getChartDataWarehouseInOut','getChartDataPoolDliInOut',
                            'getChartDataTransporterSendSendback',
                            'getTonnaseOut', 'getTonnaseOut1']),
            ...mapActions('pool', ['getPools', 'removePools']),
            exportData() {
                window.open(`api/exportalltransactiontoday?api_token=${this.token}`)
            },
            allDataExport() {
                this.$refs.all_pallet.$el.click();
                this.$refs.warehouse_detail.$el.click();
                this.$refs.transporter_detail.$el.click();
                this.$refs.pallet_send.$el.click();
                this.$refs.pallet_sendback.$el.click();
                this.$refs.tonnase_out.$el.click();
            },
            allPalletExportName() {
                var month = this.month
                var year = this.year
                return 'All_Pallet_' + month + '_'  + year
            },
            palletPoolStatusExportName() {
                var month = this.month
                var year = this.year
                return 'Pallet_Pool_Status_' + month + '_'  + year
            },
            palletTransStatusExportName() {
                var month = this.month
                var year = this.year
                return 'Pallet_Transporter_Status_' + month + '_'  + year
            },
            warehouseDetailExportName() {
                var month = this.month
                var year = this.year
                return 'Warehouse_Detail_' + month + '_'  + year
            },
            poolDliDetailExportName() {
                var month = this.month
                var year = this.year
                return 'pool_dli_' + month + '_'  + year
            },
            warehouseDetailStatusExportName() {
                var month = this.month
                var year = this.year
                return 'Warehouse_Detail_Status' + month + '_'  + year
            },
            transDetailExportName() {
                var month = this.month
                var year = this.year
                return 'Transporter_Detail_' + month + '_'  + year
            },
            transDetailStatusExportName() {
                var month = this.month
                var year = this.year
                return 'Transporter_Detail_Status_' + month + '_'  + year
            },
            palletSendExportName() {
                var month = this.month
                var year = this.year
                return 'Pallet_Send' + month + '_'  + year
            },
             palletSendbackExportName() {
                var month = this.month
                var year = this.year
                return 'Pallet_Sendback_' + month + '_'  + year
            },
            tonnaseExportName() {
                var month = this.month
                var year = this.year
                return 'Tonnase_out_' + month + '_'  + year
            },
            async print() {
                var now = new Date().toLocaleString();
                this.output = null;
                    const filename  = 'Dashboard' + now + '.pdf';
                    const el = this.$refs.printMe;
                // add option type to get the image version
                // if not provided the promise will return
                // the canvas.
                const options = {
                    type: 'dataURL'
                }
                this.output = await this.$html2canvas(el, options);

                let pdf = new jsPDF('l', 'mm', 'a4');
                    var width = pdf.internal.pageSize.getWidth();
                    var height = pdf.internal.pageSize.getHeight();
                    pdf.addImage(this.output, 'PNG', 0, 0, width, height);
                    pdf.save(filename);
            },
        },
        components: {
            'line-chart': LineChart,
            'line-chart-tonnase': LineChartTonnase,
            'pie-chart' : PieChart,
            'bar-chart' :BarChart,
            'bar-chart-warehouse' :BarChartWarehouse,
            'bar-chart-transporter' :BarChartTransporter,
        },
    }
</script>
