from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse

from app.api.v1.router import api_router
from app.core.config import settings
from app.schemas.common import fail


def create_app() -> FastAPI:
    app = FastAPI(title=settings.APP_NAME, debug=settings.APP_DEBUG)
    app.include_router(api_router, prefix='/api/v1')

    @app.get('/healthz', tags=['system'])
    def healthz() -> dict[str, str]:
        return {'status': 'ok'}

    @app.exception_handler(RequestValidationError)
    async def validation_exception_handler(
        request: Request,
        exc: RequestValidationError,
    ) -> JSONResponse:
        _ = request
        return JSONResponse(status_code=422, content=fail('请求参数校验失败', 1001))

    @app.exception_handler(Exception)
    async def global_exception_handler(request: Request, exc: Exception) -> JSONResponse:
        _ = request
        _ = exc
        return JSONResponse(status_code=500, content=fail('服务内部异常', 1000))

    return app


app = create_app()
