import Vue from 'vue';
import App from './App.vue';
import router from '@/router/router';
import AMap from 'AMap';

Vue.config.productionTip = false;

Vue.prototype.$AMap = AMap;
new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
