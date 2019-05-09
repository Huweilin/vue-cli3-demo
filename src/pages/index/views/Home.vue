<template>
  <div class="home">
    <HelloWorld msg="Welcome to Your Vue.js + TypeScript App"/>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import HelloWorld from '../components/HelloWorld.vue'; // @ is an alias to /src

interface DateRange {
  start: Date;
  end: Date;
}

@Component({
  components: {
    HelloWorld,
  },
})
export default class Home extends Vue {
  message: string = '测试';
  range: DateRange = {
    start: new Date(),
    end: new Date(),
  };

  created(): void {
  }
}
</script>
