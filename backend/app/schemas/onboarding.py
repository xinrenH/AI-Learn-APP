from pydantic import BaseModel, Field


class GoalParseRequest(BaseModel):
    text: str = Field(min_length=5, description='用户输入的目标描述')


class GoalParseResponse(BaseModel):
    goal: str
    period_days: int
    daily_hours: float
    preference: str
    level: str
