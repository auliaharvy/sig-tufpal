<template>
  
    <v-card>
      <div style="height: 800px; width: 100%">
        <l-map :zoom="zoom" :center="center">
          <l-marker :lat-lng="center"></l-marker>
          <l-tile-layer :url="url" :attribution="attribution"></l-tile-layer>
        </l-map>
      </div>
    </v-card>
  
</template>

<script>
export default {
  data () {
    return {
      url:'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution:'© <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      zoom: 12,
      center: [0, 0],
      bounds: null,
    };
  },
  created (){
    this.$getLocation({
      enableHighAccuracy: true, //defaults to false
      timeout: Infinity, //defaults to Infinity
      maximumAge: 0 //defaults to 0
    })
      .then(coordinates => {
        console.log(coordinates);
        this.center = coordinates
  });
  }
}
</script>