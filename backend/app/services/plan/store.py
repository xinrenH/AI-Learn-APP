from threading import Lock

from app.schemas.plan import PlanGenerateResponse


class InMemoryPlanStore:
    def __init__(self) -> None:
        self._lock = Lock()
        self._plan: PlanGenerateResponse | None = None

    def save(self, plan: PlanGenerateResponse) -> None:
        with self._lock:
            self._plan = plan

    def get_today(self) -> PlanGenerateResponse | None:
        with self._lock:
            return self._plan


plan_store = InMemoryPlanStore()
