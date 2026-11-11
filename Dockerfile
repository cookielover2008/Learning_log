
# Официальный облегчённый образ Python
FROM python:3.12-slim

# Настройки Python
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Рабочая папка
WORKDIR /app

# Установка зависимостей
COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

# Копирование проекта
COPY . .

# Каталог для базы данных
RUN mkdir -p /app/data

# Порт приложения
EXPOSE 8000

# Миграции, сборка статики и запуск Gunicorn
CMD ["sh", "-c", "python manage.py migrate --noinput && python manage.py collectstatic --noinput && exec gunicorn learning_log.wsgi:application --bind 0.0.0.0:8000 --workers 2 --timeout 60"]
