<template>
  <div>
  	<b-card class="cardG">
  	  <div class="profile-info">
  	  	<p class="text-center uname">
  	  	  Name : {{uname}}  <img :src="getGenderUrl" />
  	  	</p>  	  	
  	  	<p class="text-center address">
  	  	  Address : {{account}}
  	  	</p>
  	  	<p class="text-center balance">
  	  	  Balance : {{balance}}
  	  	</p>
  	  </div>
  	</b-card>
  </div>
</template>

<script>
  import qs from 'qs';

  export default {
    name: 'ProfileCard',

    data() {
      return {
        uname: 'WillPark',
        gender: 'male',
        // genderUrl: '../assets/male_imae.png',
        account: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
        balance: null,
        errored: false,
      }      
    },
    computed: {
      getGenderUrl: function() {
      	if(this.gender=='male'){
      	  return require('@/assets/male_imae.png');
      	} else {
      	  return require('@/assets/female_imae.png');
      	}      	
      }
    },

    mounted() {
      this.axios
        .post('/lineup/balanceOf', qs.stringify({'address': this.account}))
        .then(response => {
          this.balance = response.data.balance;
        })
        .catch(error => {
          console.log(error)        
          this.errored = true;
        })
    }   
  }
</script>
<style scoped>
  .cardG {
    max-width: 600px;
  } 

  .profile-info {

  }
</style>