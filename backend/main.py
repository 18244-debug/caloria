from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import google.generativeai as genai
import os
import shutil

app = FastAPI(title="CalorIA Backend")

# Permitir conexões do telemóvel/emulador
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configura aqui a tua chave da API do Gemini (ou podes usar variáveis de ambiente)
# Podes obter uma chave gratuita no Google AI Studio
GEMINI_API_KEY = "AQ.Ab8RN6JLaOFrmpjZFqE32mqPfR8aLCGh12ZVkKpB0rlDoBCIA"

if GEMINI_API_KEY != "COLOCA_AQUI_A_TUA_CHAVE_GEMINI":
    genai.configure(api_key=GEMINI_API_KEY)

@app.get("/")
def read_root():
    return {"message": "Bem-vindo ao Backend da CalorIA!"}

@app.post("/analyze-food/")
async def analyze_food(file: UploadFile = File(...)):
    if GEMINI_API_KEY == "COLOCA_AQUI_A_TUA_CHAVE_GEMINI":
        raise HTTPException(status_code=500, detail="Chave da API do Gemini não configurada no backend.")

    try:
        # Guardar temporariamente a imagem recebida
        temp_file_path = f"temp_{file.filename}"
        with open(temp_file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        # Enviar para o Google Gemini analisar
        # Usamos o modelo multimodal gemini-1.5-flash
        model = genai.GenerativeModel('gemini-1.5-flash')

        sample_file = genai.upload_file(path=temp_file_path, display_name="Prato Tradicional")

        prompt = """
        Analisa esta imagem de comida tradicional portuguesa.
        Identifica o prato, estima o total de calorias e os macronutrientes (proteínas, hidratos de carbono e gorduras)
        e dá uma breve recomendação/nota nutricional.
        Devolve a resposta estritamente num formato JSON limpo com as seguintes chaves:
        {
          "dish_name": "Nome do Prato",
          "calories": 000,
          "protein": "00g",
          "carbs": "00g",
          "fat": "00g",
          "advice": "Dica nutricional curta"
        }
        """

        response = model.generate_content([sample_file, prompt])

        # Limpar o ficheiro temporário local e da nuvem do Gemini
        os.remove(temp_file_path)
        genai.delete_file(sample_file.name)

        return {"result": response.text}

    except Exception as e:
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)
        raise HTTPException(status_code=500, detail=str(e))