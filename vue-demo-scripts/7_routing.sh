PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

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
    </v-list>
  </v-navigation-drawer>
</template>

<script setup lang=\"ts\">
import { ref } from 'vue'

let drawer = ref(true)
let rail = ref(true)
</script>

<style scoped></style>" > src/components/NavigationDrawer.vue

touch src/views/DynamicView.vue
touch src/views/NotFound.vue
touch src/middleware/interceptor.ts


echo "
<template>
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
        <v-btn variant=\"outlined\" @click=\"updateQueryParam()\"> Update Query Param </v-btn>
      </div>
    </template></CardContainer
  >
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
  if (route.query.id == null) {
    router.push({ path: \`/static_path\`, query: { id: 10 } })
  } else {
    const random = Math.floor(Math.random() * 100)
    router.push({ path: \`/static_path\`, query: { id: random } })
  }
}
</script>

<style></style>" > src/views/DynamicView.vue


echo "
import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'
import DynamicView from '@/views/DynamicView.vue'
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
      // Use 'children' array to define nested routes
    },
    { path: '/:pathMatch(.*)*', name: 'NotFound', component: NotFound },
  ]
})

export default router" > src/router/index.ts

echo "
<template>
  <v-alert color=\"error\"> THIS PAGE DOES NOT EXIST </v-alert>
</template>" > src/views/NotFound.vue

echo "
import router from '@/router'
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

export default interceptor" > src/middleware/interceptor.ts