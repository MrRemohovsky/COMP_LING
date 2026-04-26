FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Системные зависимости
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    ffmpeg \
    python3-pip \
    wget \
    sox \
    libsox-fmt-all \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Фиксы версий (чтобы избежать ошибок установки NeMo)
RUN python3 -m pip install testresources
RUN python3 -m pip install typing_extensions
RUN python3 -m pip install setuptools==59.5.0
RUN python3 -m pip install numpy==1.21.1
RUN python3 -m pip install click==7.1.2
RUN python3 -m pip install Cython

# Установка NeMo ASR
RUN pip install --no-cache-dir --timeout=1000 nemo_toolkit[asr]
# Установка FastAPI и сервера
RUN pip install fastapi uvicorn python-multipart

# Скачиваем модель
RUN wget https://huggingface.co/Den4ikAI/QuartzNet15x5_golos_nemo/resolve/main/QuartzNet15x5_golos_nemo.nemo

# Копируем код сервера
COPY server.py .

EXPOSE 8000

CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8000"]
