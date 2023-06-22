PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

echo "
<template>
  <v-container>
    <div>Value: {{ textField }}</div>
    <v-text-field v-model=\"textField\" label=\"First name\" />
    <v-btn @click=\"changeFirstNameValue()\"> Change firstname</v-btn>

    <br />
    <br />

    <div>Value: {{ textField2 }}</div>
    <v-text-field v-bind:value=\"textField2\" />
    <!-- v-on:input=\"textField2 = \$event.target.value -->
    <v-btn @click=\"changeFirstNameValue2()\"> Change firstname 2</v-btn>
  </v-container>
</template>

<script setup lang=\"ts\">
import { ref } from 'vue'

let textField = ref('Dupont')
function changeFirstNameValue() {
  if (textField.value === 'Dupont') textField.value = 'DeuxPonts'
  else textField.value = 'Dupont'
}

let textField2 = ref('Dupont2')
function changeFirstNameValue2() {
  if (textField2.value === 'Dupont2') textField2.value = 'DeuxPonts2'
  else textField2.value = 'Dupont2'
}
</script>

<style scoped>
.card {
  width: 50%;
  margin: auto;
}
</style>
" > src/views/HomeView.vue