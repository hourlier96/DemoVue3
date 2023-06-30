<template>
  <v-container
    ><div class="mt-4 d-flex justify-content-center flex-wrap">
      <CardContainer title="Path">
        <template #body>
          <div class="text-center">{{ $route.params.name }}</div>
        </template></CardContainer
      >
      <CardContainer title="Url Param">
        <template #body>
          <div class="text-center">{{ $route.query.id }}</div>
        </template></CardContainer
      >

      <CardContainer title="Dynamic routing">
        <template #body>
          <div class="text-center">
            <v-btn variant="outlined" @click="backToHome()" class="mr-2"> Back To Home </v-btn>
            <v-btn variant="outlined" @click="updateQueryParam()"> Random location </v-btn>
          </div>
        </template></CardContainer
      >
      <!-- Child View -->
      <RouterView /></div
  ></v-container>
</template>

<script setup lang="ts">
import CardContainer from '@/components/common/CardContainer.vue'
import router from '@/router'
import { useRoute } from 'vue-router'

const route = useRoute()

function backToHome() {
  router.push({ path: '/' })
}

function updateQueryParam() {
  const random = Math.floor(Math.random() * 100)
  if (random < 50) {
    router.push({ path: `/anyotherpath`, query: { id: random } })
  } else {
    router.push({ path: `/workstoo`, query: { id: random } })
  }
}
</script>

<style></style>
