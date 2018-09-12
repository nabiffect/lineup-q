<template>
  <div>
  	<b-card class="cardG">
  	  <div class="profile-info"> 
        <p class="uimg">
          <b-img left rounded="circle" width="75" height="75" src="https://i.imgur.com/hiSJELS.png" />
        </p>

  	  	<p class="text-center uname">
  	  	  {{userinfo.uname}}  <img :src="getGenderUrl" />
  	  	</p>  	  	
  	  	<p class="text-center address">
  	  	   {{userinfo.account}} <span class="reftxt">(Address)</span>
  	  	</p>
  	  	<p class="text-center balance">
  	  	   {{_getFormattedBalance}} <span class="reftxt">(Balance)</span>
  	  	</p>
  	  </div>
  	</b-card>
  </div>
</template>

<script>
  import qs from 'qs';

  export default {
    name: 'ProfileCard',

    props: ['userinfo'],
    data() {
      return {
        // uname: 'WillPark',
        // gender: 'male',        
        // account: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
        // balance: null,
        errored: false,
      }      
    },
    computed: {
      getGenderUrl: function() {
      	if(this.userinfo.gender=='m'){
      	  return require('@/assets/male_imae.png');
      	} else {
      	  return require('@/assets/female_imae.png');
      	}      	
      },

      _getFormattedBalance() {
        if(this.userinfo.balance){          
          const strBalance  = this.userinfo.balance.toString();
          const lidx = strBalance.length-8
          return strBalance.slice(0, lidx);
        } else {
          return 0
        }
      }
    },

    mounted() {
      
    }   
  }
</script>
<style scoped>
  .cardG {
    max-width: 600px;
    height: 190px;
  }   

  .profile-info {
    font-size: 14px;
  }  

  .profile-info .uname {
    font-weight: 800;
  }  

  .profile-info .reftxt{
    font-size: 11px;
    font-weight: 400;
  }

  .profile-info .balance {
    font-size: 16px;
    font-weight: 700;
  }
</style>