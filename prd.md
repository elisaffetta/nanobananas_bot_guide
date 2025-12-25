# 📋 ТЕХНИЧЕСКОЕ ЗАДАНИЕ: ГАЙД ПО НЕЙРОФОТОСЕССИЯМ

## Для реализации в Windsurf IDE с Astro

---

## 🎯 ОБЩЕЕ ОПИСАНИЕ ПРОЕКТА

**Название:** Гайд по нейрофотосессиям с Nano Banana  
**Технологии:** Astro, shadcn/ui, TypeScript/JavaScript  
**Стиль:** macOS-inspired дизайн с современной неоновой эстетикой  
**Цель:** Создать красивый, быстрый и удобный одностраничный гайд с навигацией

---

## 📐 АРХИТЕКТУРА И СТРУКТУРА

### Файловая структура Astro:
```
src/
├── pages/
│   └── index.astro           # Главная страница
├── components/
│   ├── Navigation.astro      # Боковое меню
│   ├── ThemeToggle.astro     # Переключатель темы
│   ├── PromptCard.astro      # Карточка промта
│   ├── SectionHeader.astro   # Заголовок секции
│   └── TableOfContents.astro # Оглавление (TOC)
├── layouts/
│   └── MainLayout.astro      # Основной layout
├── styles/
│   └── global.css            # Глобальные стили
└── content/
    └── guide.md              # Контент гайда (опционально)

public/
└── images/
    └── results/              # Папка для результатов генераций
        ├── prompt-1.jpg
        ├── prompt-2.jpg
        └── ...
```

---

## 🎨 ДИЗАЙН И UI/UX

### Цветовая палитра

#### Светлая тема:
```css
--background: #ffffff;
--foreground: #0a0a0a;
--card: #f8f9fa;
--card-foreground: #0a0a0a;

/* Акцентные цвета */
--primary: #ffd60a;        /* Нежно-желтый (основной акцент) */
--primary-foreground: #0a0a0a;
--secondary: #ffc300;      /* Золотистый */
--accent: #ffb700;         /* Желто-оранжевый */

/* Границы и разделители */
--border: #e5e7eb;
--muted: #f3f4f6;
--muted-foreground: #6b7280;
```

#### Темная тема:
```css
--background: #0a0a0a;
--foreground: #fafafa;
--card: #141414;
--card-foreground: #fafafa;

/* Акцентные цвета */
--primary: #ffd60a;        /* Нежно-желтый (сохраняется) */
--primary-foreground: #0a0a0a;
--neon-blue: #00d4ff;      /* Неоновый синий */
--neon-purple: #b800ff;    /* Неоновый фиолетовый */
--neon-pink: #ff006e;      /* Неоновый розовый */
--accent: #00d4ff;         /* Основной неон - синий */

/* Границы и разделители */
--border: #27272a;
--muted: #18181b;
--muted-foreground: #a1a1aa;
```

### Использование неона в темной теме:
- **Заголовки H1:** Градиент от neon-blue до neon-purple
- **Активный пункт меню:** neon-pink подсветка
- **Кнопки copy:** neon-blue hover эффект
- **Линки:** neon-purple с hover на neon-pink
- **Акценты:** Желтый для важных элементов

---

### Типографика (macOS-inspired):
```css
--font-sans: -apple-system, BlinkMacSystemFont, "SF Pro Display", 
             "Segoe UI", Roboto, sans-serif;
--font-mono: "SF Mono", Menlo, Monaco, "Courier New", monospace;

/* Размеры */
--text-xs: 0.75rem;    /* 12px */
--text-sm: 0.875rem;   /* 14px */
--text-base: 1rem;     /* 16px */
--text-lg: 1.125rem;   /* 18px */
--text-xl: 1.25rem;    /* 20px */
--text-2xl: 1.5rem;    /* 24px */
--text-3xl: 1.875rem;  /* 30px */
--text-4xl: 2.25rem;   /* 36px */

/* Межстрочный интервал */
--leading-relaxed: 1.625;
--leading-loose: 2;
```

---

### Компоненты shadcn/ui для использования:
1. **Button** — для кнопок копирования промтов
2. **Card** — для карточек промтов
3. **Separator** — для разделителей секций
4. **ScrollArea** — для навигационного меню
5. **Badge** — для тегов (женские/мужские/детские)
6. **Toggle** — для переключателя темы
7. **Tooltip** — для подсказок

---

## 🧭 НАВИГАЦИЯ И СТРУКТУРА СТРАНИЦЫ

### Макет страницы:

```
┌─────────────────────────────────────────────────────┐
│  Header: Logo | "Гайд" | Theme Toggle               │
├──────────────┬──────────────────────────────────────┤
│              │                                      │
│  Sidebar     │  Main Content                        │
│  (TOC)       │  - Intro                             │
│  [Скрывается]│  - Кейсы                             │
│              │  - Правила                           │
│  • Intro     │  - Промты (женские/мужские/детские) │
│  • Кейсы     │  - О нас                             │
│  • Правила   │  - Заключение                        │
│  • Промты    │                                      │
│    - Женские │                                      │
│    - Мужские │                                      │
│    - Детские │                                      │
│  • О нас     │                                      │
│              │                                      │
└──────────────┴──────────────────────────────────────┘
│  Footer: © 2025 | @nanobananas_bot                  │
└─────────────────────────────────────────────────────┘
```

### Поведение Sidebar:
- **Desktop (>1024px):** Всегда видна, фиксированная слева (240px ширина)
- **Tablet (768-1024px):** Скрывается, открывается через кнопку-гамбургер
- **Mobile (<768px):** Скрывается, открывается через кнопку-гамбургер

### Smooth scroll к секциям:
```javascript
// При клике на пункт меню
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute('href'));
    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
});
```

### Активный пункт меню при скролле:
```javascript
// Intersection Observer для подсветки активной секции
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('nav a');

const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      navLinks.forEach(link => link.classList.remove('active'));
      const activeLink = document.querySelector(`nav a[href="#${entry.target.id}"]`);
      activeLink?.classList.add('active');
    }
  });
}, { threshold: 0.3 });

sections.forEach(section => observer.observe(section));
```

---

## 📝 КАРТОЧКА ПРОМТА (PromptCard.astro)

### Структура компонента:

```astro
---
interface Props {
  number: number;
  title: string;
  prompt: string;
  description?: string;
  category: 'women' | 'men' | 'kids';
  imagePath?: string;
}

const { number, title, prompt, description, category, imagePath } = Astro.props;
---

<div class="prompt-card">
  <div class="prompt-header">
    <div class="prompt-number">#{number}</div>
    <h3 class="prompt-title">{title}</h3>
    <button class="copy-button" data-prompt={prompt}>
      📋 Копировать
    </button>
  </div>
  
  {description && (
    <p class="prompt-description">{description}</p>
  )}
  
  <div class="prompt-content">
    <pre class="prompt-text">{prompt}</pre>
  </div>
  
  {imagePath && (
    <div class="prompt-result">
      <p class="result-label">Результат:</p>
      <img 
        src={imagePath} 
        alt={`Результат: ${title}`}
        loading="lazy"
        class="result-image"
      />
    </div>
  )}
  
  {!imagePath && (
    <div class="prompt-result-placeholder">
      <p class="placeholder-text">🖼️ Место для фото результата</p>
      <p class="placeholder-hint">
        Загрузите изображение в: 
        <code>/public/images/results/prompt-{number}.jpg</code>
      </p>
    </div>
  )}
</div>

<script>
  // Копирование промта в буфер обмена
  document.querySelectorAll('.copy-button').forEach(button => {
    button.addEventListener('click', async () => {
      const prompt = button.getAttribute('data-prompt');
      await navigator.clipboard.writeText(prompt);
      
      // Визуальная обратная связь
      const originalText = button.textContent;
      button.textContent = '✅ Скопировано!';
      button.classList.add('copied');
      
      setTimeout(() => {
        button.textContent = originalText;
        button.classList.remove('copied');
      }, 2000);
    });
  });
</script>

<style>
  .prompt-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    transition: all 0.2s ease;
  }
  
  .prompt-card:hover {
    border-color: var(--accent);
    box-shadow: 0 4px 20px rgba(0, 212, 255, 0.1);
  }
  
  .prompt-header {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 1rem;
  }
  
  .prompt-number {
    background: var(--primary);
    color: var(--primary-foreground);
    padding: 0.25rem 0.75rem;
    border-radius: 6px;
    font-weight: 600;
    font-size: var(--text-sm);
  }
  
  .prompt-title {
    flex: 1;
    font-size: var(--text-lg);
    font-weight: 600;
    margin: 0;
  }
  
  .copy-button {
    background: transparent;
    border: 1px solid var(--border);
    padding: 0.5rem 1rem;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s;
    font-size: var(--text-sm);
  }
  
  .copy-button:hover {
    background: var(--accent);
    border-color: var(--accent);
    transform: translateY(-2px);
  }
  
  .copy-button.copied {
    background: #10b981;
    border-color: #10b981;
    color: white;
  }
  
  .prompt-content {
    background: var(--muted);
    border-radius: 8px;
    padding: 1rem;
    margin-bottom: 1rem;
  }
  
  .prompt-text {
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    line-height: var(--leading-relaxed);
    margin: 0;
    white-space: pre-wrap;
    word-wrap: break-word;
  }
  
  .result-image {
    width: 100%;
    max-width: 400px;
    border-radius: 8px;
    margin-top: 0.5rem;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  }
  
  .prompt-result-placeholder {
    background: var(--muted);
    border: 2px dashed var(--border);
    border-radius: 8px;
    padding: 2rem;
    text-align: center;
  }
  
  .placeholder-text {
    font-size: var(--text-lg);
    margin-bottom: 0.5rem;
  }
  
  .placeholder-hint {
    font-size: var(--text-sm);
    color: var(--muted-foreground);
  }
  
  .placeholder-hint code {
    background: var(--background);
    padding: 0.2rem 0.5rem;
    border-radius: 4px;
    font-family: var(--font-mono);
    font-size: var(--text-xs);
  }
  
  /* Темная тема - неоновые акценты */
  [data-theme="dark"] .prompt-card:hover {
    box-shadow: 0 4px 20px rgba(0, 212, 255, 0.3);
  }
  
  [data-theme="dark"] .copy-button:hover {
    box-shadow: 0 0 15px var(--neon-blue);
  }
</style>
```

---

## 🔄 ПЕРЕКЛЮЧАТЕЛЬ ТЕМЫ (ThemeToggle.astro)

```astro
<button id="theme-toggle" class="theme-toggle" aria-label="Переключить тему">
  <span class="sun-icon">☀️</span>
  <span class="moon-icon">🌙</span>
</button>

<script>
  const themeToggle = document.getElementById('theme-toggle');
  const htmlElement = document.documentElement;
  
  // Загрузка сохраненной темы
  const savedTheme = localStorage.getItem('theme') || 'light';
  htmlElement.setAttribute('data-theme', savedTheme);
  
  // Переключение темы
  themeToggle?.addEventListener('click', () => {
    const currentTheme = htmlElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    
    htmlElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
  });
</script>

<style>
  .theme-toggle {
    position: relative;
    width: 60px;
    height: 32px;
    background: var(--muted);
    border: 1px solid var(--border);
    border-radius: 16px;
    cursor: pointer;
    transition: all 0.3s ease;
  }
  
  .theme-toggle:hover {
    background: var(--accent);
  }
  
  .sun-icon,
  .moon-icon {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    font-size: 18px;
    transition: all 0.3s ease;
  }
  
  .sun-icon {
    left: 8px;
  }
  
  .moon-icon {
    right: 8px;
    opacity: 0.3;
  }
  
  [data-theme="dark"] .sun-icon {
    opacity: 0.3;
  }
  
  [data-theme="dark"] .moon-icon {
    opacity: 1;
  }
</style>
```

---

## 📱 АДАПТИВНОСТЬ

### Breakpoints:
```css
/* Mobile First подход */
/* Mobile: 320-767px (базовые стили) */
/* Tablet: 768-1023px */
@media (min-width: 768px) { ... }

/* Desktop: 1024px+ */
@media (min-width: 1024px) { ... }

/* Large Desktop: 1440px+ */
@media (min-width: 1440px) { ... }
```

### Адаптивные правила:

#### Mobile (<768px):
- Sidebar скрыта, открывается через гамбургер
- Промпты отображаются в одну колонку
- Изображения результатов — 100% ширины
- Padding контейнеров: 1rem
- Уменьшенные заголовки (text-2xl → text-xl)

#### Tablet (768-1023px):
- Sidebar скрывается, но легко открывается
- Промпты — 1 колонка
- Изображения — max-width 500px, центрированы
- Padding контейнеров: 1.5rem

#### Desktop (1024px+):
- Sidebar всегда видна слева (240px)
- Основной контент — max-width 800px, центрирован
- Изображения — max-width 400px
- Padding контейнеров: 2rem

---

## ⚡ ПРОИЗВОДИТЕЛЬНОСТЬ И ОПТИМИЗАЦИЯ

### 1. Lazy loading изображений:
```html
<img 
  src="/images/results/prompt-1.jpg" 
  loading="lazy"
  decoding="async"
  alt="Результат генерации"
/>
```

### 2. Astro оптимизация:
```javascript
// astro.config.mjs
export default defineConfig({
  output: 'static',
  build: {
    inlineStylesheets: 'auto',
  },
  vite: {
    build: {
      cssCodeSplit: true,
      minify: 'terser',
    },
  },
});
```

### 3. Минимизация CSS:
- Использовать CSS переменные
- Избегать дублирования стилей
- Группировать media queries

### 4. Оптимизация шрифтов:
```css
/* Preload важных шрифтов */
<link rel="preload" href="/fonts/sf-pro.woff2" as="font" type="font/woff2" crossorigin>
```

---

## 🔍 SEO ОПТИМИЗАЦИЯ

### Meta теги (в MainLayout.astro):
```html
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- Primary Meta Tags -->
  <title>Нейрофотосессия: Полный гайд 2025 | Nano Banana AI</title>
  <meta name="title" content="Нейрофотосессия: Полный гайд 2025 | Nano Banana AI">
  <meta name="description" content="Превратите обычное селфи в профессиональное фото за 30 секунд. 100 готовых промтов для женщин, мужчин и детей. Без фотографа, от 21₽.">
  <meta name="keywords" content="нейрофотосессия, nano banana, нейросеть для фото, промпты, ai фото, генерация изображений">
  
  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://ваш-домен.ru/">
  <meta property="og:title" content="Нейрофотосессия: Полный гайд 2025">
  <meta property="og:description" content="100 готовых промтов для создания профессиональных фото с ИИ">
  <meta property="og:image" content="https://ваш-домен.ru/og-image.jpg">
  
  <!-- Twitter -->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:url" content="https://ваш-домен.ru/">
  <meta property="twitter:title" content="Нейрофотосессия: Полный гайд 2025">
  <meta property="twitter:description" content="100 готовых промтов для создания профессиональных фото с ИИ">
  <meta property="twitter:image" content="https://ваш-домен.ru/og-image.jpg">
  
  <!-- Favicon -->
  <link rel="icon" type="image/svg+xml" href="/favicon.svg">
  
  <!-- Canonical URL -->
  <link rel="canonical" href="https://ваш-домен.ru/">
</head>
```

### Структурированные данные (JSON-LD):
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "Как создать профессиональное фото с помощью нейросети",
  "description": "Полный гайд по нейрофотосессиям с 100 готовыми промтами",
  "image": "https://ваш-домен.ru/og-image.jpg",
  "totalTime": "PT30S",
  "estimatedCost": {
    "@type": "MonetaryAmount",
    "currency": "RUB",
    "value": "21"
  },
  "tool": [
    {
      "@type": "HowToTool",
      "name": "Nano Banana AI бот"
    }
  ],
  "step": [
    {
      "@type": "HowToStep",
      "name": "Откройте бот",
      "text": "Откройте @nanobananas_bot в Telegram"
    },
    {
      "@type": "HowToStep",
      "name": "Загрузите фото",
      "text": "Загрузите своё фото в бот"
    },
    {
      "@type": "HowToStep",
      "name": "Скопируйте промт",
      "text": "Выберите и скопируйте промт из гайда"
    },
    {
      "@type": "HowToStep",
      "name": "Получите результат",
      "text": "Через 30 секунд получите профессиональное фото"
    }
  ]
}
</script>
```

### Семантическая разметка:
```html
<article>
  <header>
    <h1>Нейрофотосессия: Полный гайд</h1>
  </header>
  
  <section id="intro">
    <h2>Что такое нейрофотосессия</h2>
    <!-- контент -->
  </section>
  
  <section id="prompts-women">
    <h2>Женские промты</h2>
    <!-- промты -->
  </section>
  
  <footer>
    <p>© 2025 Nano Banana AI</p>
  </footer>
</article>
```

---

## 🤖 GEO ОПТИМИЗАЦИЯ (AI Search)

### 1. Четкая структура контента:
- Используйте семантические HTML5 теги
- Заголовки H1-H6 в логической иерархии
- Списки для перечислений (ul, ol)
- Таблицы для табличных данных

### 2. Естественный язык:
- Пишите как для человека, не для робота
- Используйте вопросы в заголовках: "Зачем нужна нейрофотосессия?"
- Давайте четкие ответы сразу после вопроса

### 3. FAQ секция:
```html
<section id="faq" itemscope itemtype="https://schema.org/FAQPage">
  <h2>Частые вопросы</h2>
  
  <div itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
    <h3 itemprop="name">Сколько стоит одна нейрофотосессия?</h3>
    <div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
      <div itemprop="text">
        От 21₽ за одно фото в обычной версии Nano Banana.
      </div>
    </div>
  </div>
  
  <!-- больше вопросов -->
</section>
```

### 4. Breadcrumbs:
```html
<nav aria-label="Breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
  <ol>
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a itemprop="item" href="/">
        <span itemprop="name">Главная</span>
      </a>
      <meta itemprop="position" content="1" />
    </li>
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <span itemprop="name">Гайд по нейрофотосессиям</span>
      <meta itemprop="position" content="2" />
    </li>
  </ol>
</nav>
```

---

## 📦 ФИНАЛЬНЫЙ ЧЕКЛИСТ ДЛЯ WINDSURF

### ✅ Обязательные компоненты:

**Layout и структура:**
- [ ] MainLayout.astro с header/footer
- [ ] Navigation.astro (боковое меню с TOC)
- [ ] ThemeToggle.astro (светлая/темная тема)
- [ ] Responsive sidebar (скрывается на mobile)

**Компоненты контента:**
- [ ] PromptCard.astro (с кнопкой копирования)
- [ ] SectionHeader.astro
- [ ] Badge компонент для категорий (женские/мужские/детские)
- [ ] Separator между секциями

**Функционал:**
- [ ] Smooth scroll к секциям
- [ ] Подсветка активного пункта меню при скролле
- [ ] Копирование промта в буфер обмена (с анимацией)
- [ ] Сохранение темы в localStorage
- [ ] Lazy loading изображений

**Стили:**
- [ ] CSS переменные для цветов (светлая/темная тема)
- [ ] macOS-inspired типографика
- [ ] Неоновые акценты в темной теме
- [ ] Нежно-желтый акцент в обеих темах
- [ ] Адаптивность (mobile/tablet/desktop)

**SEO и производительность:**
- [ ] Meta теги (Open Graph, Twitter Card)
- [ ] Structured Data (JSON-LD)
- [ ] Semantic HTML5
- [ ] Оптимизированные изображения
- [ ] Минифицированный CSS/JS

**Удобство:**
- [ ] Понятная структура папок для загрузки изображений
- [ ] Плейсхолдеры с подсказками где загружать фото
- [ ] Tooltips для подсказок
- [ ] Smooth transitions и hover эффекты

---

## 🎨 ПРИМЕРЫ СТИЛЕЙ

### Заголовок H1 с неоном (темная тема):
```css
[data-theme="dark"] h1 {
  background: linear-gradient(135deg, var(--neon-blue), var(--neon-purple));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: glow 3s ease-in-out infinite alternate;
}

@keyframes glow {
  from {
    filter: drop-shadow(0 0 20px var(--neon-blue));
  }
  to {
    filter: drop-shadow(0 0 30px var(--neon-purple));
  }
}
```

### Активный пункт меню:
```css
nav a.active {
  color: var(--primary);
  border-left: 3px solid var(--primary);
  padding-left: 0.75rem;
}

[data-theme="dark"] nav a.active {
  color: var(--neon-pink);
  border-left-color: var(--neon-pink);
  text-shadow: 0 0 10px var(--neon-pink);
}
```

### Hover эффекты на кнопках:
```css
.copy-button {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.copy-button:hover {
  transform: translateY(-2px);
}

[data-theme="dark"] .copy-button:hover {
  box-shadow: 0 0 20px var(--neon-blue),
              0 0 40px var(--neon-blue);
}
```
