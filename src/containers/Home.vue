<template lang="pug">
  div
    h1 Home

    game-field(:fields='fields')
      //- game-card(title='Prynoth' size='large' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')
      //- game-card(title='Prynoth' size='medium' type='resource' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')
      //- game-card(title='Prynoth' size='small' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')

    game-hand(:hand='playerHandProp' side='player')
</template>

<script>
import GameField from '@/components/game/GameField.vue'
import GameHand from '@/components/game/GameHand.vue'

// helper functions
function randomCard () {
  return {
    title: 'Prynoth',
    picture: `/static/images/monsters/card-common0${('00000' + Math.floor(Math.random() * 100)).slice(-3)}.png`,
    quality: 'common',
    active: false
  }
}

function randomField () {
  const field = []
  for (let row = 0; row < 3; row++) {
    field[row] = []
    for (let cell = 0; cell < 3; cell++) {
      if (Math.random() > 0.5) {
        field[row].push(randomCard())
      } else {
        field[row].push({})
      }
    }
  }

  return field
}

function randomHand () {
  let count = 2 + Math.floor(Math.random() * 10)
  const hand = []

  while (count > 0) {
    hand.push(randomCard())
    count--
  }

  return hand
}

export default {
  components: {
    GameField,
    GameHand
  },

  data () {
    return {
      fields: {
        opponent: randomField(),
        player: randomField()
      },
      hands: {
        player: randomHand()
      }
    }
  },

  computed: {
    playerHandProp () {
      return Object.assign({}, this.hands.player)
    }
  },

  mounted () {
    // setInterval(() => {
    //   this.hands.player = randomHand()
    //   this.fields.player = randomField()
    // }, 3500)
  }
}
</script>