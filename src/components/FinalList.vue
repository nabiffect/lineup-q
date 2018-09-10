<template>  
  <div class="rootElem">    
    
    <h2>Final List</h2>
    
    <b-card-group class="bcg">
      <b-card class="cardG" v-for="profile in orderProfiles" :key="profile.idx"  v-bind:title="profile.name"
        v-bind:img-src="profile.img"        
        img-alt="Img"
        img-top>        
        <p class="card-text">
          {{profile.cntFavorite}} 찜
        </p>
        <template v-if="profile.name === matchName1">
          <b-badge variant="success">Matched</b-badge>
        </template>
        <div slot="footer">
          <small class="text-muted">{{profile.uptodate}}</small>
        </div>
      </b-card>    
    </b-card-group>

    <b-card-group class="bcg">
      <b-card class="cardG" v-for="profile in orderProfiles2" :key="profile.idx"  v-bind:title="profile.name"
        v-bind:img-src="profile.img"        
        img-alt="Img"
        img-top>        
        <p class="card-text">
          {{profile.cntFavorite}} 찜
        </p>
        <template v-if="profile.name === matchName2">
          <b-badge variant="success">Matched</b-badge>
        </template>
        <div slot="footer">
          <small class="text-muted">{{profile.uptodate}}</small>
        </div>
      </b-card>    
    </b-card-group>

    <div class="panels">
      <h2>Hit panels</h2>

      <b-list-group>
        <b-list-group-item v-for="panel in panels" :key="panel.address">
          {{panel.address}}
        </b-list-group-item>
      </b-list-group>
    </div>
  </div>
</template>
<script>
import profiles from '../mockprofiles.js';  
  
export default {
  name: 'FinalList',
  
  data() {
    return {
      profiles: profiles().profiles,
      profiles2: profiles().profiles2,
      panels: profiles().hitpanels,
      matchName1: null,
      matchName2: null
    }
  },
  computed: {
    orderProfiles() {
      return this.profiles.sort(function(a,b) {
        return (a.cntFavorite - b.cntFavorite < 0);
      });
    },

    orderProfiles2() {
      return this.profiles2.sort(function(a,b) {
        return (a.cntFavorite - b.cntFavorite < 0);
      });
    }
  },

  mounted() {
    this.matchName1 = "Blue";
    this.matchName2 = "Will";    
  },

  methods: {    

  	
  }
}
</script>

<style scoped>
  .cardG {
    max-width: 300px;

    cursor: pointer;
  }

  .cardG img {
  	height: 155px;
  }

  .bcg {    
    margin-bottom: 35px;
  }  
</style>