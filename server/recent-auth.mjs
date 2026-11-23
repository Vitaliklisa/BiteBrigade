const MAX_AUTH_AGE_SECONDS = 5 * 60;
const CLOCK_SKEW_TOLERANCE_SECONDS = 60;

/**
 * @param {unknown} authTimeSeconds
 * @param {number} [nowSeconds]
 */
export function hasRecentAuthentication(
  authTimeSeconds,
  nowSeconds = Math.floor(Date.now() / 1000),
) {
  if (
    typeof authTimeSeconds !== "number" ||
    !Number.isSafeInteger(authTimeSeconds)
  ) {
    return false;
  }
  const ageSeconds = nowSeconds - authTimeSeconds;
  return (
    ageSeconds <= MAX_AUTH_AGE_SECONDS &&
    ageSeconds >= -CLOCK_SKEW_TOLERANCE_SECONDS
  );
}
