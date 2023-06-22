PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

echo $(ls -l src/components)

mkdir src/components/common
touch src/components/common/CardContainer.vue

echo "
<template>
  <v-card :title=\"props.title\" :width=\"props.width\" :prepend-icon=\"props.icon\" class=\"mx-auto\">
    <v-card-text> <slot /> </v-card-text>
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
      <template #default> <FormBinding /> </template>
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