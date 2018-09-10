<template>  
  <div class="rootElem">    
    
    <h2>Bet Partner</h2>
      
    <b-card-group class="bcg">
      <b-card class="cardG" v-for="profile in profiles" :key="profile.idx"  v-bind:title="profile.name"
        v-bind:img-src="profile.img"
        v-on:click="onCardClick(profile)"
        img-alt="Img"
        img-top>        
        <template v-if="profile.name === selName">
          <b-badge variant="success">Selected</b-badge>
        </template>
        <div slot="footer">
          <small class="text-muted">{{profile.desc}}</small>
        </div>
      </b-card>    
    </b-card-group>

    <b-card-group class="bcg">
      <b-card class="cardG" v-for="profile in profiles2" :key="profile.idx"  v-bind:title="profile.name"
        v-bind:img-src="profile.img"
        v-on:click="onCardClick2(profile)"
        img-alt="Img"
        img-top>        
        <template v-if="profile.name === selName2">
          <b-badge variant="success">Selected</b-badge>
        </template>
        <div slot="footer">
          <small class="text-muted">{{profile.desc}}</small>
        </div>
      </b-card>    
    </b-card-group>
  </div>
</template>
<script>
import profiles from '../mockprofiles.js';
  
export default {
  name: 'ChooseBetComp',
  
  data() {
    return {
      profiles: profiles().profiles,

      profiles2: profiles().profiles2,
      selName: null,
      selName2: null
    }
  },

  mounted() {

  },

  methods: {
  	onCardClick(profile) {
  	  this.selName = profile.name;
  	  this.$EventBus.$emit("betPartner1", profile)
  	},

    onCardClick2(profile) {
      this.selName2 = profile.name;
      this.$EventBus.$emit("betPartner2", profile)
    } 
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