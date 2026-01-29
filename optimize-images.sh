#!/bin/bash

# Скрипт для оптимизации изображений
# Требует установки: brew install imagemagick

echo "🖼️  Оптимизация изображений..."

# Создаем резервную копию
if [ ! -d "public/images-backup" ]; then
    echo "📦 Создаем резервную копию..."
    cp -r public/images public/images-backup
fi

# Оптимизируем все JPG в public/images
find public/images -type f \( -name "*.jpg" -o -name "*.jpeg" \) | while read file; do
    echo "Оптимизация: $file"
    
    # Получаем размер до
    size_before=$(du -h "$file" | cut -f1)
    
    # Оптимизация: уменьшаем качество до 75%, resize если больше 1200px по ширине
    magick "$file" -strip -quality 75 -resize '1200x1200>' "$file.tmp"
    
    # Заменяем оригинал
    mv "$file.tmp" "$file"
    
    # Получаем размер после
    size_after=$(du -h "$file" | cut -f1)
    
    echo "  ✓ $size_before → $size_after"
done

echo "✅ Оптимизация завершена!"
echo "📊 Проверьте размер: du -sh public/images/"
