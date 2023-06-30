<template>
  <v-bottom-navigation grow height="70">
    <div v-if="route.params.name != null">
      <v-btn value="exemple1" @click="goToStoreExemple()">
        <v-icon icon="mdi-cog" />
        Child 1
      </v-btn>
      <v-btn value="exemple 2" @click="goToStoreExemple2()">
        <v-icon icon="mdi-cogs" />
        Child 2
      </v-btn>
    </div>
  </v-bottom-navigation>
</template>

<script setup lang="ts">
import { useRoute } from 'vue-router'
import router from '@/router'

const route = useRoute()

function goToStoreExemple() {
  router.push({ name: 'child-1' }) // Loses the query param
}

function goToStoreExemple2() {
  router.push({ name: 'child-2' }) // Loses the query param
}
</script>

<style scoped></style>
