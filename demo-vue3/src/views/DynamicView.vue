<template>
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
        <v-btn variant="outlined" @click="updateQueryParam()"> Update Query Param </v-btn>
      </div>
    </template></CardContainer
  >
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
  if (route.query.id == null) {
    console.log('in,')
    router.push({ path: `/static_path`, query: { id: 10 } })
  } else {
    const random = Math.floor(Math.random() * 100)
    router.push({ path: `/static_path`, query: { id: random } })
  }
}
</script>

<style></style>
