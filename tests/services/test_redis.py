import pytest
from vpn_api.env.settings import get_settings
from vpn_api.services.redis import get_redis

@pytest.fixture
def settings():
    return get_settings()

@pytest.mark.asyncio
async def test_get_redis(settings):
    for _ in range(settings.redis_pool_size + 1):
        async for conn in  get_redis():
            await conn.ping()