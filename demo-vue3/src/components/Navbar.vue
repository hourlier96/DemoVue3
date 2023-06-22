<template>
  <v-app-bar app dark height="50">
    <v-app-bar-nav-icon />

    <v-toolbar-title>Application</v-toolbar-title>

    <v-spacer />

    <v-btn @click="toggleTheme">
      <v-icon v-if="theme.global.current.value.dark" icon="fa:fa fa-moon" />
      <v-icon v-else icon="fa:fa fa-sun" />
    </v-btn>
  </v-app-bar>
</template>

<script setup lang="ts">
import { useTheme } from 'vuetify'
const theme = useTheme()

function toggleTheme() {
  theme.global.name.value = theme.global.current.value.dark ? 'customLightTheme' : 'customDarkTheme'
}
</script>
