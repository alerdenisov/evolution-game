<template lang="pug">
  .app
    h1 test
    router-view
</template>

<script>
export default {
}
</script>

<style lang="scss">
@import '../styles/style.scss';

html {
  font-size: 10px; // all another will be in rems
}
body {
  font-family: 'Roboto', sans-serif;
  font-size: 1.6rem;
  background-color: $color-page-bg;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'PT Serif', serif;
}
</style>
