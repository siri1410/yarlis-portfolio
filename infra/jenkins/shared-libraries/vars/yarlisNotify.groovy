/**
 * Yarlis Shared Library — yarlisNotify
 * Usage: yarlisNotify.telegram("Deploy complete ✅")
 */
def telegram(String message) {
  sh """
    curl -s -X POST "https://api.telegram.org/bot\${TELEGRAM_BOT_TOKEN}/sendMessage" \
      -d chat_id=5764179434 \
      -d text="🔱 CI/CD: ${message}"
  """
}

def success(String job) { telegram("✅ ${job} passed") }
def failure(String job) { telegram("🔴 ${job} FAILED — check ci.yarlis.ai") }
