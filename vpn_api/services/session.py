from functools import lru_cache
from sqlalchemy.ext.asyncio import async_sessionmaker
from .engine import engine

async_session = async_sessionmaker(engine)

async def get_async_session():
    async with async_session() as session:
        yield session
