<template lang="pug">
  div(:class="b(modifiers)")
    div(:class="b('handle', modifier)" v-for='card in hand')
      game-card(:title='card.title' :height='2' size='medium' :quality='card.quality' :picture='card.picture' :class="b('card', modifiers)")
</template>

<script>
import GameCard from '@/components/game/GameCard.vue'

export default {
  name: 'game-hand',
  props: ['hand', 'side'],

  components: {
    GameCard
  },

  computed: {
    modifiers () {
      const { side } = this
      return {
        side
      }
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

    $elements: 10;
    @for $i from 0 to $elements {
      &:nth-child(#{$i}) {
        transform: rotate(5deg * $i);
      }
    }
  }
}
</style>
