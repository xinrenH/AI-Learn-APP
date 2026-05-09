from fastapi import APIRouter

from app.schemas.common import fail, success
from app.schemas.plan import PlanGenerateRequest
from app.services.plan.generator import generate_plan
from app.services.plan.store import plan_store

router = APIRouter()


@router.post('/generate')
def plan_generate(payload: PlanGenerateRequest) -> dict:
    result = generate_plan(payload)
    plan_store.save(result)
    return success(result.model_dump())


@router.get('/today')
def plan_today() -> dict:
    plan = plan_store.get_today()
    if plan is None:
        return fail('暂无计划，请先生成计划', 2001)
    return success(plan.model_dump())
