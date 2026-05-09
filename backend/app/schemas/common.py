from uuid import uuid4

from pydantic import BaseModel


class ApiResponse(BaseModel):
    code: int = 0
    message: str = 'ok'
    trace_id: str
    data: dict | list | str | int | float | bool | None


def success(data: dict | list | str | int | float | bool | None, message: str = 'ok') -> dict:
    return {
        'code': 0,
        'message': message,
        'trace_id': uuid4().hex,
        'data': data,
    }


def fail(message: str, code: int = 1000) -> dict:
    return {
        'code': code,
        'message': message,
        'trace_id': uuid4().hex,
        'data': None,
    }
