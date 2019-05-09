import Vue from 'vue';
import App from './App.vue';
import router from './router/router';
import axios from 'axios';

Vue.config.productionTip = false;

Vue.use((v) => {
  v.prototype.$axios = axios
});

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
