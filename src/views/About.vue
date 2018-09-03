<template>
  <div class="home">
    About : Token API

    <section v-if="errored">
      <p>We're sorry, we're not able to retrieve this information at the moment. please try back later.</p>
    </section>

    <section v-else>
      <div v-if="loading">Loading...</div>

      <div v-else
      	v-for="(data, key) in info">
      	{{key}} : {{data}} 
      </div>
    </section>

    <div class="bgWrap">
	    <b-button-group>
	      <b-button @click="_buyTokens">Buy Tokens</b-button>
	      <b-button @click="_mintReserved">Mint Reserved</b-button>
	    </b-button-group>
	</div>

	<div class="bgWrap">
	    <b-button-group>
	      <b-button @click="_mintTokens">Mint Tokens</b-button>
	      <b-button @click="_transfer">Transfer Tokens</b-button>
	    </b-button-group>
	</div>

    <div v-if="resultinfo">Result Info: {{resultinfo}}</div>

    <div class="bgWrap">
	    <b-button @click="_balance">Get Balance</b-button>
	    <div v-if="balance">Balance : {{balance}}</div>
	</div>
  </div>  
</template>

<script>

import qs from 'qs';

export default {
  name: 'about',
  data() {
  	return {
  	  info: null,
  	  loading: true,
  	  errored: false,
  	  account: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
  	  balance: null,
  	  resultinfo: null
  	}
  },

  mounted() {
  	this.axios
  	  .get('/showinfo')
  	  .then(response => {
  	  	this.info = response.data;
  	  })
  	  .catch(error => {
  	  	console.log(error)  	  	
  	  	this.errored = true;
  	  })
  	  .finally(() => this.loading = false)
  },
  methods: {
  	_buyTokens: function() {
  	  this.axios
  	    .post('/buytokens', qs.stringify({'beneficiary': this.account}))
  	    .then(response => {
  	    	this.resultinfo = response.data.result
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	},

  	_mintReserved: function() {
  	  this.axios
  	    .post('/mintReserved')
  	    .then(response => {
  	    	this.resultinfo = response.data.result
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	},

  	_mintTokens: function() {
  	  this.axios
  	    .post('/mintTokens', qs.stringify({'toaddr': this.account}))
  	    .then(response => {
  	    	this.resultinfo = response.data.result
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })  
  	},

  	_balance: function() {  	  
  	  this.axios
  	    .post('/balanceof', qs.stringify({'address': this.account}))
  	    .then(response => {
  	      this.balance = response.data.balance;
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	},

  	_transfer: function() {
  	  const fromaddr = ''

  	  this.axios
  	    .post('/transfer', qs.stringify({'fromaddr': fromaddr, 'toaddr': this.account}))
  	    .then(response => {
  	    	this.resultinfo = response.data.result
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	}
  }
}
</script>
<style scoped>
  .bgWrap {
  	margin: 10px;
  }
</style>