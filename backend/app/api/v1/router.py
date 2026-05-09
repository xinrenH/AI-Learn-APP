from fastapi import APIRouter

from app.api.v1 import onboarding, plan

api_router = APIRouter()
api_router.include_router(onboarding.router, prefix='/onboarding', tags=['onboarding'])
api_router.include_router(plan.router, prefix='/plan', tags=['plan'])
