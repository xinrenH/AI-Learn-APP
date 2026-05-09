from app.schemas.onboarding import GoalParseResponse


def parse_goal_text(text: str) -> GoalParseResponse:
    # TODO: 替换为 LangChain + 模型结构化抽取
    return GoalParseResponse(
        goal='证券从业资格证',
        period_days=30,
        daily_hours=3,
        preference='video',
        level='beginner',
    )
