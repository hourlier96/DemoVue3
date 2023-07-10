<template>
  <v-navigation-drawer v-model="drawer" :rail="rail" permanent @click="rail = false">
    <v-list-item
      prepend-avatar="https://randomuser.me/api/portraits/men/85.jpg"
      title="John Leider"
      nav
    >
      <template v-slot:append>
        <v-btn variant="text" icon="mdi-chevron-left" @click.stop="rail = !rail"></v-btn>
      </template>
    </v-list-item>

    <v-divider></v-divider>

    <v-list density="compact" nav>
      <!-- Herit from router-link -->
      <v-list-item to="/" prepend-icon="mdi-home-city" title="Home" value="home"></v-list-item>
      <v-list-item
        to="/static_path?id=10"
        prepend-icon="mdi-routes"
        title="Routing"
        value="dynamic"
      ></v-list-item>
      <v-list-item
        to="/snack_examples"
        prepend-icon="mdi-message"
        title="Store & Snack"
        value="snacks"
      ></v-list-item>
      <v-list-item
        to="/api_exemples"
        prepend-icon="mdi-network"
        title="API"
        value="api"
      ></v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script setup lang="ts">
import { ref } from 'vue'

let drawer = ref(true)
let rail = ref(true)
</script>

<style scoped></style>
