from pydantic import BaseModel, Field


class StudyTask(BaseModel):
    task_id: str
    day: int
    type: str
    title: str
    duration_minutes: int
    resource_id: str
    completed: bool = False


class PlanGenerateRequest(BaseModel):
    goal: str
    period_days: int = Field(ge=1, le=365)
    daily_hours: float = Field(gt=0, le=12)
    level: str = 'beginner'
    preference: str = 'video'


class PlanGenerateResponse(BaseModel):
    goal: str
    period_days: int
    daily_hours: float
    difficulty: str
    tasks: list[StudyTask]
    review_strategy: str
