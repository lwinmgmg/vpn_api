from fastapi import APIRouter

DEFAULT_TAG = "API"

router = APIRouter(prefix="/api", tags=[DEFAULT_TAG])
