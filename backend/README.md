# Backend - zhiyu xuetu

## 1. 环境准备

- Python 3.11+
- MySQL 8.0
- Redis 7.x

## 2. 安装依赖

```bash
cd backend
python -m venv .venv
.venv\\Scripts\\activate
pip install -r requirements.txt
copy .env.example .env
```

## 3. 启动 API

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

接口：

- `GET /healthz`
- `POST /api/v1/onboarding/goal-parse`
- `POST /api/v1/plan/generate`

## 4. 启动 Celery

```bash
celery -A app.tasks.celery_app:celery_app worker -l info
```

## 5. 下一步

- 接入 LangChain 结构化输出
- 加入 Alembic 数据库迁移
- 接入真实登录与计划持久化
