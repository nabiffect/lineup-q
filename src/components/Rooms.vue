<template>
  <b-list-group>
    <b-list-group-item class="plgroup" v-for="room in rooms" v-on:click="joinRoom()">    	
    	<p class="card-text roomname">{{room.name}}</p>
    	<p class="card-text"><img class="imgGender" :src="getMaleUrl" /> {{room.numMan}} : <img class="imgGender" :src="getFemaleUrl" /> {{room.numWoman}} , <img class="imgPanels" :src="getPanelUrl" /> {{room.numPanels}} </p>
    </b-list-group-item>    
  </b-list-group>
</template>

<script>

export default {
  name: 'Rooms',

  data() {
  	return {
  	  rooms: [
  	    {
  	      name: 'Gazua Room',
  	      numMan: '2',
          numWoman: '3',
  	      numPanels: '3'
  	    },
  	    {
  	      name: 'Qtum LOVE',
  	      numMan: '3',
          numWoman: '0',
  	      numPanels: '1'
  	    },
  	    {
  	      name: 'JOIN IN...!!',
  	      numMan: '1',
          numWoman: '1',
  	      numPanels: '2'
  	    },
        {
          name: 'Feel free to come here, plz!!',
          numMan: '1',
          numWoman: '3',
          numPanels: '0'
        },
  	  ]
  	}
  },

  computed: {
    getMaleUrl: function() {      
      return require('@/assets/male_imae.png');      
    },

    getFemaleUrl: function() {      
      return require('@/assets/female_imae.png');      
    },

    getPanelUrl: function() {
      return require('@/assets/accompany_icon_2.png')
    }
  },  

  methods: {
  	joinRoom: function() {  		
  	  this.$emit("joinroom");
  	}
  }  
}
</script>
<style scoped>
  .plgroup {
    cursor: pointer;
    border: 1px solid #000;    
  }

  .plgroup:hover {
    background: #f0f0f0;    
  }  

  .roomname {
    font-size: 16px;
    font-weight: 600;
  }

  .plgroup:hover .roomname {
    font-size: 20px; 
  }

  .imgPanels {
    width: 25px;
  }
</style>