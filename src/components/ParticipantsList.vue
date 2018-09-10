<template>  
  <div class="rootElem">    
    
    <h2>Participants</h2>
    
    <b-list-group class="blg">
      <b-list-group-item class="profile d-flex justify-content-between align-items-center" v-for="profile in profiles" :key="profile.idx">        
          <img :src="profile.img" />        
          <div class="detail">
            <p class="name">{{profile.name}} <img class="imgGender" :src="getFemaleUrl" /></p>
            <p class="desc">{{profile.desc}}</p>        
          </div>                              
      </b-list-group-item>

      <b-list-group-item class="profile d-flex justify-content-between align-items-center" v-for="profile in profiles2" :key="profile.idx">        
          <img :src="profile.img" />        
          <div class="detail">
            <p class="name">{{profile.name}} <img class="imgGender" :src="getMaleUrl" /></p>
            <p class="desc">{{profile.desc}}</p>        
          </div>                  
      </b-list-group-item>
    </b-list-group>    

    <div class="panels">
      <h2>Panels</h2>

      <b-list-group >
        <b-list-group-item class="panelItem" v-for="panel in panels" :key="panel.address">
          {{panel.address}}
        </b-list-group-item>
      </b-list-group>
    </div>
  </div>
</template>
<script>
import profiles from '../mockprofiles.js';

export default {
  name: 'ParticipantsList',
  
  data() {    
    return profiles();
  },

  computed: {
    getMaleUrl: function() {      
      return require('@/assets/male_imae.png');      
    },

    getFemaleUrl: function() {      
      return require('@/assets/female_imae.png');      
    }
  },  

  mounted() {
    
  },

  methods: {    
  	
  }
}
</script>

<style scoped>
  .rootElem {
    margin-top: 30px;
  }

  .blg {    
    margin-bottom: 35px;
  }  

  .profile {    
    margin: 0 auto;    
    padding: 0 0 0 15px;
    max-width: 280px;
    background: #f8f8f8;
    color: #989898; 
  }

  .profile img {
    width: 65px;
  	height: 65px;
  }

  .profile .detail {
    width: 150px;
  }

  .profile .detail .imgGender {
    width: 17px;
    height: 17px;
  }

  .profile .name {
    color: #464646;
  }

  .profile .desc {
    max-width: 180px;
    font-size: 12px;
  }

  .panels {
    margin: 0 auto;
    margin-bottom: 30px;    
    max-width: 280px;
  }  

  .panels .panelItem {
    background: #f8f8f8;
    color: #464646;  
    width: 280px;
    white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis;
  }
</style>