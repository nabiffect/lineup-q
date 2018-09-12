<template>
	<div class="card mt-3">
		<div>
        <div class="header">
            <h3>Gazua Room</h3>
            <hr>
        </div>
        <div>
          <ul class="messages" v-chat-scroll>
            <li v-bind:class="{message: true, outgoing: isMyMsg(msg.user)}" v-for="(msg, index) in messages" :key="index">
              <div class="msgWrapper">
                <div class="msg">{{msg.message}}</div>
                <div class="username">{{msg.user}}</div>
              </div>
            </li>
          </ul> 
        </div>
    </div>
    <div>
      <template v-if="!isready">
        <b-button class="btnReady" v-on:click="playerReady">Ready</b-button>
      </template>
      <template v-else>
      	<b-container class="msgContainer">      	        	  
          <b-form @submit.prevent="sendMessage">
          	<b-row>
          	<!-- <b-col>
              <b-form-input id="ipUser" placeholder="User" v-model="user" class="form-control" required></b-form-input>
            </b-col> -->
            <b-col>
              <b-form-input id="ipMsg" type="text" placeholder="Message..." v-model="message" class="form-control" ></b-form-input>
            </b-col>
            <b-col><b-button type="submit" class="btn">Send</b-button></b-col>
            </b-row>
          </b-form>
        </b-container>
      </template>
    </div>
    <!-- test -->
    <!-- <div>
      <b-button @click="showChooseModal">Show Choose Partner</b-button>
      <b-button @click="showBetModal">Show Bet Partners</b-button>
      <b-button @click="showFinalModal">Show Final List</b-button>
    </div> -->
	</div>
</template>

<script>
import io from 'socket.io-client';

export default {
  name: 'ChatComp',

  props: ['isready'],
  data() {
    return {
  	  user: 'will',
  	  message: '',      
  	  messages: [
        {user: 'admin', 'message': 'The game will start once the parties on ready.'},
        {user: 'admin', 'message': 'Please click the button called ready, it would be depositted on fund pool automatically.'}        
      ],
  	  socket: io('localhost:3000'),      
    }
  },

  mounted() {
  	this.socket.on('MESSAGE', (data) => {
  	  this.messages = [...this.messages, data];
  	});        
  },

  methods: {
    isMyMsg(username) {      
      return username == this.user;
    },

    playerReady() {
      this.$emit("playerready");                
    },   

  	sendMessage(e) {
  	  e.preventDefault();

  	  this.socket.emit('SEND_MESSAGE', {
  	  	user: this.user,
  	  	message: this.message
  	  });
  	  this.message = '';
  	},

    showChooseModal() {
      this.$emit("showcmodal")
    },

    showBetModal() {
      this.$emit("showbmodal")
    },

    showFinalModal() {
      this.$emit("showfmodal")
    }
  }
}
</script>

<style scoped>
.btn {
  background-color: #235a06;
  border-color: #235a06;
}

.card {
  height: 600px;
}

.header {  
  background: #235a06;    
  color: #fff;
  padding-top: 10px;
}

.btnReady {
  width: 200px;
  margin: 10px;
}

.messages {
  height: 400px;  
  border: 3px solid #235a06;
  padding: 10px 20px 5px 10px;
  overflow-y: auto;  
}


.message .msgWrapper{
  background: #ebebeb none repeat scroll 0 0;
  border-radius: 3px;
  color: #646464;
  font-size: 14px;
  margin: 0;
  padding: 5px 10px 5px 12px;    
  list-style: none;  
  margin: 10px 0 10px 0;
  width: 360px;
  max-width: 460px;
  text-align: left;
}

.message.outgoing .msgWrapper{      
  margin-left: 350px;  
  background: #05728f none repeat scroll 0 0;  
  color:#fff;
  padding: 5px 10px 5px 12px;
}

.message .username {
  font-weight: 800;
}

.msgContainer {
  margin: 10px;
  margin-bottom: 10px;
}

#ipMsg {
  width: 450px;
}

</style>
