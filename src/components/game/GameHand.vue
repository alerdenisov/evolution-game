<template lang="pug">
  div(:class="b(modifiers)")
    div(
      v-for='card, index in hand' 
      :ref='`game-hand__handle-${index}`'
      :class="b('handle', modifiers, selectedCard === index && 'game-hand__handle--selected')"
      :style="`transform: rotate(${calculateRotation(index)}deg)`"
    )
      game-card(
        :title='card.title' 
        :height='2' 
        size='medium' 
        :quality='card.quality' 
        :picture='card.picture' 
        :class="b('card', modifiers)"
      )
    
    div(
      v-for='card, index in hand' 
      :ref='`game-hand__handle-${index}`'
      :class="b('handle', modifiers, 'game-hand__handle--hitbox')"
      :style="`transform: rotate(${calculateRotation(index)}deg)`"
      @mouseover='() => selectCard(key, index)' 
      @mouseout='() => unselectCard(key, index)'
    )
</template>

<script>
import GameCard from '@/components/game/GameCard.vue'

export default {
  name: 'game-hand',
  props: ['hand', 'side'],

  components: {
    GameCard
  },

  data () {
    return {
      animationTimeout: null,
      selectedCard: -1
    }
  },

  computed: {
    modifiers () {
      const { side } = this
      return {
        side
      }
    }
  },

  methods: {
    selectCard (key, index) {
      console.log('select', index)
      this.selectedCard = index
    },
    unselectCard (key, index) {
      console.log('unselect', index)
      this.selectedCard = -1
    },

    calculateRotation (index) {
      const count = Object.keys(this.hand).length
      const step = Math.min(10, 30 / (count - 1))
      return step * index
    }
  }
}
</script>

<style lang="scss">
@import '../../styles/style.scss';

.game-hand {
  position: absolute;

  &__handle {
    position: absolute;
    top: 0;
    padding-bottom: 300px;
    transform-origin: center bottom;
    transform: rotate(0);
    transition: all 0.5s ease;
    z-index: 1;
    pointer-events: none;

    // $elements: 10;
    // @for $i from 0 to $elements {
    //   &:nth-child(#{$i}) {
    //     transform: rotate(5deg * $i);
    //   }
    // }

    &--selected {
      transform: rotate(10deg) !important;
      padding-bottom: 500px;
      top: -200px;
      z-index: 2;
    }

    &--hitbox {
      width: $card-base-width * $card-medium-multiplier;
      height: $card-base-height * $card-medium-multiplier + 30rem;
      // border: 2px solid red;
      pointer-events: auto;
    }
  }

  &__card {
    // position: absolute;
    z-index: 1;
    pointer-events: none;
  }
}
</style>
