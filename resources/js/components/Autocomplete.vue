<template>
 <div>
  <input type="text" placeholder="what are you looking for?" v-model="query" v-on:keyup="autoComplete" class="form-control">
  <div class="panel-footer" v-if="results.length">
   <ul class="list-group">
    <li class="list-group-item" v-for="result in results">
    {{result.pool_pallet_id}} -> {{ result.pool_name }}
    </li>
   </ul>
  </div>

 </div>
</template>
<script>
import $axios from '../api.js'

export default{
    data(){
        return {
            query: '',
            results: []
        }
    },
    methods: {
        autoComplete(){
            this.results = [];
            if(this.query.length > 2){
                $axios.get('poolautocomplete',{params: {query: this.query}}).then(response => {
                    this.results = response.data;
                });
            }
        }
    }
}
</script>
