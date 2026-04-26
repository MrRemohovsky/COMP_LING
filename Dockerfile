FROM nvcr.io/nvidia/nemo:22.05

WORKDIR /app

RUN pip install fastapi uvicorn python-multipart

RUN wget --timeout=300 https://huggingface.co/Den4ikAI/QuartzNet15x5_golos_nemo/resolve/main/QuartzNet15x5_golos_nemo.nemo

COPY server.py .

EXPOSE 8000

CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8000"]
