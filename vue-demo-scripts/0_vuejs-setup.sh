
# Create project
PROJECT_NAME=demo-vue3

npm create vue@3 $PROJECT_NAME
cd $PROJECT_NAME

# Define ts configurations
echo "{
  \"include\": [\"env.d.ts\", \"src/**/*\", \"src/**/*.vue\"],
  \"typeRoots\": [
    \"./node_modules/@types\",
    \"./node_modules/vuetify/types\"
  ],
  \"compilerOptions\": {
    \"module\": \"es2022\",
    \"moduleResolution\": \"Node\",
    \"baseUrl\": \".\",
    \"noImplicitAny\": false,
    \"paths\": {
      \"@/*\": [\"./src/*\"]
    },
    \"types\": [\"vuetify\", \"vite/client\"],
    \"target\": \"ESNext\",
    \"lib\": [\"DOM\", \"ES5\", \"es2018.promise\", \"es2016\", \"es2015\", \"es2022\"],
    
  },
  \"references\": [
    {
      \"path\": \"./tsconfig.config.json\"
    }
  ]
}" > tsconfig.app.json



# Set App.vue file
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
</template>

<script setup lang=\"ts\">
import NavigationDrawer from '@/components/NavigationDrawer.vue'
import Footer from '@/components/Footer.vue'
import Navbar from '@/components/Navbar.vue'
import { onBeforeMount } from 'vue'

onBeforeMount(() => {
  console.log('First hook')
})
</script>

<style scoped>
#main-container {
  height: 100vh;
}
</style>
" > src/App.vue


# Set all plugins in main
echo "import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

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
    warning: '#FB8C00',
  },
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
    defaultTheme: 'customLightTheme',
    themes: {
      customLightTheme,
      customDarkTheme
    }
  }
})

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(vuetify)

app.mount('#app')
" > src/main.ts


# Set default layout
rm -rf src/components/*
rm -rf src/views/*
touch src/components/Navbar.vue
touch src/components/Footer.vue
touch src/views/HomeView.vue
mkdir src/composables
mkdir src/middleware
mkdir src/helpers

# Set Navbar
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
const theme = useTheme()

function toggleTheme() {
  theme.global.name.value = theme.global.current.value.dark ? 'customLightTheme' : 'customDarkTheme'
}
</script>
" > src/components/Navbar.vue

# Set NavigationDrawer

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
      <v-list-item prepend-icon=\"mdi-home-city\" title=\"Home\" value=\"home\"></v-list-item>
      <v-list-item prepend-icon=\"mdi-account\" title=\"My Account\" value=\"account\"></v-list-item>
      <v-list-item
        prepend-icon=\"mdi-account-group-outline\"
        title=\"Users\"
        value=\"users\"
      ></v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script setup lang=\"ts\">
import { ref } from 'vue'

let drawer = ref(true)
let rail = ref(true)
</script>

<style scoped></style>
" > src/components/NavigationDrawer.vue

# Set Footer
echo "<template>
  <v-bottom-navigation grow height=\"60\">
    <v-btn value=\"favorites\">
      <v-icon icon=\"fa:fa fa-heart\" />
      Favorites
    </v-btn>
  </v-bottom-navigation>
</template>

<script setup lang=\"ts\"></script>

<style scoped></style>

" > src/components/Footer.vue

# Set Home view
echo "<template>
  <v-container> Main Content </v-container>
</template>

<script setup lang=\"ts\"></script>

<style scoped>
.card {
  width: 50%;
  margin: auto;
}
</style>
" > src/views/HomeView.vue

# Set router file from current layout
echo "import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    }
  ]
})

export default router
" > src/router/index.ts

# Remove default style
echo "@import './base.css';" > src/assets/main.css 

# Install deps
npm install
npm install vuetify@^3.2.3
npm install @fortawesome/fontawesome-free -D
npm install @mdi/font -D 

npm run format
