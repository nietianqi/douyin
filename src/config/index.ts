export default {
  baseUrl: 'http://localhost:8080',
  imgPath: '/imgs/',
  filePreview: 'http://192.168.0.103/static/uploads/'
}
const BASE_URL_MAP = {
  DEV: 'http://localhost:8080',
  PROD: '/api',  // 生产环境使用 nginx 代理路径
  // GP_PAGES: '/dist',
  GP_PAGES: '',
  GITEE_PAGES: '/douyin',
  UNI: 'https://dy.ttentau.top'
}

export const IS_SUB_DOMAIN = ['GITEE_PAGES', 'GP_PAGES'].includes(import.meta.env.VITE_ENV)
export const IS_GITEE_PAGES = ['GITEE_PAGES'].includes(import.meta.env.VITE_ENV)
export const BASE_URL = BASE_URL_MAP[import.meta.env.VITE_ENV]
export const IMG_URL = BASE_URL + '/images/'
export const FILE_URL = BASE_URL + '/data/'
export const IS_DEV = process.env.NODE_ENV !== 'production'
