import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import VueChatScroll from 'vue-chat-scroll'
import axios from 'axios'
import VueAxios from 'vue-axios'
import router from './router'
import {store} from './store/'

//set default baseURL
axios.defaults.baseURL = 'http://localhost:3000/api'

Vue.use(BootstrapVue)
Vue.use(VueChatScroll)
Vue.use(VueAxios, axios)
Vue.config.productionTip = false


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
