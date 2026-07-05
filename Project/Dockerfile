FROM ghcr.io/astral-sh/uv:python3.14-bookworm-slim AS builder

WORKDIR /app

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV UV_PROJECT_ENVIRONMENT=/app/.venv

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev --no-install-project

COPY src ./src


FROM gcr.io/distroless/cc-debian12:nonroot AS runtime

WORKDIR /app

ENV PATH=/app/.venv/bin:/usr/local/bin
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

COPY --from=builder /usr/local /usr/local
COPY --from=builder --chown=nonroot:nonroot /app/.venv /app/.venv
COPY --from=builder --chown=nonroot:nonroot /app/src /app/src

EXPOSE 8000

USER nonroot:nonroot

CMD ["/app/.venv/bin/python", "-m", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
