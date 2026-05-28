# Base image: Microsoft Dev Containers Python 3.13 (used by GitHub Codespaces)
FROM mcr.microsoft.com/devcontainers/python:3.13-bullseye

# OCI labels for GitHub Container Registry
LABEL org.opencontainers.image.source=https://github.com/nordquant/complete-dbt-bootcamp-zero-to-hero
LABEL org.opencontainers.image.description="dbt Zero to Hero Development Container"

# Install UV as root into /usr/local/bin
ENV UV_INSTALL_DIR="/usr/local/bin"
RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && chmod a+rx /usr/local/bin/uv /usr/local/bin/uvx

# Tell UV to use system Python (no virtualenv) and treat /usr/local as the
# project environment so `uv sync` / `uv add` / `uv run` from any shell
# reuse the prebuilt site-packages instead of creating .venv/ in the workspace.
ENV UV_SYSTEM_PYTHON=1
ENV UV_PROJECT_ENVIRONMENT=/usr/local

# Copy project files and install dependencies as root, using the lock so the
# baked-in install matches what `uv sync --frozen` expects at runtime.
COPY pyproject.toml uv.lock /workspaces/dev-repo/
WORKDIR /workspaces/dev-repo
RUN uv sync --frozen --no-install-project

# Grant vscode user write access to the entire /usr/local tree — uv treats it
# as the project env, so it writes to bin/, lib/, share/, include/ etc.
RUN chown -R vscode:vscode /usr/local

# Switch to vscode user for runtime
USER vscode
