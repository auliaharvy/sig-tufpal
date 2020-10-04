<script>
    import { Bar } from 'vue-chartjs'

    export default {
        extends: Bar,
        props: ['data','data1', 'options', 'labels'],
        mounted() {
            this.lineRenderChart()
        },
        watch: {
            data: {
                handler() {
                    this._data._chart.destroy()
                    this.lineRenderChart()
                },
                deep: true
            }
        },
        methods: {
            lineRenderChart() {
                this.renderChart({
                    labels: this.labels,
                    datasets: [
                        {
                            label: 'Pallet Send',
                            data: this.data,
                            backgroundColor: 
                                'rgba(255, 99, 132, 0.2)'
                            ,
                            borderColor: 
                                'rgba(255,99,132,1)'
                            ,
                            borderWidth: 1
                        },
                        {
                            label: 'Pallet Send Back',
                            data: this.data1,
                            backgroundColor: 
                                'rgba(21, 123, 190, 0.2)'
                            ,
                            borderColor: 
                                'rgba(21,123,190,1)'
                            ,
                            borderWidth: 1
                        },
                    ]
                }, this.options)
            }
        }
    }
</script>
