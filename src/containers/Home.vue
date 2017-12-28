<template lang="pug">
  div
    h1 Home

    game-field(:fields='fields')
      //- game-card(title='Prynoth' size='large' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')
      //- game-card(title='Prynoth' size='medium' type='resource' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')
      //- game-card(title='Prynoth' size='small' quality='common' :picture='`/static/images/monsters/card-common0${("00000" + Math.floor(Math.random() * 100)).slice(-3)}.png`')

    game-hand
</template>

<script>
import GameField from '@/components/game/GameField.vue'
// import GameHand from '@/components/game/GameHand.vue'

export default {
  components: {
    GameField
  },
  data () {
    // mock field
    function randomGenes () {
      const result = {}
      const genetypes = ['nature', 'water', 'beast', 'chaos', 'toxic']
      let count = 1 + Math.floor(Math.random() * 2)
      const left = 100
      const weights = Array(count).fill(0).map(w => Math.random())
      const weightsLength = 1 / weights.reduce((acc, w) => { acc += w; return acc }, 0)
      const normalizedWeights = weights.map(w => w * weightsLength)
      console.log('weights', weights)
      console.log('normalized', normalizedWeights)

      while (count > 0) {
        const geneIndex = Math.floor(Math.random() * genetypes.length)
        const gene = genetypes[geneIndex]
        genetypes.splice(geneIndex, 1)
        result[gene] = Math.floor(left * normalizedWeights[count - 1])
        count--
      }

      return result
    }

    function randomCard () {
      return {
        title: 'Prynoth',
        picture: `/static/images/monsters/card-common0${('00000' + Math.floor(Math.random() * 100)).slice(-3)}.png`,
        active: false,
        attributes: {
          attack: 5 + Math.floor(Math.random() * 10),
          health: 5 + Math.floor(Math.random() * 10)
        },
        genes: randomGenes()
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

    return {
      fields: {
        opponent: randomField(),
        player: randomField()
      }
    }
  }
}
</script>