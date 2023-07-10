<template>
  <v-container>
    <div class="mt-4 d-flex justify-content-center flex-wrap">
      <CardContainer title="Settings" :width="800">
        <template #body>
          <div class="text-center ma-4">
            <div class="text-caption">Text to show</div>
            <v-text-field v-model="snackSettings.text" aria-placeholder="Enter text">
            </v-text-field>

            <div class="text-caption">Type</div>
            <v-select
              v-model="snackSettings.type"
              :items="['success', 'error', 'warning', 'info']"
            ></v-select>
            <div class="text-caption">Time before hide</div>
            <v-slider
              v-model="snackSettings.timeout"
              :label="timeoutLabel"
              :step="1000"
              :min="1000"
              :max="10000"
            ></v-slider>
            <div class="text-caption">Icon</div>
            <v-select
              v-model="snackSettings.icon"
              :items="['mdi-check', 'mdi-alert']"
              placeholder="Choose an icon"
            ></v-select>
            <div class="text-caption">Position</div>
            <v-select
              v-model="snackSettings.location"
              :items="[
                'top',
                'right',
                'bottom',
                'left',
                'top right',
                'top left',
                'bottom right',
                'bottom left'
              ]"
              placeholder="Where should snackbar appear?"
            ></v-select>
            <v-checkbox v-model="snackSettings.closable" label="Closable"></v-checkbox>

            <div class="text-center">
              <v-btn variant="outlined" @click="showSnack()"> Show snack</v-btn>
            </div>
          </div>
        </template>
      </CardContainer>
    </div>
  </v-container>
</template>

<script setup lang="ts">
import CardContainer from '@/components/common/CardContainer.vue'
import { snackStore } from '@/stores/snackbar'
import { computed, reactive } from 'vue'

const sStore = snackStore()

// Instant update
// let snackSettings = reactive(sStore.$state)

// Update on new snack
let snackSettings = reactive({
  text: 'Hey !',
  type: 'error',
  timeout: 5000,
  location: 'bottom',
  icon: 'mdi-check',
  closable: false
})

let timeoutLabel = computed(() => {
  return (snackSettings.timeout / 1000).toString() + 's'
})

function showSnack() {
  sStore.display(snackSettings)
}
</script>

<style scoped></style>
