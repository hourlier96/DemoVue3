<template>
  <v-container>
    <v-text-field v-model="user.age" label="First name" disabled />
    <v-btn @click="changeAge()" class="mb-4">
      <span> Change age</span>
    </v-btn>
    <v-btn @click="badelyResetUser()" class="mb-4"> Reset user value (breaks reactivity)</v-btn>
    <v-select
      label="Select comment"
      :items="commentsArray.comments.map((comment) => comment.content)"
    />
    <v-btn @click="changeComment()" class="mb-4"> Change comment</v-btn>
  </v-container>
</template>

<script setup lang="ts">
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
