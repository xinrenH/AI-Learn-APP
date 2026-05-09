from app.tasks.celery_app import celery_app


@celery_app.task(name='tasks.heartbeat')
def heartbeat() -> str:
    return 'ok'
