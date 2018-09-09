<template>  
  <div class="rootElem">    
    
    <h2>Final List</h2>
    
    <b-card-group class="bcg">
      <b-card class="cardG" v-for="profile in orderProfiles" :key="profile.idx"  v-bind:title="profile.name"
        v-bind:img-src="profile.img"        
        img-alt="Img"
        img-top>        
        <p class="card-text">
          {{profile.cntFavorite}} 찜
        </p>
        <template v-if="profile.name === matchName1">
          <b-badge variant="success">Matched</b-badge>
        </template>
        <div slot="footer">
          <small class="text-muted">{{profile.uptodate}}</small>
        </div>
      </b-card>    
    </b-card-group>

    <b-card-group class="bcg">
      <b-card class="cardG" v-for="profile in orderProfiles2" :key="profile.idx"  v-bind:title="profile.name"
        v-bind:img-src="profile.img"        
        img-alt="Img"
        img-top>        
        <p class="card-text">
          {{profile.cntFavorite}} 찜
        </p>
        <template v-if="profile.name === matchName2">
          <b-badge variant="success">Matched</b-badge>
        </template>
        <div slot="footer">
          <small class="text-muted">{{profile.uptodate}}</small>
        </div>
      </b-card>    
    </b-card-group>

    <div class="panels">
      <h2>Hit panels</h2>

      <b-list-group>
        <b-list-group-item v-for="panel in panels">
          {{panel.address}}
        </b-list-group-item>
      </b-list-group>
    </div>
  </div>
</template>
<script>
  
export default {
  name: 'FinalList',
  
  data() {
    return {
      profiles: [
          {
            address: '0x1233123asdasdf',
            name: '앨리스',
            img: 'https://i.imgur.com/H8mERhD.png',
            desc: '크립토를 사랑하는 앨리스에요',
            uptodate: 'Last updated 3 mins ago',
            cntFavorite: 1
          },
          {
            address: '0x2233123asdasdf',
            name: '파랑이',
            img: 'https://i.imgur.com/Z4GLMZn.png',
            desc: '파랑~파랑이에옄ㅋㅋ',
            uptodate: 'Last updated 3 hours ago',
            cntFavorite: 2
          },
          {
            address: '0x3233123asdasdf',
            name: '민낯요정',
            img: 'https://i.imgur.com/lUMpSZe.png',
            desc: '좋은 인연되었으면 해요~',
            uptodate: 'Last updated 1 day ago',
            cntFavorite: 0
          }
        ],

      profiles2: [
          {
            idx: 0,
            address: 'qfUCuSnFqFygtraZcrrcwd633oY16tWEDq',
            name: '공유',
            img: 'https://i.imgur.com/hiSJELS.png',
            desc: '제 마음을 공유해드릴게요',
            uptodate: 'Last updated 3 mins ago',
            cntFavorite: 0
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
            cntFavorite: 2
          }
        ],
      panels: [
        {
          address: 'abcdfdfdfdf'
        },
        {
          address: 'abcdfdfdfd223'
        },
        {
          address: 'abcdf2343223'
        },
      ],
      matchName1: null,
      matchName2: null
    }
  },
  computed: {
    orderProfiles() {
      return this.profiles.sort(function(a,b) {
        return (a.cntFavorite - b.cntFavorite < 0);
      });
    },

    orderProfiles2() {
      return this.profiles2.sort(function(a,b) {
        return (a.cntFavorite - b.cntFavorite < 0);
      });
    }
  },

  mounted() {
    this.matchName1 = "파랑이";
    this.matchName2 = "차돌남";
  },

  methods: {    

  	
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