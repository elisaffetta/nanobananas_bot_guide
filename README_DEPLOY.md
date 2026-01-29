# 🚀 Быстрый старт: Деплой на Railway

## Что уже настроено

✅ Конфигурация Railway (`railway.json`, `nixpacks.toml`)  
✅ GitHub Actions для автоматического деплоя  
✅ Все зависимости в `package.json`

## Шаги для первого деплоя

### 1. Залейте код на GitHub (если ещё не залили)

```bash
cd /Users/elisaffetta/Downloads/neurophoto-nanobanana
git add .
git commit -m "Add Railway configuration"
git push origin main
```

### 2. Создайте проект на Railway

1. Откройте [railway.app](https://railway.app)
2. Войдите через GitHub
3. Нажмите **"New Project"**
4. Выберите **"Deploy from GitHub repo"**
5. Выберите репозиторий `nanobananas_bot_guide`
6. Укажите Root Directory: `neurofoto-guide`

### 3. Railway автоматически:

- Обнаружит конфигурацию
- Установит зависимости
- Соберет проект
- Запустит сервер
- Выдаст URL типа `https://your-project.up.railway.app`

### 4. Настройте GitHub Secrets для Netlify (опционально)

Если хотите автоматический деплой на Netlify через GitHub Actions:

1. GitHub → Settings → Secrets and variables → Actions
2. Добавьте:
   - `NETLIFY_AUTH_TOKEN` - из [app.netlify.com/user/applications](https://app.netlify.com/user/applications)
   - `NETLIFY_SITE_ID` - из Netlify Site Settings

## Автоматический деплой

После настройки каждый `git push` автоматически деплоит на:

- ✅ **Railway** (автоматически через GitHub интеграцию)
- ✅ **Netlify** (через GitHub Actions, если настроены секреты)

## Проверка деплоя

```bash
# Локальная проверка перед деплоем
cd neurofoto-guide
npm install
npm run build
npm run preview
```

## Полная документация

См. `RAILWAY_SETUP.md` для детальной инструкции.

---

**Готово!** 🎉 Теперь ваш сайт доступен в России без VPN через Railway.
