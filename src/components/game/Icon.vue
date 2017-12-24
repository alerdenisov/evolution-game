<template lang="pug">
  i(:class='b(modifiers)')
</template>

<script>
export default {
  name: 'icon',
  props: ['icon'],
  computed: {
    modifiers () {
      const { icon } = this
      return {
        icon
      }
    }
  }
}
</script>

<style lang="scss">
</style>
