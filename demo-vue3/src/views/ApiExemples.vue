<template>
  <v-container>
    <div v-if="!loading" class="pa-8">{{ apiResult }}</div>
    <div v-else class="pa-8">
      <div class="text-caption">Call in progress...</div>
      <v-progress-linear color="primary" indeterminate :height="5"></v-progress-linear>
    </div>
  </v-container>
</template>

<script setup lang="ts">
import test from '@/api/test'
import { onMounted } from 'vue'
import { ref } from 'vue'

let apiResult = ref('')
let loading = ref(false)

onMounted(() => {
  loading.value = true
  test.callExemple().then((res) => {
    setTimeout(() => {
      apiResult.value = res.data
      loading.value = false
    }, 3000)
  })
})
</script>

<style scoped></style>
