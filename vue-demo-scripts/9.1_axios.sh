PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

npm install axios

touch .env
mkdir src/api
touch src/api/config.ts
touch src/api/test.ts
touch src/helpers/axios.ts
touch src/views/ApiExemples.vue

echo "VITE_BASE_URL=\"https://api.publicapis.org/\"" > .env

echo "export const APISettings = {
  baseURL: import.meta.env.VITE_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    Accept: 'application/json'
  }
}

export const TEST_PREFIX = 'entries'" > src/api/config.ts

echo "import api from '@/helpers/axios'
import { TEST_PREFIX } from './config'

export default {
  baseAuthUrl: \`/\${TEST_PREFIX}\`,
  async callExemple() {
    return await api.get(\`\${this.baseAuthUrl}\`, {})
  }
  // async functionExemple2() {
  //   return await api.post(\`\${this.baseAuthUrl}/<route_name>\`, {})
  // },
  // async functionExemple3() {
  //   return await api.put(\`\${this.baseAuthUrl}/<route_name>\`, {})
  // },
  // async functionExemple4() {
  //   return await api.delete(\`\${this.baseAuthUrl}/<route_name>/<id>\`)
  // }
}" > src/api/test.ts

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
      <v-list-item
        to=\"/api_exemples\"
        prepend-icon=\"mdi-network\"
        title=\"API\"
        value=\"api\"
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

echo "import { APISettings } from '@/api/config'
import axios from 'axios'

const axiosInstance = axios.create(APISettings)

export default {
  axiosInstance,
  async get(path: any, params: any, headers = null) {
    const config = {
      method: 'GET',
      url: \`\${path}\`,
      params: params
    }
    if (headers) {
      config['headers'] = headers
    }
    return await axiosInstance(config)
  },
  async post(path: any, payload: any) {
    return await axiosInstance({
      method: 'POST',
      url: \`\${path}\`,
      data: payload
    })
  },
  async patch(path: any, payload: any, headers = {}) {
    const config = { method: 'PATCH', url: \`\${path}\`, data: payload }
    if (Object.keys(headers).length > 0) {
      config['headers'] = headers
    }
    return await axiosInstance(config)
  },
  async put(path: any, payload: any, headers = {}) {
    const config = { method: 'PUT', url: \`\${path}\`, data: payload }
    if (Object.keys(headers).length > 0) {
      config['headers'] = headers
    }
    return await axiosInstance(config)
  },
  async delete(path: any) {
    return await axiosInstance({
      method: 'DELETE',
      url: \`\${path}\`
    })
  }
}" > src/helpers/axios.ts

echo "import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'
import DynamicView from '@/views/DynamicView.vue'
import Child1 from '@/views/child-exemple/Child1.vue'
import Child2 from '@/views/child-exemple/Child2.vue'
import SnackExamples from '@/views/SnackExamples.vue'
import NotFound from '@/views/NotFound.vue'
import ApiExemples from '@/views/ApiExemples.vue'

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
      path: '/api_exemples',
      name: 'api_exemples',
      meta: { requiresAuth: false },
      component: ApiExemples
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

echo "<template>
  <v-container>
    <div v-if=\"!loading\" class=\"pa-8\">{{ apiResult }}</div>
    <div v-else class=\"pa-8\">
      <div class=\"text-caption\">Call in progress...</div>
      <v-progress-linear color=\"primary\" indeterminate :height=\"5\"></v-progress-linear>
    </div>
  </v-container>
</template>

<script setup lang=\"ts\">
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

<style scoped></style>" > src/views/ApiExemples.vue

echo "import router from '@/router'
import axiosInstance from '@/helpers/axios'

const interceptor = () => {
  router.beforeEach((to, from, next) => {
    if (to.matched.some((record) => record.meta.byPassAuth)) {
      next()
    }
    if (to.matched.some((record) => record.meta.requiresAuth)) {
      next()
    } else {
      next()
    }
  })
}

// For each request made by axios
axiosInstance.axiosInstance.interceptors.request.use(
  (config) => {
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// For each response received by axios
axiosInstance.axiosInstance.interceptors.response.use(
  (response) => {
    if (response.status === 200 || response.status === 201) {
      return Promise.resolve(response)
    } else {
      return Promise.reject(response)
    }
  },
  (error) => {
    if (error.response) {
      switch (error.response.status) {
        case 401:
          break
        case 403:
          router.push({
            path: '/'
          })
          break
      }
      return Promise.reject(error.response)
    } else {
      return Promise.reject(error)
    }
  }
)

export default interceptor" > src/middleware/interceptor.ts