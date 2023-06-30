PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

echo "
<template>
  <v-container>
    <div class=\"mt-4 d-flex justify-content-center flex-wrap\">
      <CardContainer title=\"Even best title\" icon=\"mdi-heart\">
        <template #body> <FormBinding /> </template>
        <template #actions>
          <v-btn variant="outlined"> Action 1</v-btn>
          <v-btn variant="outlined"> Action 2</v-btn>
        </template>
      </CardContainer>

      <CardContainer title=\"Lorem Ipsum Dolor\" :width=\"600\">
        <template #header>
          <div>
            <img
              style=\"position: absolute; top: 0; right: 0; margin: 10px\"
              src=\"@/assets/python.png\"
              width=\"30\"
            />
            <div class=\"pl-8\">
              This is a short desciption of the snippet. More content for a better world...
            </div>
          </div>
        </template>
        <template #body>
          <img src=\"@/assets/ex-python.png\" width=\"600\" class=\"px-8 pb-8 pt-2\" />
          <div class=\"gradient-blur\" />
        </template>
        <template #footer>
          <div class=\"d-flex justify-space-between mb-4\">
            <span class=\"text-blue-darken-1\">By Benjamin Solano</span>
            <div class=\"text-blue-darken-1\">12 comments</div>
          </div>
          <v-chip-group>
            <v-chip style=\"border: 1px white solid\"> vscode</v-chip>
            <v-chip style=\"border: 1px white solid\"> python</v-chip>
            <v-chip style=\"border: 1px white solid\"> other</v-chip>
          </v-chip-group>
        </template>
      </CardContainer>
    </div>
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

.gradient-blur {
  backdrop-filter: blur(2px);
  height: 64px;
  margin-left: 32px;
  margin-right: 32px;
  margin-top: -85px;
}
</style>" > src/views/HomeView.vue

echo "<template>
  <v-card :title=\"props.title\" :width=\"props.width\" :prepend-icon=\"props.icon\" class=\"mx-auto ma-4\">
    <slot name=\"header\" />
    <v-card-text> <slot name=\"body\" /> </v-card-text>
    <v-divider></v-divider>
    <v-card-actions class=\"mx-6\">
      <slot name=\"footer\" />
    </v-card-actions>
  </v-card>
</template>

<script setup lang=\"ts\">
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
</style>" > src/components/common/CardContainer.vue