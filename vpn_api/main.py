from fastapi import FastAPI
from vpn_api.api.router import router

app = FastAPI()
app.include_router(router=router)
