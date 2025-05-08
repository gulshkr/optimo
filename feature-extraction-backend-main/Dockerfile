FROM python:3.12-slim

WORKDIR /app

# Install poetry and configure
RUN pip install --upgrade pip && \
    pip install poetry
RUN poetry config virtualenvs.create false

# Copy dependency files first for better caching
COPY pyproject.toml poetry.lock* ./

# Install dependencies without installing the project itself
RUN poetry install --only main --no-interaction --no-ansi --no-root

# Copy application code
COPY . .

EXPOSE 8000
CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0"]