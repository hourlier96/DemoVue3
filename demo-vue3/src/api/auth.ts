import api from '@/helpers/axios'
import { TEST_PREFIX } from './config'

export default {
  baseAuthUrl: `/${TEST_PREFIX}`,
  async auth() {
    console.log('auth API called')
    return await api.get(`${this.baseAuthUrl}`, {})
  }
}
