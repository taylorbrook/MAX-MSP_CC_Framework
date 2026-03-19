#!/usr/bin/env bash
set -euo pipefail

REPO="taylorbrook/MAX-MSP_CC_Framework"
RELEASE_URL="https://github.com/${REPO}/releases/latest/download/framework.tar.gz"

# ---------------------------------------------------------------------------
# Argument handling
# ---------------------------------------------------------------------------

if [ $# -eq 0 ]; then
  echo "Usage: install.sh <project-name>" >&2
  echo "" >&2
  echo "  curl -fsSL https://raw.githubusercontent.com/${REPO}/main/install.sh | bash -s my-project" >&2
  exit 1
fi

PROJECT_NAME="$1"

if [ -d "$PROJECT_NAME" ]; then
  echo "Error: Directory '${PROJECT_NAME}' already exists." >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# Cleanup on failure
# ---------------------------------------------------------------------------

cleanup() {
  if [ -d "$PROJECT_NAME" ]; then
    rm -rf "$PROJECT_NAME"
  fi
}
trap cleanup ERR

# ---------------------------------------------------------------------------
# Install
# ---------------------------------------------------------------------------

echo ""
echo "Creating MAX/MSP Claude Code Framework in ${PROJECT_NAME}..."
echo ""

mkdir -p "$PROJECT_NAME"
curl -fsSL "$RELEASE_URL" | tar xz -C "$PROJECT_NAME" --strip-components=1

# Create patches directory and active-project config
mkdir -p "${PROJECT_NAME}/patches"
echo '{"active_project": null}' > "${PROJECT_NAME}/patches/.active-project.json"

# Initialize git repo
git init "$PROJECT_NAME" > /dev/null 2>&1 || true

# ---------------------------------------------------------------------------
# Python version check
# ---------------------------------------------------------------------------

if command -v python3 &>/dev/null; then
  PY_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
  PY_MAJOR=$(echo "$PY_VERSION" | cut -d. -f1)
  PY_MINOR=$(echo "$PY_VERSION" | cut -d. -f2)
  if [ "$PY_MAJOR" -lt 3 ] || [ "$PY_MINOR" -lt 10 ]; then
    echo "WARNING: Python 3.10+ required. Found Python ${PY_VERSION}"
  fi
else
  echo "WARNING: Python 3 not found. The framework requires Python 3.10+ for the validation engine."
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo "Done! Your MAX/MSP Claude Code Framework project is ready."
echo ""
echo "Next steps:"
echo "  cd ${PROJECT_NAME}"
echo "  claude"
echo "  /max-new my-first-patch"
echo ""
echo "Prerequisites:"
echo "  - Claude Code (https://docs.anthropic.com/en/docs/claude-code)"
echo "  - MAX 9 (https://cycling74.com/products/max)"
echo "  - Python 3.10+ (for the validation engine)"
echo ""
