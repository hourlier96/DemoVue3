
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

export default interceptor
