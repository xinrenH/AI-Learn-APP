from fastapi import APIRouter

from app.schemas.common import success
from app.schemas.onboarding import GoalParseRequest
from app.services.ai.intent_parser import parse_goal_text

router = APIRouter()


@router.post('/goal-parse')
def goal_parse(payload: GoalParseRequest) -> dict:
    result = parse_goal_text(payload.text)
    return success(result.model_dump())
