import pytest
from sqlalchemy import text
from vpn_api.services.session import get_async_session

@pytest.mark.asyncio
async def test_get_async_session():
    async for session in get_async_session():
        res = await session.execute(text("SELECT 1;"))
