<template>
        <section class="content">
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
                                                <line-chart v-if="transactions.length > 0" :data="transaction_data" :options="chartOptions" :labels="labels"/>
                                            </div>
                                        </v-card>
                                    </v-flex>
                                    <v-flex class="pa-5" xs12 md6 lg6>
                                        <v-card>  
                                            <v-toolbar>
                                                <v-toolbar-title>Pallet Receive</v-toolbar-title>
                                            </v-toolbar>    
                                            <div class="panel-body">
                                                <line-chart v-if="transactions.length > 0" :data="transaction_receive_data" :options="chartOptions" :labels="labels"/>
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
    import PieChart from '../components/PieChart.vue'
    import { mapActions, mapState } from 'vuex'
    export default {
        created() {
            this.getChartDataReceive({
                month: this.monthReceive,
                year: this.yearReceive
            }),
            this.getChartData({
                month: this.month,
                year: this.year
            }),
            
            this.getPools()
        },
        data() {
            return {
                chartOptions: {
                    responsive: true,
                    maintainAspectRatio: false
                },
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
            },
            year() {
                this.getChartData({
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
            }
        },
        computed: {
            ...mapState('dashboard', {
                transactions: state => state.transactions,
            }),
            ...mapState('dashboard', {
                transactions_receive: state => state.transactions_receive,
            }),
            ...mapState('pool', {
                pools: state => state.pool_name,
                pools: state => state.good_pallet
            }),
            datasetsfull () {
                return {
                labels: [ 'Pool DLI', 'BCTD', 'Sukabumi'],
                datasets: [
                {
                    label: 'pool_name',
                    backgroundColor: ['#41B883',
                                    '#E46651',
                                    '#00D8FF',
                                    '#DD1B16'],
                    data: [ 557,0,0]
                }
                    ]
                    }
            },
            ...mapState(['token']),
            years() {
                return _.range(2010, moment().add(1, 'years').format('Y'))
            },
            labels() {
                return _.map(this.transactions, function(o) {
                    return moment(o.date).format('DD')
                });
            },
            transaction_data() {
                return _.map(this.transactions, function(o) {
                    return o.total
                });
            },
            transaction_receive_data() {
                return _.map(this.transactions, function(o) {
                    return o.totalreceive
                });
            }
        },
        methods: {
            ...mapActions('dashboard', ['getChartData', 'getChartDataReceive']),
            ...mapActions('pool', ['getPools', 'removePools']),
            exportData() {
                window.open(`/api/export?api_token=${this.token}&month=${this.month}&year=${this.year}`)
            }
        },
        components: { 
            'line-chart': LineChart,
            'pie-chart' : PieChart,
        },
    }
</script>