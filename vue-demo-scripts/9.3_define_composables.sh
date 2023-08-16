PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

npm install http-status-codes --save

touch src/api/auth.ts
touch src/composables/use-apis.ts
touch src/composables/use-stores.ts
touch src/composables/use-api-wrapper.ts

echo "import api from '@/helpers/axios'
import { TEST_PREFIX } from './config'

export default {
  baseAuthUrl: \`/\${TEST_PREFIX}\`,
  async auth() {
    console.log('auth API called')
    return await api.get(\`\${this.baseAuthUrl}\`, {})
  }
}" > src/api/auth.ts

echo "import test from '@/api/test'
import auth from '@/api/auth'

export function useApis() {
  return {
    test,
    auth
  }
}" > src/composables/use-apis.ts

echo "import { snackStore } from '@/stores/snackbar'

export function useStores() {
  const snack = snackStore()
  return { snack }
}" > src/composables/use-stores.ts

echo "import { useStores } from './use-stores'
import { getReasonPhrase } from 'http-status-codes'

export async function wrapper(callback, options) {
  // Manage loading state
  options.loading.value = true
  const res = await callback
  options.loading.value = false

  if (options.popup) {
    const { snack } = useStores()

    snack.display({
      text: getText(res, options),
      type: getType(res.status),
      icon: getIcon(res.status)
    })
  }
  return res.data
}

function getText(res, options) {
  //  Define snackbar text priority:
  // 1. Custom Mapping
  // 2. API message
  // 3. HTTP status message from http-status-codes
  if ('mapping' in options && res.status in options.mapping) {
    return options.mapping[res.status]
  }
  return res.data?.message || \`\${res.status}: \${getReasonPhrase(res.status)}\`
}

function getType(status) {
  switch (status) {
    case 200:
    case 201:
    case 202:
    case 204:
      return 'success'
    case 400:
      return 'warning'
    default:
      return 'error'
  }
}

function getIcon(status) {
  switch (status) {
    case 200:
    case 201:
    case 202:
    case 204:
      return 'mdi-check'
    case 400:
      return 'mdi-message-alert'
    default:
      return 'mdi-alert'
  }
}" > src/composables/use-api-wrapper.ts

echo "import api from '@/helpers/axios'
import { TEST_PREFIX } from './config'

export default {
  baseAuthUrl: \`/\${TEST_PREFIX}\`,
  async callExemple() {
    console.log('test API called')
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


echo "import { Ref } from 'vue'

export const APISettings = {
  baseURL: import.meta.env.VITE_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    Accept: 'application/json'
  }
}

export interface ApiResponseSettings {
  loading: Ref<boolean> // Loading state for callback
  popup?: boolean // Show snackbar
  mapping?: Record<string, string> // Custom mapping for snackbar text
}

export const TEST_PREFIX = 'entries'" > src/api/config.ts

echo "<template>
  <v-container>
    <div class=\"d-flex justify-space-around\">
      <v-btn color=\"primary\" @click=\"callTestApi\">Call From Test</v-btn>
      <v-btn color=\"primary\" @click=\"callAuthApi\">Call From Auth</v-btn>
    </div>

    <div v-if=\"loading\" class=\"pa-8\">
      <div class=\"text-caption\">Call in progress...</div>
      <v-progress-linear color=\"primary\" indeterminate :height=\"5\"></v-progress-linear>
    </div>
    <div v-else-if=\"apiResult.count\" class=\"pa-8\">
      <CardContainer
        :key=\"entry.API\"
        v-for=\"entry in apiResult.entries.slice(0, 3)\"
        :title=\"entry.API\"
      >
        <template v-slot:body>
          <div class=\"pa-4\">{{ entry.Description }}</div>
        </template>
        <template v-slot:footer> </template>
      </CardContainer>
    </div>
  </v-container>
</template>

<script setup lang=\"ts\">
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

<style scoped></style>" > src/views/ApiExemples.vue