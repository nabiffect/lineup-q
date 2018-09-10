<template>
  <div class="home">
    Test : Lineup API

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
	      <b-button @click="_depositFunds">Deposit Funds</b-button>
	      <b-button @click="_joinPanel">Join Panel</b-button>
        <b-button @click="_checkFundsReady">Check Funds Ready</b-button>
	    </b-button-group>
	</div>

	<div class="bgWrap">
	    <b-button-group>
        <b-button @click="_likeAtPartner">Like at Partner</b-button>
	      <b-button @click="_betMatch">Bet Match</b-button>
	      <b-button @click="_checkFinalList">Check Final List</b-button>
        <b-button @click="_distribution">Distribution</b-button>
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
  name: 'test',
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
  	this._getInfo();
  },
  methods: {
    _getInfo: function() {
      this.axios
        .post('/lineup/getinfo', qs.stringify({'address': this.account}))
        .then(response => {
          this.info = response.data;
        })
        .catch(error => {
          console.log(error)        
          this.errored = true;
        })
        .finally(() => this.loading = false)
    },

  	_depositFunds: function() {
  	  this.axios
  	    .post('/lineup/depositFunds', qs.stringify({'uname': 'tester', 'gender': 'm', 'amount': 100}))
  	    .then(response => {
  	    	this.resultinfo = response.data.result
          this._getInfo()
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	},

  	_joinPanel: function() {
  	  this.axios
  	    .post('/lineup/joinPanel')
  	    .then(response => {
  	    	this.resultinfo = response.data.result
          this._getInfo()
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	},

    _checkFundsReady: function() {
      this.axios
        .post('/lineup/checkFundsReady')
        .then(response => {
          this.resultinfo = response.data.result
          this._getInfo()
        })
        .catch(error => {
          console.log(error)        
          this.errored = true;
        })
    },

    _likeAtPartner: function() {
      this.axios
        .post('/lineup/likeAtPartner', qs.stringify({'address': this.account}))
        .then(response => {
          this.resultinfo = response.data.result
          this._getInfo()
        })
        .catch(error => {
          console.log(error)        
          this.errored = true;
        })
    },

  	_betMatch: function() {
  	  this.axios
  	    .post('/lineup/betMatch', qs.stringify({'fromAddr': this.account, 'toAddr': this.account}))
  	    .then(response => {
  	    	this.resultinfo = response.data.result
          this._getInfo()
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })  
  	},

  	_checkFinalList: function() {  	  
  	  this.axios
  	    .post('/lineup/checkFinalList')
  	    .then(response => {
  	      this.resultinfo = response.data.result
          this._getInfo()
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	},

  	_distribution: function() {  	  
  	  this.axios
  	    .post('/lineup/distribution')
  	    .then(response => {
  	    	this.resultinfo = response.data.result
          this._getInfo()
  	    })
  	    .catch(error => {
  	  	  console.log(error)  	  	
  	  	  this.errored = true;
  	    })
  	},

    _balance: function() {
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
}
</script>
<style scoped>
  .bgWrap {
  	margin: 10px;
  }
</style>