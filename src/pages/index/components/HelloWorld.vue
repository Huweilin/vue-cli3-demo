<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <button class="toggle-btn" @click="toggleState">点击{{isVisible ? '隐藏' : '显示'}}实时路况</button>
    <div id="map-container"></div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';

@Component
export default class HelloWorld extends Vue {
  @Prop() private msg!: string;
  // @Prop({
  //   type: String,
  //   default: 'hhh',
  //   required: true,
  // })
  // msg2!: string;

  map: any;
  isVisible: boolean = false;
  trafficLayer: any;

  mounted(): void {
    this.initMap();
  }

  public initMap(): void {
    this.map = new AMap.Map('map-container', {
      resizeEnable: true, // 是否监控地图容器尺寸变化
      zoom: 11, // 初始化地图层级
    });
    let that = this;
    this.map.plugin(['AMap.ToolBar'], function() {
      that.map.addControl(new AMap.ToolBar());
    });
  }

  public onClick(type: number): string {
    return this.msg;
  }

  public toggleState(): void {
    if (!this.trafficLayer) {
      this.trafficLayer = new AMap.TileLayer.Traffic({
          zIndex: 10,
      });
      this.trafficLayer.setMap(this.map);
      this.isVisible = true;
      return;
    }

    if (this.isVisible) {
      this.trafficLayer.hide();
      this.isVisible = false;
    } else {
      this.trafficLayer.show();
      this.isVisible = true;
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
#map-container {
  width: 90vw;
  height: 80vh;
  margin: auto;
}
.toggle-btn {
  border: 1px solid #ccc;
  padding: 5px;
  border-radius: 5px;
  background-color: rgb(18, 124, 223);
  margin: 10px 0;
  outline: none;
}
</style>
