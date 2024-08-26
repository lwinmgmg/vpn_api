from functools import lru_cache
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    postgres_host: str = "localhost"
    postgres_port: int = 5432
    postgres_user: str = "postgres"
    postgres_password: str = ""
    postgres_db: str = "mrs"
    model_config = SettingsConfigDict(env_file=".env")

    # Redis
    redis_host: str = "localhost"
    redis_port: int = 6379
    redis_db: int = 0
    redis_user: str = ""
    redis_password: str = ""
    redis_pool_size: int = 5


@lru_cache
def get_settings():
    return Settings()
