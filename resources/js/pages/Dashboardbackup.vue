<template>
    <div class="container">
        <section class="content-header">
            <h1>
                Dashboard
            </h1>
            <ol class="breadcrumb">
                <li><router-link :to="'/'"><i class="fa fa-dashboard"></i> Home</router-link></li>
                <li><a href="#">Dashboard</a></li>
            </ol>
        </section>

        <section class="content">
                        <div class="panel-body">
                            <line-chart  :data="dashboard_data" :options="chartOptions" :labels="labels"/>
                        </div>
                    
        </section>
    </div>
</template>
<script>
    import moment from 'moment'
    import _ from 'lodash'
    import LineChart from '../components/LineChart.vue'
    import { mapActions, mapState } from 'vuex'
    export default {
        created() {
            this.getPoolsDashboard()
        },
        data() {
            return {
                chartOptions: {
                    responsive: true,
                    maintainAspectRatio: false
                },
            }
        },
        computed: {
            ...mapState('dashboard', {
                dashboards: state => state.dashboards
            }),
            labels() {
                return _.map(this.dashboards, function(o) {
                    return moment(o.pool_name).format('DD')
                });
            },
            dashboard_data() {
                return _.map(this.dashboards, function(o) {
                    return o.good_pallet
                });
            }
        },
        methods: {
            ...mapActions('dashboard', ['getPoolsDashboard']),
        },
        components: { 'line-chart': LineChart },
    }
</script>