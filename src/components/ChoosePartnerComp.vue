<template>  
  <div class="rootElem">    
    
    <h2>Choose Partner</h2>
      
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
          <small class="text-muted">{{profile.uptodate}}</small>
        </div>
      </b-card>    
    </b-card-group>
  </div>
</template>
<script>
import profiles from '../mockprofiles.js';

export default {
  name: 'ChoosePartnerComp',
  
  data() {
    return {
      profiles: profiles().profiles,
      
      selName: null
    }
  },

  mounted() {

  },

  methods: {
  	onCardClick: function(profile) {
  	  this.selName = profile.name;
  	  this.$EventBus.$emit("selectPartner", profile)
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