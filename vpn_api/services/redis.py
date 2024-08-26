from functools import lru_cache
import redis.asyncio as redis
from vpn_api.env.settings import get_settings

MAX_REDIS_POOL_SIZE = 5

settings = get_settings()


@lru_cache
def get_connection_pool():
    return redis.ConnectionPool(
        host=settings.redis_host,
        port=settings.redis_port,
        username=settings.redis_user,
        password=settings.redis_password,
        max_connections=settings.redis_pool_size,
    )


async def get_redis():
    connection_pool = get_connection_pool()
    client = redis.Redis(connection_pool=connection_pool)
    yield client
    await client.aclose()
