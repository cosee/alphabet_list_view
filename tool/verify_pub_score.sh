#!/usr/bin/env bash
set -euo pipefail

# Runs `pana . --no-warning` and verifies the package score is >= desired score.
# Usage:
#   ./verify_pub_score.sh        # require perfect score
#   ./verify_pub_score.sh 100    # require at least 100 points

if ! PANA_OUTPUT="$(pana . --no-warning)"; then
  echo "pana failed (non-zero exit). Make sure 'pana' is installed and runs successfully." >&2
  exit 1
fi
readonly PANA_OUTPUT

if [[ ! $PANA_OUTPUT =~ Points:\ ([0-9]+)\/([0-9]+) ]]; then
  echo "Failed to parse pana output for Points: X/Y." >&2
  echo "pana output was:" >&2
  printf '%s\n' "$PANA_OUTPUT" >&2
  exit 1
fi

readonly SCORE="${BASH_REMATCH[1]}"
readonly TOTAL="${BASH_REMATCH[2]}"
readonly MINIMUM_SCORE="${1:-$TOTAL}"

if [[ ! "$MINIMUM_SCORE" =~ ^[0-9]+$ ]]; then
  echo "Minimum score must be a non-negative integer. Got: '$MINIMUM_SCORE'." >&2
  exit 1
fi

if (( MINIMUM_SCORE > TOTAL )); then
  echo "Warning: requested minimum (${MINIMUM_SCORE}) is greater than maximum possible (${TOTAL})." >&2
fi

echo "score: ${SCORE}/${TOTAL}"

if (( SCORE < MINIMUM_SCORE )); then
  echo "Minimum score ${MINIMUM_SCORE} was not met (actual ${SCORE})." >&2
  exit 1
fi
