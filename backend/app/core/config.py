from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file='.env', env_file_encoding='utf-8', extra='ignore')

    APP_NAME: str = 'zhiyu-xuetu-backend'
    APP_ENV: str = 'dev'
    APP_DEBUG: bool = True
    APP_HOST: str = '0.0.0.0'
    APP_PORT: int = 8000

    DATABASE_URL: str = 'mysql+pymysql://root:root@127.0.0.1:3306/zhiyu_xuetu'
    REDIS_URL: str = 'redis://127.0.0.1:6379/0'

    AI_PROVIDER: str = 'openai_compatible'
    AI_BASE_URL: str = ''
    AI_API_KEY: str = ''
    AI_MODEL: str = 'gpt-4o-mini'


settings = Settings()
