import Vue from 'vue'
import App from '@/containers/App'
import router from './router'
import store from './store'
import vueBemCn from 'vue-bem-cn'
import AsyncComputed from 'vue-async-computed'

Vue.use(vueBemCn)
Vue.use(AsyncComputed)

Vue.config.devtools = true
Vue.config.productionTip = false

require('normalize.css')

/* eslint-disable no-new */

new Vue({
  el: '#app',
  router,
  store,
  template: '<App />',
  components: { App }
})
