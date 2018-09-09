<template>
	<b-container>
    <b-row>
      <b-col cols="4"><ProfileCard /></b-col>
      <b-col cols="8">
        <template v-if="!isJoin">
          <Rooms v-on:joinroom="onChangeChatRoom" />
        </template>
        <template v-else>
          <ChatComp v-on:showcmodal="_showChooseModal" v-on:showbmodal="_showBetModal" v-on:showfmodal="_showFinalModal" />  
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
</template>

<script>
import ProfileCard from '@/components/ProfileCard';
import Rooms from '@/components/Rooms';
import ChatComp from '@/components/ChatComp';
import ChoosePartnerComp from '@/components/ChoosePartnerComp';
import ChooseBetComp from '@/components/ChooseBetComp';
import FinalList from '@/components/FinalList';

import qs from 'qs';

export default {
  name: 'chat',
  components: {
    ProfileCard,
    ChatComp,
    Rooms,
    ChoosePartnerComp,
    ChooseBetComp,
    FinalList
  },
  data() {
    return {
	    isJoin: true,
      selProfile: null,
      selBetProfile1: null,
      selBetProfile2: null
    }
  },

  mounted() {
  	this.$EventBus.$on('selectPartner', this._selectPartner);
    this.$EventBus.$on('betPartner1', this._betPartner1);
    this.$EventBus.$on('betPartner2', this._betPartner2);
  },

  methods: {
  	onChangeChatRoom() {
      console.log("test");
      this.isJoin = true;
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

      // this._likeAtPartner(this.selProfile.address)
    },

    _likeAtPartner(address) {
      if(!address){
        console.error("no address found")
        return;
      } 

      this.axios
        .post('/lineup/likeAtPartner', qs.stringify({'address': address}))
        .then(response => {
          console.log("result", response.data.result);
        })
        .catch(error => {
          console.log(error)          
        });
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
      this.axios
        .post('/lineup/betMatch', qs.stringify({'fromAddr': fromAddr, 'toAddr': toAddr}))
        .then(response => {
          console.log("result", response.data.result)
        })
        .catch(error => {
          console.log(error)                  
        })  
    },


    handleFinalClose() {

    }
  }
}
</script>

<style scoped>


</style>
