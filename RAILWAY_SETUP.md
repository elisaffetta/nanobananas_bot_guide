# 🚂 Настройка деплоя на Railway

Railway автоматически деплоит ваш проект при каждом push в GitHub. Вот как настроить:

## 📋 Пошаговая инструкция

### 1. Создайте аккаунт на Railway

1. Перейдите на [railway.app](https://railway.app)
2. Нажмите **"Start a New Project"**
3. Войдите через GitHub

### 2. Подключите репозиторий

1. В Railway dashboard нажмите **"New Project"**
2. Выберите **"Deploy from GitHub repo"**
3. Выберите репозиторий `nanobananas_bot_guide`
4. Railway автоматически обнаружит конфигурацию

### 3. Настройте проект

Railway автоматически:
- Обнаружит `railway.json` и `nixpacks.toml`
- Установит зависимости (`npm ci`)
- Соберет проект (`npm run build`)
- Запустит сервер (`npx serve dist -s -p $PORT`)

### 4. Настройки (опционально)

В Railway dashboard:

#### Root Directory
Если нужно, укажите:
```
neurofoto-guide
```

#### Environment Variables
Railway автоматически предоставляет `$PORT`, дополнительные переменные не требуются.

#### Custom Domain
1. Перейдите в **Settings** → **Domains**
2. Нажмите **"Generate Domain"** для получения бесплатного домена `*.up.railway.app`
3. Или добавьте свой домен

### 5. Автоматический деплой

После настройки:
- ✅ Каждый `git push` в `main` ветку автоматически деплоит на Railway
- ✅ Railway показывает логи сборки в реальном времени
- ✅ Откат к предыдущей версии доступен в один клик

## 🔧 Файлы конфигурации

### `railway.json`
Определяет команды сборки и запуска:
```json
{
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "npm install && npm run build"
  },
  "deploy": {
    "startCommand": "npx serve dist -s -p $PORT"
  }
}
```

### `nixpacks.toml`
Настройки Nixpacks (билдер Railway):
```toml
[phases.setup]
nixPkgs = ['nodejs_20']

[phases.install]
cmds = ['npm ci']

[phases.build]
cmds = ['npm run build']

[start]
cmd = 'npx serve dist -s -p $PORT'
```

## 🌐 Netlify + Railway одновременно

### GitHub Actions автоматически деплоит на обе платформы:

1. **Netlify** - через GitHub Actions (требует токены)
2. **Railway** - через встроенную интеграцию (автоматически)

### Настройка GitHub Secrets для Netlify:

1. Перейдите в GitHub репозиторий
2. **Settings** → **Secrets and variables** → **Actions**
3. Добавьте секреты:
   - `NETLIFY_AUTH_TOKEN` - Personal Access Token из Netlify
   - `NETLIFY_SITE_ID` - Site ID из Netlify

**Получить токены:**
- Netlify Auth Token: [app.netlify.com/user/applications](https://app.netlify.com/user/applications)
- Site ID: Netlify Dashboard → Site Settings → General → Site information

## 🚀 Workflow

```bash
# Локальная разработка
npm run dev

# Коммит изменений
git add .
git commit -m "Update content"
git push origin main

# 🎉 Автоматически деплоится на:
# ✅ Netlify (через GitHub Actions)
# ✅ Railway (через GitHub интеграцию)
```

## 📊 Мониторинг

### Railway Dashboard
- Логи деплоя в реальном времени
- Метрики использования (CPU, RAM, Network)
- История деплоев

### Netlify Dashboard
- Deploy logs
- Build minutes usage
- Analytics

## 🆘 Troubleshooting

### Railway не деплоит автоматически?
1. Проверьте, что репозиторий подключен в Railway Settings
2. Убедитесь, что Root Directory указана правильно
3. Проверьте логи сборки в Railway dashboard

### Ошибка сборки?
1. Проверьте `railway.json` и `nixpacks.toml`
2. Убедитесь, что `serve` добавлен в `package.json` dependencies
3. Проверьте Node.js версию (должна быть 20)

### Netlify деплой не работает?
1. Проверьте GitHub Secrets (`NETLIFY_AUTH_TOKEN`, `NETLIFY_SITE_ID`)
2. Убедитесь, что GitHub Actions включены в репозитории
3. Проверьте логи в Actions tab

## 💡 Преимущества Railway

- ✅ **Доступен в России** без VPN
- ✅ Автоматический HTTPS
- ✅ Бесплатный план: $5 кредитов/месяц
- ✅ Мгновенные деплои (обычно < 2 минуты)
- ✅ Автоматический откат при ошибках
- ✅ Встроенные метрики и логи

## 📞 Поддержка

- Railway Docs: [docs.railway.app](https://docs.railway.app)
- Railway Discord: [discord.gg/railway](https://discord.gg/railway)
- Netlify Docs: [docs.netlify.com](https://docs.netlify.com)

---

**Готово! 🎉** Теперь каждый push автоматически деплоится на обе платформы.
