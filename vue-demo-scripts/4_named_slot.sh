mkdir src/components/common
touch src/components/common/CardContainer.vue

echo "
<template>
  <v-card :title=\"props.title\" :width=\"props.width\" :prepend-icon=\"props.icon\" class=\"mx-auto\">
    <v-card-text> <slot name=\"body\" /> </v-card-text>
    <v-divider></v-divider>
    <v-card-actions class=\"d-flex align-center justify-center\">
      <slot name=\"actions\" />
    </v-card-actions>
  </v-card>
</template>


<script setup lang=\"ts\">
import { ref } from 'vue'

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
    default: 'mdi-home'
  }
})
</script>
" > src/components/common/CardContainer.vue

echo "
<template>
  <v-container>
    <CardContainer title=\"Even best title\" icon=\"mdi-heart\">
      <template #body> <FormBinding /> </template>
      <template #actions>
        <v-btn> Action 1</v-btn>
        <v-btn> Action 2</v-btn>
      </template>
    </CardContainer>
  </v-container>
</template>

<script setup lang=\"ts\">
import CardContainer from '@/components/common/CardContainer.vue'
import FormBinding from '@/components/FormBinding.vue'
</script>

<style scoped>
.card {
  width: 50%;
  margin: auto;
}
</style>
" > src/views/HomeView.vue