<template>  
  <div class="rootElem">    
    
    <h2>Participants</h2>
    
    <b-list-group class="blg">
      <b-list-group-item class="profile d-flex justify-content-between align-items-center" v-for="profile in profiles" :key="profile.idx">        
          <img :src="profile.img" />        
          <div class="detail">
            <p class="name">{{profile.name}}</p>
            <p class="desc">{{profile.desc}}</p>        
          </div>                              
      </b-list-group-item>

      <b-list-group-item class="profile d-flex justify-content-between align-items-center" v-for="profile in profiles2" :key="profile.idx">        
          <img :src="profile.img" />        
          <div class="detail">
            <p class="name">{{profile.name}}</p>
            <p class="desc">{{profile.desc}}</p>        
          </div>                  
      </b-list-group-item>
    </b-list-group>    

    <div class="panels">
      <h2>Panels</h2>

      <b-list-group >
        <b-list-group-item class="panelItem" v-for="panel in panels">
          {{panel.address}}
        </b-list-group-item>
      </b-list-group>
    </div>
  </div>
</template>
<script>
  
export default {
  name: 'ParticipantsList',
  
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
      ]    
    }
  },  

  mounted() {
    
  },

  methods: {    
  	
  }
}
</script>

<style scoped>
  .rootElem {
    margin-top: 30px;
  }

  .blg {    
    margin-bottom: 35px;
  }  

  .profile {    
    margin: 0 auto;    
    padding: 0 0 0 15px;
    max-width: 280px;
    background: #f8f8f8;
    color: #989898;

    cursor: pointer;
  }

  .profile img {
    width: 65px;
  	height: 65px;
  }

  .profile .detail {
    width: 150px;
  }

  .profile .name {
    color: #464646;
  }

  .profile .desc {
    max-width: 180px;
    font-size: 12px;
  }

  .panels {
    margin: 0 auto;
    margin-bottom: 30px;
    max-width: 280px;
  }  

  .panels .panelItem {
    background: #f8f8f8;
    color: #464646;  
  }
</style>