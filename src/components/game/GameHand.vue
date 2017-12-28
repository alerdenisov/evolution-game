<template lang="pug">
  div(:class="b(modifiers)")
    div(
      v-for='card, index in hand' 
      :ref='`game-hand__handle-${index}`'
      :class="b('handle', modifiers)"
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
      animationTimeout: null
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
    calculateRotation (index) {
      const count = Object.keys(this.hand).length
      const step = Math.min(10, 30 / (count - 1))
      return step * index
    }
  }
}
</script>

<style lang="scss">
.game-hand {
  position: absolute;

  &__handle {
    position: absolute;
    padding-bottom: 300px;
    transform-origin: center bottom;
    transform: rotate(0);
    transition: all 0.5s ease;

    // $elements: 10;
    // @for $i from 0 to $elements {
    //   &:nth-child(#{$i}) {
    //     transform: rotate(5deg * $i);
    //   }
    // }
  }
}
</style>
