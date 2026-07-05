from fastapi import FastAPI

from src.routes import router


app = FastAPI(
    title="Vanilla K8s Lab API",
    description="Simple API for Kubernetes infrastructure studies",
    version="0.1.0",
)

app.include_router(router)
