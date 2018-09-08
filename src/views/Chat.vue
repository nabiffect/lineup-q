<template>
	<b-container>
    <b-row>
      <b-col cols="4"><ProfileCard /></b-col>
      <b-col cols="8">
        <template v-if="!isJoin">
          <Rooms v-on:joinroom="onChangeChatRoom" />
        </template>
        <template v-else>
          <ChatComp v-on:showcmodal="_showChooseModal" v-on:showbmodal="_showBetModal" />  
        </template>

        <b-modal ref="modalCP" @ok="handleChoosePartner()">
          <b-card>Choose Partner</b-card>
        </b-modal>

        <b-modal ref="modalBP" @ok="handleBetPartner()">
          <b-card>Choose Bet</b-card>
        </b-modal>
      </b-col>
    </b-row>
	</b-container>
</template>

<script>
import ProfileCard from '@/components/ProfileCard';
import Rooms from '@/components/Rooms';
import ChatComp from '@/components/ChatComp';

export default {
  name: 'chat',
  components: {
    ProfileCard,
    ChatComp,
    Rooms
  },
  data() {
    return {
	    isJoin: true
    }
  },

  mounted() {
  	
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

    handleChoosePartner() {

    },

    handleBetPartner() {

    }
  }
}
</script>

<style scoped>


</style>
