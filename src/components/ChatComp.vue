<template>
	<div class="card mt-3">
		<div>
        <div>
            <h3>Gazua Room</h3>
            <hr>
        </div>
        <div>
          <ul class="messages " v-chat-scroll>
            <li class="message" v-for="(msg, index) in messages" :key="index">
              <p><span>{{msg.user}}: </span>{{msg.message}}</p>
            </li>
          </ul> 
        </div>
    </div>
    <div>
    	<b-container>      	        	  
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

.messages {
  height: 400px;  
  border: 1px solid black;
  padding: 10px 20px 5px 10px;
  overflow-y: auto;  
}

li {
  background-color: #ffffff;
  border: 1px solid black;
  list-style: none;
  padding: .75rem;
  margin: 10px 0 10px 0;
  text-align: left;
}

</style>
