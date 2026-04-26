import os
import tempfile

from fastapi import FastAPI, UploadFile, File
import nemo.collections.asr as nemo_asr

app = FastAPI()

print("Загружаем модель...")
MODEL_PATH = "QuartzNet15x5_golos_nemo.nemo"
asr_model = nemo_asr.models.EncDecCTCModel.restore_from(MODEL_PATH)


@app.post("/get_text_from_voice/")
async def recognize(file: UploadFile = File(...)):
    with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as tmp:
        tmp.write(await file.read())
        tmp_path = tmp.name

    try:
        transcripts = asr_model.transcribe([tmp_path], batch_size=1)
        text = transcripts[0] if transcripts else ""
    finally:
        os.remove(tmp_path)

    return {"text": text}
