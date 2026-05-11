# Backend - zhiyu xuetu

## 1. 环境准备

- Python 3.11+
- MySQL 8.0（当前可选，无数据库模式可先不启）
- Redis 7.x（当前可选）

## 2. 安装依赖

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
copy .env.example .env
```

## 3. 启动 API

### 3.1 稳定模式（默认推荐）

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

### 3.2 开发热重载模式（可选）

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

说明：Windows 下 `--reload` 偶发子进程残留，若出现无法退出可先用稳定模式。

接口：

- `GET /healthz`
- `POST /api/v1/onboarding/goal-parse`
- `POST /api/v1/plan/generate`
- `GET /api/v1/plan/today`
- `POST /api/v1/plan/tasks/{task_id}/complete`

## 4. 启动 Celery（可选）

```bash
celery -A app.tasks.celery_app:celery_app worker -l info
```

## 5. 进程清理（Windows）

### 按命令关键字清理 uvicorn

```powershell
Get-CimInstance Win32_Process |
Where-Object { $_.CommandLine -like "*uvicorn app.main:app*" } |
ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
```

### 按端口清理（8000）

```powershell
$pid = (Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue).OwningProcess
if ($pid) { Stop-Process -Id $pid -Force }
```

## 6. 下一步

- 接入 LangChain 结构化输出
- 加入 Alembic 数据库迁移
- 接入真实登录与计划持久化
