<template lang="pug">
  span(:class="b(modifiers)")
    evo-icon(:icon='type' :class="b('icon', modifiers)")
    span(:class="b('content', modifiers)") {{ value }}
</template>

<script>
import EvoIcon from './Icon.vue'
export default {
  props: ['stick', 'type', 'value', 'size'],
  name: 'badge',
  components: {
    EvoIcon
  },
  computed: {
    modifiers () {
      const { stick, type, size } = this
      return {
        stick,
        type,
        size
      }
    }
  }
}
</script>

<style lang="scss">
@import '../../styles/style.scss';
.badge {
  padding: 0.35em .7em;
  background-color: $color-badge-bg;
  border-radius: 5em;

  &__content,
  &__icon {
    &--type {
      &-water { color: $color-water; }
      &-nature { color: $color-nature; }
      &-beast { color: $color-beast; }
      &-chaos { color: $color-chaos; }
      &-toxic { color: $color-toxic; }

      &-attack,
      &-health { color: white; }
    }
  }

  &__content {
    font-weight: bold;
  }

  &--type {
    &-attack { background-color: $color-attack }
    &-health { background-color: $color-health; }
  }

  &--stick {
    &-left {
      border-top-left-radius: 0;
      border-bottom-left-radius: 0;
    }
    &-right {
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
    }
  }

  &--size {
    &-large {
      font-size: 3.5rem;
    }

    &-small {
      font-size: 2rem;
    }
  }
}
</style>

