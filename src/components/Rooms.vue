<template>
  <b-list-group>
    <b-list-group-item class="plgroup" v-for="room in rooms" v-on:click="joinRoom()">    	
    	<p class="card-text">{{room.name}}</p>
    	<p class="card-text">{{room.numPeople}} / {{room.totalPeople}}</p>
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
  	      numPeople: '5',
  	      totalPeople: '6'
  	    },
  	    {
  	      name: 'Qtum LOVE',
  	      numPeople: '3',
  	      totalPeople: '6'
  	    },
  	    {
  	      name: 'JOIN IN...!!',
  	      numPeople: '2',
  	      totalPeople: '6'
  	    },
  	  ]
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
    cursor: pointer
  }
</style>