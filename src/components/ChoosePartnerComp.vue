<template>  
  <div class="rootElem">    
    
    <h2>Choose Partner</h2>
      
    <b-card-group class="bcg">
      <b-card class="cardG" v-for="profile in profiles2" :key="profile.idx"  v-bind:title="profile.name"
        v-bind:img-src="profile.img"
        v-on:click="onCardClick(profile)"
        img-alt="Img"
        img-top>        
        <template v-if="profile.name === selName">
          <b-badge variant="success">Selected</b-badge>
        </template>
        <div slot="footer">
          <small class="text-muted">{{profile.uptodate}}</small>
        </div>
      </b-card>    
    </b-card-group>
  </div>
</template>
<script>
  
export default {
  name: 'ChoosePartnerComp',
  
  data() {
    return {
      profiles2: [
          {
            idx: 0,
            address: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
            name: '공유',
            img: 'https://i.imgur.com/hiSJELS.png',
            desc: '제 마음을 공유해드릴게요',
            uptodate: 'Last updated 3 mins ago',
            cntFavorite: 1
          },
          {
            idx: 1,
            address: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
            name: '바람의아들',
            img: 'https://i.imgur.com/0Usai0K.png',
            desc: '바람아 불어라~',
            uptodate: 'Last updated 3 hours ago',
            cntFavorite: 1
          },
          {
            idx: 2,
            address: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
            name: '차돌남',
            img: 'https://i.imgur.com/4B2mNYz.png',
            desc: '차돌박이 좋아하는 남자',
            uptodate: 'Last updated 1 day ago',
            cntFavorite: 1
          }
        ],
      selName: null
    }
  },

  mounted() {

  },

  methods: {
  	onCardClick: function(profile) {
  	  this.selName = profile.name;
  	  this.$EventBus.$emit("selectPartner", profile)
  	}
  }
}
</script>

<style scoped>
  .cardG {
    max-width: 300px;

    cursor: pointer;
  }

  .cardG img {
  	height: 155px;
  }

  .bcg {    
    margin-bottom: 35px;
  }  
</style>