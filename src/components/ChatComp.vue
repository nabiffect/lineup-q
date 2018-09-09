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
    	<b-container class="msgContainer">      	        	  
        <b-form @submit.prevent="sendMessage">
        	<b-row>
        	<!-- <b-col>
            <b-form-input id="ipUser" placeholder="User" v-model="user" class="form-control" required></b-form-input>
          </b-col> -->
          <b-col>
            <b-form-input id="ipMsg" type="text" placeholder="Msg" v-model="message" class="form-control" ></b-form-input>
          </b-col>
          <b-col><b-button type="submit" variant="primary" class="btn">Send</b-button></b-col>
          </b-row>
        </b-form>
      </b-container>
    </div>
    <!-- test -->
    <div>
      <b-button @click="showChooseModal">Show Choose Partner</b-button>
      <b-button @click="showBetModal">Show Bet Partners</b-button>
      <b-button @click="showFinalModal">Show Final List</b-button>
    </div>
	</div>
</template>

<script>
import io from 'socket.io-client';

export default {
  name: 'ChatComp',

  data() {
    return {
  	  user: 'will',
  	  message: '',
  	  messages: [
        {user: 'tester', 'message': 'testtest This is totally testing for those who want to user.'},
        {user: 'tester', 'message': 'testtest This is totally testing for those who want to user.'},
        {user: 'tester', 'message': 'testtest This is totally testing for those who want to user.'},
        {user: 'tester', 'message': 'testtest This is totally testing for those who want to user.'},
        {user: 'tester', 'message': 'testtest This is totally testing for those who want to user.'},
      ],
  	  socket: io('localhost:3000')      
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
.card {
  height: 600px;
}

.header {
  margin: 10px;
}

.messages {
  height: 400px;  
  border: 1px solid black;
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
  float: right;
  clear: both;
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
  width: 500px;
}

</style>
