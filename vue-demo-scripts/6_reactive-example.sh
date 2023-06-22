echo "
<template>
  <v-container>
    <v-text-field v-model=\"user.age\" label=\"First name\" disabled />
    <v-btn @click=\"changeAge()\" class=\"mb-4\">
      <span> Change age</span>
    </v-btn>
    <v-btn @click=\"badelyResetUser()\" class=\"mb-4\"> Reset user value (breaks reactivity)</v-btn>
    <v-select
      label=\"Select comment\"
      :items=\"commentsArray.comments.map((comment) => comment.content)\"
    />
    <v-btn @click=\"changeComment()\" class=\"mb-4\"> Change comment</v-btn>
  </v-container>
</template>

<script setup lang=\"ts\">
import { reactive, ref } from 'vue'

// REACTIVE API - - - - - -

let user = reactive({
  age: 25
})

function changeAge() {
  if (user.age === 25) user.age = 26
  else user.age = 25
}

function badelyResetUser() {
  // LOSING REACTIVITY: age is not reactive anymore & not updated in the view
  user = reactive({
    age: 60
  })

  // Don't try destructuring, it breaks reactivity too
  // let { age } = user
}

// REF API - - - - - - -

let commentsArray = ref({
  comments: [
    {
      content: 'This is a comment'
    },
    {
      content: 'This is another comment'
    }
  ]
})

function changeComment() {
  // Don't forget .value
  commentsArray.value.comments[0].content = 'COMMENT UPDATED'
}

// - - - - - - - - - - -
</script>
" > src/components/Reactive.vue

echo "
<template>
  <v-container>
    <div class=\"mt-4 d-flex justify-content-center flex-wrap\">
      <CardContainer title=\"Form binding example\" icon=\"mdi-heart\">
        <template #body> <FormBinding /> </template>
        <template #actions>
          <v-btn> Action 1</v-btn>
          <v-btn> Action 2</v-btn>
        </template>
      </CardContainer>

      <CardContainer title=\"Complex slot example\" :width=\"600\">
        <template #header>
          <div>
            <img class=\"python-icon\" src=\"@/assets/python.png\" width=\"30\" />
            <div class=\"pl-8\">
              This is a short description of the snippet. More content for a better world...
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

      <CardContainer title=\"Reactive API example\" :width=\"800\">
        <template #body>
          <Reactive />
        </template>
        <template #footer> </template>
      </CardContainer>
    </div>
  </v-container>
</template>

<script setup lang=\"ts\">
import CardContainer from '@/components/common/CardContainer.vue'
import FormBinding from '@/components/FormBinding.vue'
import Reactive from '@/components/Reactive.vue'
</script>

<style scoped>
.card {
  width: 50%;
  margin: auto;
}

.python-icon {
  position: absolute;
  top: 0;
  right: 0;
  margin: 10px;
}

.gradient-blur {
  backdrop-filter: blur(2px);
  height: 64px;
  margin-left: 32px;
  margin-right: 32px;
  margin-top: -85px;
}
</style>
" > src/views/HomeView.vue