<template>  
  <div>    
  	<b-container>       
      <b-row>
        <b-col cols="4" style="background: #f1f7f2">
          <img class="logo" :src="getLogo">
          <ProfileCard v-bind:userinfo="userinfo" />

          <template v-if="isJoin">
            <ParticipantsList />  
          </template>          
        </b-col>
        <b-col cols="8">
          <template v-if="endTime">
            <b-row>
              <b-col><p class="txtStart">GAME START ></p></b-col>
              <b-col>
                <CountDown v-bind:end="endTime" />
              </b-col>
              <b-col></b-col>
            </b-row>
          </template>

          <template v-if="!isFinished">
            <template v-if="!isJoin">
              <Rooms v-on:joinroom="onChangeChatRoom" />
            </template>
            <template v-else>                            
              <ChatComp  v-bind:isready="isReady" v-on:playerready="_readyGame" v-on:showcmodal="_showChooseModal" v-on:showbmodal="_showBetModal" v-on:showfmodal="_showFinalModal" />
            </template>
          </template>
          <template v-else>
            <h2>Please Wait...</h2>
          </template>

          <b-modal ref="modalCP" @ok="handleChoosePartner()">
            <ChoosePartnerComp />
          </b-modal>

          <b-modal ref="modalBP" @ok="handleBetPartner()">
            <ChooseBetComp />
          </b-modal>

          <b-modal ref="modalFP" @ok="handleFinalClose()">
            <FinalList />
          </b-modal>
        </b-col>
      </b-row>
  	</b-container>

    <template v-if="loading">
      <rotate-square2 id="spinner"></rotate-square2>
    </template>

    <template v-if="confirmed">
      <b-alert id="alertConfirm" variant="success" dismissible show>Success!!</b-alert>
    </template>
  </div>
</template>

<script>
import ProfileCard from '@/components/ProfileCard';
import ParticipantsList from '@/components/ParticipantsList';

import Rooms from '@/components/Rooms';
import ChatComp from '@/components/ChatComp';
import ChoosePartnerComp from '@/components/ChoosePartnerComp';
import ChooseBetComp from '@/components/ChooseBetComp';
import FinalList from '@/components/FinalList';

import CountDown from '@/components/CountDown'; 
import {RotateSquare2} from 'vue-loading-spinner';

import qs from 'qs';

export default {
  name: 'chat',
  components: {
    ProfileCard,
    ParticipantsList,
    ChatComp,
    Rooms,
    ChoosePartnerComp,
    ChooseBetComp,
    FinalList,
    CountDown,
    RotateSquare2
  },
  data() {
    return {      
      isFinished: false,
      loading: false,
      confirmed: false,
	    isJoin: false,
      isReady: false,
      selProfile: null,
      selBetProfile1: null,
      selBetProfile2: null,
      endTime: null,
      userinfo: {
        uname: 'Will',
        gender: 'm',
        account: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
        balance: null
      }
    }
  },
  computed: {
    getLogo() {
      return require('@/assets/logo.png')
    }
  },

  mounted() {
  	this.$EventBus.$on('selectPartner', this._selectPartner);
    this.$EventBus.$on('betPartner1', this._betPartner1);
    this.$EventBus.$on('betPartner2', this._betPartner2);

    this._getBalance();

    ///temp
    // const date = new Date();
    // date.setMinutes(date.getMinutes() + 10);
    // console.log(date)
    // this.endTime = date.toString();
  },

  methods: {
    _getBalance() {
      this.axios
        .post('/lineup/balanceOf', qs.stringify({'address': this.userinfo.account}))
        .then(response => {
          this.userinfo.balance = response.data.balance;
        })
        .catch(error => {
          console.log(error)                  
        })
    },

  	onChangeChatRoom() {
      console.log("changeChatroom");
      this.isJoin = true;      
      
      //this._startGame() 
    },

    _readyGame() {
      // this._depositFunds(this.userinfo.uname, this.userinfo.gender)
      this.isReady = true;
      this._startGame() 
    },    

    _depositFunds: function(address, gender) {
      this.loading = true;

      console.log("_depositFunds::")
      this.axios
        .post('/lineup/depositFunds', qs.stringify({'uname': address, 'gender': gender, 'amount': 100}))
        .then(response => {
          console.log("result", response.data.result);
          this._getBalance();          
          this._startGame();
        }).catch(error => {
          console.log(error)          
        }).finally(() => {
          this.loading = false;
        })
    },

    _startGame() {
      const date = new Date();
      date.setMinutes(date.getMinutes() + 10);
      console.log(date)
      this.endTime = date.toString();
    },

    _changeFinishPage() {
      this.isFinished = true

      this._showChooseModal();
    },

    _showChooseModal() {
      this.$refs.modalCP.show();
    },

    _showBetModal() {
      this.$refs.modalBP.show();
    },

    _showFinalModal() {
      this.$refs.modalFP.show();
    },

    _selectPartner(profile) {      
      this.selProfile = profile;
    },

    handleChoosePartner() {
      console.log(this.selProfile);

      this._likeAtPartner(this.selProfile.address)
    },

    _likeAtPartner(address) {
      if(!address){
        console.error("no address found")
        return;
      } 
      this.loading = true;

      this.axios
        .post('/lineup/likeAtPartner', qs.stringify({'address': address}))
        .then(response => {
          console.log("result", response.data.result);
          this.confirmed = true;
        })
        .catch(error => {
          console.log(error)          
        }).finally(() => {
          this.loading = false;
        })
    },

    _betPartner1(profile) {
      this.selBetProfile1 = profile;  
    },

    _betPartner2(profile) {
      this.selBetProfile2 = profile;
    },

    handleBetPartner() {
      console.log(this.selBetProfile1.name +"/"+this.selBetProfile2.name);

      // _betMatch(this.selBetProfile1.address, this.selBetProfile2.address);
    },

    _betMatch(fromAddr, toAddr) {
      this.loading = true;

      this.axios
        .post('/lineup/betMatch', qs.stringify({'fromAddr': fromAddr, 'toAddr': toAddr}))
        .then(response => {
          console.log("result", response.data.result)
          this.confirmed = true;
        })
        .catch(error => {
          console.log(error)                  
        }).finally(() => {
          this.loading = false;
        })
    },

    _checkFinalList: function() {     
      this.axios
        .post('/lineup/checkFinalList')
        .then(response => {
          console.log("result", response.data.result)
          this._showFinalModal()
        })
        .catch(error => {
          console.log(error)                  
        }).finally(() => {
          this.loading = false;
        })
    },    

    handleFinalClose() {
      // this._distribution()
    },

    _distribution: function() {     
      this.axios
        .post('/lineup/distribution')
        .then(response => {
          console.log("result", response.data.result)
          this._getBalance();          
        })
        .catch(error => {
          console.log(error)                  
        }).finally(() => {
          this.loading = false;
        })
    }

  }
}
</script>

<style scoped>
  .txtStart {
    font-size: 20px;
    font-weight: bold;
  }

  .logo {
    text-align: left;
    width: 130px;
  }

  #spinner {
    position: absolute;
    top: 50%;
    left: 50%;
  }

  #alertConfirm {
    position: absolute;
    top: 50%;
    left: 50%; 
  }  
</style>
