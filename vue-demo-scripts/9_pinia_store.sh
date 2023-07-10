PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

# Install easier storage plugin
npm i pinia-plugin-persistedstate

echo "<template>
  <v-app id=\"app\">
    <v-layout class=\"rounded rounded-md\">
      <NavigationDrawer />
      <Navbar />
      <v-main id=\"main-container\" class=\"d-flex align-center justify-center\">
        <RouterView />
      </v-main>
      <Footer />
    </v-layout>
  </v-app>
  <SnackBar />
</template>

<script setup lang=\"ts\">
import NavigationDrawer from '@/components/NavigationDrawer.vue'
import Footer from '@/components/Footer.vue'
import Navbar from '@/components/Navbar.vue'
import SnackBar from '@/components/common/SnackBar.vue'
import { onBeforeMount } from 'vue'

onBeforeMount(() => {
  console.log('First hook')
})
</script>

<style scoped></style>" > src/App.vue

echo "import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'

import App from './App.vue'
import router from './router'

import { createVuetify, ThemeDefinition } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import '@mdi/font/css/materialdesignicons.css'
import '@fortawesome/fontawesome-free/css/all.css'
import { fa } from 'vuetify/iconsets/fa'
import { mdi } from 'vuetify/iconsets/mdi'
import 'vuetify/styles'

const customLightTheme: ThemeDefinition = {
  dark: false,
  colors: {
    background: '#EEEEEE',
    surface: '#FFFFFF',
    primary: '#6200EE',
    'primary-darken-1': '#3700B3',
    secondary: '#03DAC6',
    'secondary-darken-1': '#018786',
    error: '#B00020',
    info: '#2196F3',
    success: '#4CAF50',
    warning: '#FB8C00'
  }
}

const customDarkTheme: ThemeDefinition = {
  dark: true,
  colors: {
    background: '#222831',
    surface: '#1c1e26',
    primary: '#6200EE',
    'primary-darken-1': '#3700B3',
    secondary: '#03DAC6',
    'secondary-darken-1': '#018786',
    error: '#B00020',
    info: '#2196F3',
    success: '#4CAF50',
    warning: '#FB8C00'
  }
}

const vuetify = createVuetify({
  components,
  directives,
  icons: {
    sets: {
      fa,
      mdi
    }
  },
  theme: {
    defaultTheme: 'customDarkTheme',
    themes: {
      customLightTheme,
      customDarkTheme
    }
  }
})

const app = createApp(App)

const pinia = createPinia()
pinia.use(piniaPluginPersistedstate)

app.use(pinia)
app.use(router)
app.use(vuetify)

app.mount('#app')" > src/main.ts

echo "<template>
  <v-app-bar app dark height=\"50\">
    <v-app-bar-nav-icon />

    <v-toolbar-title>Application</v-toolbar-title>

    <v-spacer />

    <v-btn @click=\"toggleTheme\">
      <v-icon v-if=\"theme.global.current.value.dark\" icon=\"fa:fa fa-moon\" />
      <v-icon v-else icon=\"fa:fa fa-sun\" />
    </v-btn>
  </v-app-bar>
</template>

<script setup lang=\"ts\">
import { useTheme } from 'vuetify'
import { snackStore } from '@/stores/snackbar'
const theme = useTheme()
const sStore = snackStore()

function toggleTheme() {
  theme.global.name.value = theme.global.current.value.dark ? 'customLightTheme' : 'customDarkTheme'
  const snackColor = theme.global.current.value.dark ? 'white' : 'black'
  sStore.display({
    text: 'Theme changed',
    type: snackColor,
    timeout: 1000,
    location: 'top right',
    icon: 'mdi-check',
    closable: false
  })
}
</script>" > src/components/Navbar.vue

echo "<template>
  <v-navigation-drawer v-model=\"drawer\" :rail=\"rail\" permanent @click=\"rail = false\">
    <v-list-item
      prepend-avatar=\"https://randomuser.me/api/portraits/men/85.jpg\"
      title=\"John Leider\"
      nav
    >
      <template v-slot:append>
        <v-btn variant=\"text\" icon=\"mdi-chevron-left\" @click.stop=\"rail = !rail\"></v-btn>
      </template>
    </v-list-item>

    <v-divider></v-divider>

    <v-list density=\"compact\" nav>
      <!-- Herit from router-link -->
      <v-list-item to=\"/\" prepend-icon=\"mdi-home-city\" title=\"Home\" value=\"home\"></v-list-item>
      <v-list-item
        to=\"/static_path?id=10\"
        prepend-icon=\"mdi-routes\"
        title=\"Routing\"
        value=\"dynamic\"
      ></v-list-item>
      <v-list-item
        to=\"/snack_examples\"
        prepend-icon=\"mdi-message\"
        title=\"Store & Snack\"
        value=\"snacks\"
      ></v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script setup lang=\"ts\">
import { ref } from 'vue'

let drawer = ref(true)
let rail = ref(true)
</script>

<style scoped></style>" > src/components/NavigationDrawer.vue

echo "<template>
  <v-card :title=\"props.title\" :width=\"props.width\" :prepend-icon=\"props.icon\" class=\"mx-auto ma-4\">
    <slot name=\"header\" />
    <v-card-text> <slot name=\"body\" /> </v-card-text>
    <v-divider v-if=\"\$slots.footer\"></v-divider>
    <v-card-actions class=\"mx-6\">
      <slot name=\"footer\" />
    </v-card-actions>
  </v-card>
</template>

<script setup lang=\"ts\">
const props = defineProps({
  title: {
    type: String,
    default: 'Cool title'
  },
  width: {
    type: Number,
    default: 400
  },
  icon: {
    type: String,
    default: null
  }
})
</script>

<style>
.v-card-text {
  padding: 0 !important;
}

.v-card-actions {
  display: block !important;
}
</style>" > src/components/common/CardContainer.vue

touch src/components/common/SnackBar.vue

echo "<!-- Snackbar to display messages -->
<template>
  <v-snackbar
    v-model=\"sStore.displayed\"
    :color=\"sStore.type\"
    :timeout=\"sStore.timeout\"
    :location=\"sStore.location\"
  >
    <div class=\"d-flex align-center\">
      <v-icon v-if=\"sStore.icon\" :icon=\"sStore.icon\" class=\"mr-2\"></v-icon> {{ sStore.text }}
    </div>
    <template v-slot:actions>
      <v-btn v-if=\"sStore.closable\" variant=\"text\" @click=\"sStore.displayed = false\"> Close </v-btn>
    </template>
  </v-snackbar>
</template>

<script setup lang=\"ts\">
import { snackStore } from '@/stores/snackbar'
const sStore = snackStore()
</script>" > src/components/common/SnackBar.vue

echo "import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'
import DynamicView from '@/views/DynamicView.vue'
import Child1 from '@/views/child-exemple/Child1.vue'
import Child2 from '@/views/child-exemple/Child2.vue'
import SnackExamples from '@/views/SnackExamples.vue'
import NotFound from '@/views/NotFound.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      meta: { requiresAuth: false },
      component: HomeView
    },
    {
      path: '/snack_examples',
      name: 'snack_examples',
      meta: { requiresAuth: false },
      component: SnackExamples
    },
    {
      path: '/:name',
      name: 'dynamic',
      meta: { requiresAuth: false },
      component: DynamicView,
      children: [
        {
          path: 'child-1',
          name: 'child-1',
          meta: { requiresAuth: false },
          component: Child1
        },
        {
          path: 'child-2',
          name: 'child-2',
          meta: { requiresAuth: true },
          component: Child2
        }
      ]
    },
    { path: '/:pathMatch(.*)*', name: 'NotFound', component: NotFound }
  ]
})

export default router" > src/router/index.ts

rm src/stores/counter.ts
touch src/stores/snackbar.ts

echo "import { defineStore } from 'pinia'

const DEFAULT_TIMEOUT = 3000

export const snackStore = defineStore({
  id: 'snackbar',
  state: (): any => ({
    displayed: false,
    text: null,
    type: null,
    timeout: DEFAULT_TIMEOUT,
    location: 'bottom',
    icon: null,
    closable: true
  }),

  actions: {
    display({
      text,
      type,
      timeout = DEFAULT_TIMEOUT,
      location = 'bottom',
      closable = true,
      icon = null
    }) {
      if (this.displayed) {
        // Hack to reset the timer when the snackbar is already displayed
        setTimeout(() => {
          this.timeout = false
          this.display({
            text,
            type,
            timeout,
            location,
            closable,
            icon
          })
        }, 0)
      } else {
        this.text = text
        this.type = type
        this.timeout = timeout
        this.location = location
        this.closable = closable
        this.displayed = true
        this.icon = icon
      }
    }
  },
  persist: true
})" > src/stores/snackbar.ts

echo "<template>
  <v-container>
    <div class=\"mt-4 d-flex justify-content-center flex-wrap\">
      <CardContainer title=\"Settings\" :width=\"800\">
        <template #body>
          <div class=\"text-center ma-4\">
            <div class=\"text-caption\">Text to show</div>
            <v-text-field v-model=\"snackSettings.text\" aria-placeholder=\"Enter text\">
            </v-text-field>

            <div class=\"text-caption\">Type</div>
            <v-select
              v-model=\"snackSettings.type\"
              :items=\"['success', 'error', 'warning', 'info']\"
            ></v-select>
            <div class=\"text-caption\">Time before hide</div>
            <v-slider
              v-model=\"snackSettings.timeout\"
              :label=\"timeoutLabel\"
              :step=\"1000\"
              :min=\"1000\"
              :max=\"10000\"
            ></v-slider>
            <div class=\"text-caption\">Icon</div>
            <v-select
              v-model=\"snackSettings.icon\"
              :items=\"['mdi-check', 'mdi-alert']\"
              placeholder=\"Choose an icon\"
            ></v-select>
            <div class=\"text-caption\">Position</div>
            <v-select
              v-model=\"snackSettings.location\"
              :items=\"[
                'top',
                'right',
                'bottom',
                'left',
                'top right',
                'top left',
                'bottom right',
                'bottom left'
              ]\"
              placeholder=\"Where should snackbar appear?\"
            ></v-select>
            <v-checkbox v-model=\"snackSettings.closable\" label=\"Closable\"></v-checkbox>

            <div class=\"text-center\">
              <v-btn variant=\"outlined\" @click=\"showSnack()\"> Show snack</v-btn>
            </div>
          </div>
        </template>
      </CardContainer>
    </div>
  </v-container>
</template>

<script setup lang=\"ts\">
import CardContainer from '@/components/common/CardContainer.vue'
import { snackStore } from '@/stores/snackbar'
import { computed, reactive } from 'vue'

const sStore = snackStore()

// Instant update
// let snackSettings = reactive(sStore.\$state)

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

<style scoped></style>" > src/views/SnackExamples.vue