<template>
  <v-container>
    <div class="d-flex justify-space-around">
      <v-btn color="primary" @click="callTestApi">Call From Test</v-btn>
      <v-btn color="primary" @click="callAuthApi">Call From Auth</v-btn>
    </div>

    <div v-if="loading" class="pa-8">
      <div class="text-caption">Call in progress...</div>
      <v-progress-linear color="primary" indeterminate :height="5"></v-progress-linear>
    </div>
    <div v-else-if="apiResult.count" class="pa-8">
      <CardContainer
        :key="entry.API"
        v-for="entry in apiResult.entries.slice(0, 3)"
        :title="entry.API"
      >
        <template v-slot:body>
          <div class="pa-4">{{ entry.Description }}</div>
        </template>
        <template v-slot:footer> </template>
      </CardContainer>
    </div>
  </v-container>
</template>

<script setup lang="ts">
import CardContainer from '@/components/common/CardContainer.vue'
import { useApis } from '@/composables/use-apis'
import { ref } from 'vue'
import { wrapper } from '@/composables/use-api-wrapper'
import { ApiResponseSettings } from '@/api/config'

let apiResult = ref({ count: 0, entries: [] })
let loading = ref(false)

const apis = useApis()

// Basic call api
function callAuthApi() {
  loading.value = true
  apis.auth.auth().then((res) => {
    apiResult.value = res.data
    loading.value = false
  })
}

// Call api with loading wrapper as composable
async function callTestApi() {
  let options: OptionsApi = {
    loading: loading,
    popup: true
  }

  apiResult.value = await wrapper(apis.test.callExemple(), options)
}
</script>

<style scoped></style>
