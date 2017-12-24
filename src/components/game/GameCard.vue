<template lang="pug">
  div(:class='b(modifiers)')
    img(:class="b('picture', modifiers)" :src='picture')
    div(:class="b('stats', modifiers)")
      evo-badge(stick='left', size='large' :value='Math.floor(Math.random() * 250)' type='attack', :class="b('stats-badge', modifiers)")
      evo-badge(stick='right', size='large' :value='Math.floor(Math.random() * 250)' type='health', :class="b('stats-badge', modifiers)")
    div(:class="b('genes', modifiers)")
      evo-badge(stick='left', size='small' :value='Math.floor(Math.random() * 250)' type='nature', :class="b('genes-badge', modifiers)")
      evo-badge(stick='left', size='small' :value='Math.floor(Math.random() * 250)' type='water', :class="b('genes-badge', modifiers)")
      evo-badge(stick='left', size='small' :value='Math.floor(Math.random() * 250)' type='beast', :class="b('genes-badge', modifiers)")
      evo-badge(stick='left', size='small' :value='Math.floor(Math.random() * 250)' type='toxic', :class="b('genes-badge', modifiers)")
      evo-badge(stick='left', size='small' :value='Math.floor(Math.random() * 250)' type='chaos', :class="b('genes-badge', modifiers)")
    //- h3(:class="b('title', modifiers)") {{ title }}
    <svg viewBox="0 0 829 146.08" :class="b('title', modifiers)">
      <path :class="b('title-arc', modifiers)" d="M0,20.8c275.6-27.7,553.4-27.7,829,0c-4.2,41.8-8.4,83.6-12.6,125.3c-267.3-26.8-536.6-26.8-803.8,0C8.4,104.3,4.2,62.5,0,20.8z"/>
      <path id="text-path" d="M9.2,111.9c269.6-27.1,541.1-27.1,810.7,0" fill="transparent"/>
      <text>
        <textPath xlink:href="#text-path" startOffset="50%" text-anchor="middle">
          <tspan :class="b('title-content', modifiers)">{{ title }}</tspan>
        </textPath>
      </text>
    </svg>

    div(:class="b('description', modifiers)")
      p(:class="b('state', modifiers)") Cursed, Darkness, Decent
      p(:class="b('about', modifiers)") Creature from a deepest forest with strong nature aspect
    //- <svg viewBox="0 0 500 500">
    //-   <path id="curve" d="M73.2,148.6c4-6.1,65.5-96.8,178.6-95.6c111.3,1.2,170.8,90.3,175.1,97" />
    //-   <text width="500">
    //-     <textPath xlink:href="#curve">Dangerous Curves Ahead</textPath>
    //-   </text>
    //- </svg>
</template>

<script>
import EvoBadge from './Badge.vue'

export default {
  name: 'game-card',
  props: ['title', 'picture', 'size', 'type', 'quality'],
  components: {
    EvoBadge
  },
  computed: {
    modifiers () {
      const { size, type, quality } = this
      return {
        size,
        type,
        quality
      }
    }
  }
}
</script>


<style lang="scss">
  $card-base-width: 40rem !default;
  $card-base-height: 60rem !default;

  $card-base-border-size: 1.5rem !default;
  $card-base-border-radius: 1.5rem !default;

  $card-medium-multiplier: 0.8 !default;
  $card-small-multiplier: 0.6 !default;

  .game-card {
    position: relative;
    display: flex;
    flex-direction: column;
    background-size: contain;
    background-repeat: no-repeat;
    
    width: $card-base-width;
    height: $card-base-height;
    border-width: $card-base-border-size; 
    border-radius: $card-base-border-radius;

    border-style: solid;
    border-color: #1b1918;

    transition: all 0.2s ease;

    &__picture {
      position: absolute;
      display: block;
      width: 100%;
      z-index: 0;
    }

    &__stats {
      display: flex;
      justify-content: space-between;

      margin: 0 (-$card-base-border-size);
      margin-top: 3rem;

      &--size {
        &-medium { 
          margin: 0 (-$card-base-border-size * $card-medium-multiplier); 
          margin-top: 2rem;
        }

        &-small { 
          margin: 0 (-$card-base-border-size * $card-small-multiplier); 
          margin-top: 1rem;
        }
      }
    }

    &__genes {
      display: flex;
      flex-direction: column;
      align-items: flex-start;

      z-index: 1;

      margin: 0 (-$card-base-border-size);
      margin-top: 2rem;

      &--size {
        &-medium { 
          margin: 0 (-$card-base-border-size * $card-medium-multiplier); 
          margin-top: 1rem;
        }
        
        &-small { 
          margin: 0 (-$card-base-border-size * $card-small-multiplier); 
          margin-top: 0.5rem;

          .icon { display: none; }
        }
      }
    }

    &__genes-badge { 
      margin-bottom: 1rem; 

      &--size {
        &-medium {
          font-size: 1.8rem !important;
          margin-bottom: 0.8rem; 
        }
        &-small { 
          font-size: 1.5rem !important;
          margin-bottom: 0.5rem; 
        }
      }
    }

    &__stats-badge {
      &--size {
        &-medium { font-size: 3rem !important; }
        &-small { font-size: 2.5rem !important; }
      }
    }

    &__title {
      margin: 0 (-$card-base-border-size * 2);
      margin-top: 3rem;
      margin-bottom: -1.5rem;
      z-index: 2;

      &--size {
        &-medium { 
          margin: 0 (-$card-base-border-size * $card-medium-multiplier * 2); 
          margin-top: 2rem;
          margin-bottom: -1rem;
        }

        &-small { 
          margin: 0 (-$card-base-border-size * $card-small-multiplier * 2); 
          margin-top: 1rem;
          margin-bottom: -.8rem;
        }
      }

      &-arc {
        fill: #403931;
      }

      &-content {
        font-size: 8.2rem;
        fill: white;
        font-family: 'PT Serif', serif;
      }
    }

    &__description {
      background-color: #26221f;
      color: white;
      padding: 0 2rem;
      flex-grow: 1;

      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;

      &--size {
        &-medium { padding: 0 1.5rem }
        &-small { padding: 0 1rem }
      }
    }

    &__about,
    &__state {
      text-align: center;
    }

    &__about {
      &--size {
        // &-medium,
        &-small { display: none; }
      }
    }

    &__state {
      font-size: 1.3rem;
      margin-bottom: 1em;
      &--size {
        &-small {
          font-size: 1.2rem;
        }
      }
    }

    &--quality {
      &-common {
        background-color: #cbac87;
      }
      &-rare {
        background-color: #b5b5b5;
      }
      &-legendary {
        background-color: #b5b5b5;
      }
    }

    &--size {
      &-medium {
        width: $card-base-width * $card-medium-multiplier;
        height: $card-base-height * $card-medium-multiplier;
        border-width: $card-base-border-size * $card-medium-multiplier; 
        border-radius: $card-base-border-radius * $card-medium-multiplier;
      }
      &-small {
        width: $card-base-width * $card-small-multiplier;
        height: $card-base-height * $card-small-multiplier;
        border-width: $card-base-border-size * $card-small-multiplier; 
        border-radius: $card-base-border-radius * $card-small-multiplier;
      }
    }
  }
</style>
