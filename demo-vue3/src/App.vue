<template>
  <v-app id="app">
    <v-layout class="rounded rounded-md">
      <NavigationDrawer />
      <Navbar />
      <v-main id="main-container" class="d-flex align-center justify-center">
        <RouterView />
      </v-main>
      <Footer />
    </v-layout>
  </v-app>
  <SnackBar />
</template>

<script setup lang="ts">
import NavigationDrawer from '@/components/NavigationDrawer.vue'
import Footer from '@/components/Footer.vue'
import Navbar from '@/components/Navbar.vue'
import SnackBar from '@/components/common/SnackBar.vue'
import { onBeforeMount } from 'vue'

onBeforeMount(() => {
  console.log('First hook')
})
</script>

<style scoped></style>
