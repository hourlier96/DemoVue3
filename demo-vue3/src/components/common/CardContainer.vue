<template>
  <v-card :title="props.title" :width="props.width" :prepend-icon="props.icon" class="mx-auto ma-4">
    <slot name="header" />
    <v-card-text> <slot name="body" /> </v-card-text>
    <v-divider v-if="$slots.footer"></v-divider>
    <v-card-actions class="mx-6">
      <slot name="footer" />
    </v-card-actions>
  </v-card>
</template>

<script setup lang="ts">
const props = defineProps({
  title: {
    type: String,
    default: 'Cool title'
  },
  width: {
    type: Number,
    default: 400
  },
  icon: {
    type: String,
    default: null
  }
})
</script>

<style>
.v-card-text {
  padding: 0 !important;
}

.v-card-actions {
  display: block !important;
}
</style>
