from app.schemas.plan import PlanGenerateRequest, PlanGenerateResponse, StudyTask


def generate_plan(payload: PlanGenerateRequest) -> PlanGenerateResponse:
    # TODO: 替换为 LangChain 编排 + JSON Schema 校验 + 兜底
    tasks = [
        StudyTask(
            day=1,
            type='video',
            title=f'{payload.goal} - 基础导学',
            duration_minutes=90,
            resource_id='res_1001',
        ),
        StudyTask(
            day=1,
            type='practice',
            title='章节小测',
            duration_minutes=30,
            resource_id='res_2001',
        ),
    ]
    return PlanGenerateResponse(
        goal=payload.goal,
        period_days=payload.period_days,
        daily_hours=payload.daily_hours,
        difficulty=payload.level,
        tasks=tasks,
        review_strategy='每3天一次小测',
    )
