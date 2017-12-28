<template lang="pug">
  div(:class="b(modifiers)")
    div(:class="b('side', getModifiers(key))" v-for='field, key in fields')
      div(:class="b('row', getModifiers(key))" v-for='row, rowIndex in field')
        div(
          v-if='cell.title' 
          :class="b('field', getModifiers(key), cell.active && 'game-field__field--active' )" 
          v-for='cell, cellIndex in row' 
          @mouseover='() => selectCard(key, rowIndex, cellIndex)' 
          @mouseout='() => unselectCard(key, rowIndex, cellIndex)')
          game-card(
            v-if='cell.title' 
            :attributes='cell.attributes' 
            :genes='cell.genes' 
            :title='cell.title' 
            :height='cell.active ? 10 : 0' 
            :size='cell.active ? "medium" : "thumb"' 
            quality='common' 
            :picture='cell.picture')
    //- div(:class="b('side', opponentModifiers)")
      div(:class="b('row', opponentModifiers)" v-for='row, rowIndex in field.opponent')
        div(:class="b('field', opponentModifiers)" v-for='cell, index in row')
          game-card(v-if='cell.title' :title='cell.title' :size='cell.size' quality='common' :picture='cell.picture')
</template>

<script>
import GameCard from '@/components/game/GameCard.vue'

export default {
  name: 'game-field',
  props: ['fields'],
  components: {
    GameCard
  },
  methods: {
    selectCard (key, row, cell) {
      console.log('select', row, cell)
      this.fields[key][row][cell].active = true
    },
    unselectCard (key, row, cell) {
      console.log('unselect', row, cell)
      this.fields[key][row][cell].active = false
    },
    getModifiers (key) {
      return this[`${key}Modifiers`]
    }
  },
  computed: {
    modifiers () {
      return {}
    },

    playerModifiers () {
      return {
        ...this.modifiers,
        side: 'player'
      }
    },

    opponentModifiers () {
      return {
        ...this.modifiers,
        side: 'opponent'
      }
    }
  }
}
</script>

<style lang="scss">
@import '../../styles/style.scss';

.game-field {
  display: flex;
  flex-direction: column;
  
  &__side {
    display: flex;
    // flex-direction: column;
    // justify-content: space-around;
    justify-content: center;

    margin: 2rem;
  }

  &__row {
    display: flex;
  }

  &__field {
    width: $card-base-width * $card-thumb-multiplier;
    height: $card-base-height * $card-thumb-multiplier * 0.83;
    // background-color: $color-field-bg; 
    // margin: 1rem;

    &--side {
      &-opponent {
        .game-card__picture {
          transform: scaleX(-1)
        }
      }
    }

    &--active {
      // width: $card-base-width * $card-thumb-multiplier;
      position: relative;
      z-index: 2;
    }

    .game-card {
      position: absolute;
    }
  }
}
</style>

