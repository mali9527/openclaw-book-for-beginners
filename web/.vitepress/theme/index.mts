import DefaultTheme from 'vitepress/theme'
import './style.css'
import { onMounted } from 'vue'

export default {
  ...DefaultTheme,
  enhanceApp() {
    // default
  },
  setup() {
    onMounted(() => {
      // Fix PDF download links: bypass VitePress SPA router
      document.addEventListener('click', (e) => {
        const link = (e.target as HTMLElement).closest('a')
        if (link && link.href && link.href.endsWith('.pdf')) {
          e.preventDefault()
          e.stopPropagation()
          window.open(link.href, '_blank')
        }
      }, true)
    })
  }
}
