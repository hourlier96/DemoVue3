import { createRouter, createWebHistory } from 'vue-router'
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

export default router
