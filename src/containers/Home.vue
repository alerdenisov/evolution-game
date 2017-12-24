<template lang="pug">
  div
    h1 Home
    div(style='padding: 50px')
      game-card(title='Prynoth' size='large' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')
      game-card(title='Prynoth' size='medium' type='resource' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')
      game-card(title='Prynoth' size='small' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')
</template>

<script>
import GameCard from '@/components/game/GameCard.vue'

export default {
  components: {
    GameCard
  },

  created () {
    console.log('test')
  }
}
</script>