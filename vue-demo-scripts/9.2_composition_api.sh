PROJECT_NAME=demo-vue3
cd $PROJECT_NAME

npm i @vueuse/core && npm i @vueuse/components

echo "<template>
  <v-app-bar app dark height=\"50\">
    <v-app-bar-nav-icon />

    <v-toolbar-title>{{ x }}x {{ y }}y</v-toolbar-title>

    <v-spacer />

    <p class=\"text-20px font-bold text-emerald-500\">
      {{ formatted }}
    </p>

    <v-spacer />

    <UseOnline v-slot=\"{ isOnline }\">
      <span class=\"navbar-text mr-16\">
        Connected:
        <v-icon icon=\"fa:fas fa-circle\" :color=\"\`\${isOnline ? 'green' : 'red'}\`\" size=\"x-small\">
        </v-icon>
      </span>
    </UseOnline>

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
import { useMouse } from '@vueuse/core'
import { UseOnline } from '@vueuse/components'
const theme = useTheme()
const sStore = snackStore()

const { x, y } = useMouse()

import { ref } from 'vue'
import { useDateFormat, useNow } from '@vueuse/core'

const formatter = ref('DD-MM-YYYY - HH:mm:ss')
const formatted = useDateFormat(useNow(), formatter)

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