PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

echo "<template>
  <v-container
    ><div class=\"mt-4 d-flex justify-content-center flex-wrap\">
      <CardContainer title=\"Path\">
        <template #body>
          <div class=\"text-center\">{{ \$route.params.name }}</div>
        </template></CardContainer
      >
      <CardContainer title=\"Url Param\">
        <template #body>
          <div class=\"text-center\">{{ \$route.query.id }}</div>
        </template></CardContainer
      >

      <CardContainer title=\"Dynamic routing\">
        <template #body>
          <div class=\"text-center\">
            <v-btn variant=\"outlined\" @click=\"backToHome()\" class=\"mr-2\"> Back To Home </v-btn>
            <v-btn variant=\"outlined\" @click=\"updateQueryParam()\"> Random location </v-btn>
          </div>
        </template></CardContainer
      >
      <!-- Child View -->
      <RouterView /></div
  ></v-container>
</template>

<script setup lang=\"ts\">
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
    router.push({ path: \`/anyotherpath\`, query: { id: random } })
  } else {
    router.push({ path: \`/workstoo\`, query: { id: random } })
  }
}
</script>

<style></style>" > src/views/DynamicView.vue


echo "
import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'
import DynamicView from '@/views/DynamicView.vue'
import Child1 from '@/views/child-exemple/Child1.vue'
import Child2 from '@/views/child-exemple/Child2.vue'
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
    { path: '/:pathMatch(.*)*', name: 'NotFound', component: NotFound },
  ]
})

export default router" > src/router/index.ts

echo "<template>
  <v-bottom-navigation grow height=\"70\">
    <div v-if=\"route.params.name != null\">
      <v-btn value=\"exemple1\" @click=\"goToStoreExemple()\">
        <v-icon icon=\"mdi-cog\" />
        Child 1
      </v-btn>
      <v-btn value=\"exemple 2\" @click=\"goToStoreExemple2()\">
        <v-icon icon=\"mdi-cogs\" />
        Child 2
      </v-btn>
    </div>
  </v-bottom-navigation>
</template>

<script setup lang=\"ts\">
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

<style scoped></style>" > src/components/Footer.vue

mkdir src/views/child-exemple
touch src/views/child-exemple/Child1.vue
touch src/views/child-exemple/Child2.vue

echo "<template>
  <CardContainer title=\"Child 1\"> </CardContainer>
</template>

<script setup lang=\"ts\">
import CardContainer from '@/components/common/CardContainer.vue'
</script>

<style></style>" > src/views/child-exemple/Child1.vue

echo "<template>
  <CardContainer title=\"Child 2\"> </CardContainer>
</template>

<script setup lang=\"ts\">
import CardContainer from '@/components/common/CardContainer.vue'
</script>

<style></style>" > src/views/child-exemple/Child2.vue
