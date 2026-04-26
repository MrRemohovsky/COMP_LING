### Сборка образа
docker build -t golos-asr .

### Сохранить образ
docker save golos-asr -o golos-asr.tar

### Загрузить образ на другом устройстве
docker load -i golos-asr.tar

### Запустить
docker run -p 8000:8000 golos-asr