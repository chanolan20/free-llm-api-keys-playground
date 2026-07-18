# Free LLM API Providers - Master Consolidated Registry
Generated from: free-llm-api-keys (gateway), Frank AI (runtime), Clawd-Code (agent)

# Frank Master Provider Registry
# Purpose: single source of truth for AI, auth, database, and hosting providers.
# OpenCode/Cascade and Frank runtime code both consume this file.
# Last updated: 2026-07-18

metadata:
  version: "1.0.0"
  last_updated: "2026-07-18"
  source_of_truth: "frank/config/providers.yaml"
  legacy_source: "frank/config/llm_provider_catalog.json"
  policy: "Prefer free or local providers first; paid providers are fallback only."

# Priority order used by the runtime selector when no explicit provider is requested.
# Local/private first, then free cloud, then paid frontier.
default_priority:
  - ollama
  - github_models
  - huggingface
  - openrouter
  - groq
  - cerebras
  - mistral
  - google_ai_studio
  - deepseek
  - nvidia

providers:
  # ── Local / Self-hosted ──
  - id: ollama
    name: Ollama
    category: llm
    website: https://ollama.com
    docs_url: https://ollama.com/settings/keys
    description: Fully local LLM inference. No rate limits; bounded only by hardware.
    openai_compatible: true
    base_url: http://localhost:11434/v1
    env_key: OLLAMA_API_KEY
    free_tier:
      available: true
      unlimited: true
      notes: "Requires local Ollama server. Use `ollama serve` and enable OpenAI compatibility."
    models:
      - id: llama3.2:3b
        name: Llama 3.2 3B
        context: 128000
        recommended: true
      - id: llama3.3:70b
        name: Llama 3.3 70B
        context: 128000
        recommended: false
      - id: deepseek-r1:14b
        name: DeepSeek R1 14B
        context: 128000
        recommended: false
    tags: [local, privacy, free]
    privacy_note: "100% local; no data leaves the machine."

  # ── Free Cloud Inference ──
  - id: github_models
    name: GitHub Models
    category: llm
    website: https://github.com/marketplace/models
    docs_url: https://github.com/marketplace/models
    description: Free prototyping for GitHub users. 45+ models with per-request limits.
    openai_compatible: true
    base_url: https://models.github.ai/inference
    env_key: GITHUB_TOKEN
    free_tier:
      available: true
      rpm: 60
      rpd: 1440
      notes: "Per-request limits 8K in / 4K out. Limits vary by model."
    models:
      - id: github/gpt-4o-mini
        name: GPT-4o Mini
        context: 128000
        recommended: true
      - id: github/Phi-4
        name: Phi-4
        context: 128000
        recommended: false
    tags: [free, github, prototyping]
    privacy_note: "Subject to GitHub Terms of Service."

  - id: huggingface
    name: Hugging Face Inference Providers
    category: llm
    website: https://huggingface.co
    docs_url: https://huggingface.co/settings/tokens
    description: 100K monthly Inference Provider credits for free users. Routes to Fireworks, Together, Hyperbolic, Nebius, Novita, DeepInfra and others.
    openai_compatible: true
    base_url: https://router.huggingface.co/v1
    env_key: HUGGINGFACE_API_KEY
    free_tier:
      available: true
      monthly_credits_usd: 0.10
      notes: "Rate-limited; cold-start latency applies. Best for models <10B params."
    models:
      - id: meta-llama/Llama-3.2-3B-Instruct
        name: Llama 3.2 3B Instruct
        context: 128000
        recommended: true
    tags: [free, open-models, routing]
    privacy_note: "Check individual backend provider terms; some may use data for training."

  - id: openrouter
    name: OpenRouter
    category: llm
    website: https://openrouter.ai
    docs_url: https://openrouter.ai/keys
    description: Universal gateway with ~28 free models (marked :free). Single API key for many providers.
    openai_compatible: true
    base_url: https://openrouter.ai/api/v1
    env_key: OPENROUTER_API_KEY
    free_tier:
      available: true
      rpm: 20
      rpd: 200
      notes: "Free models only. $10 lifetime top-up raises RPD to 1000."
    models:
      - id: openrouter/google/gemini-flash-1.5:free
        name: Gemini Flash 1.5 (free)
        context: 1000000
        recommended: true
      - id: openrouter/meta-llama/llama-3.2-3b-instruct:free
        name: Llama 3.2 3B (free)
        context: 128000
        recommended: false
    tags: [free, failover, multi-model]
    privacy_note: "Inputs may be used for provider routing/telemetry. Avoid PII."

  - id: groq
    name: Groq
    category: llm
    website: https://groq.com
    docs_url: https://console.groq.com/keys
    description: Extremely fast inference via LPU. Fully OpenAI-compatible.
    openai_compatible: true
    base_url: https://api.groq.com/openai/v1
    env_key: GROQ_API_KEY
    free_tier:
      available: true
      rpm: 30
      rpd: 1440
      notes: "Token limits vary 6K–12K TPM depending on model."
    models:
      - id: llama-3.3-70b-versatile
        name: Llama 3.3 70B Versatile
        context: 128000
        recommended: true
      - id: mixtral-8x7b-32768
        name: Mixtral 8x7B
        context: 32768
        recommended: false
    tags: [free, fast, low-latency]
    privacy_note: "Groq processes inputs on their infrastructure; review DPA."

  - id: cerebras
    name: Cerebras
    category: llm
    website: https://cerebras.ai
    docs_url: https://cloud.cerebras.ai/
    description: Very high speed inference. Free tier with 1M tokens/day.
    openai_compatible: true
    base_url: https://api.cerebras.ai/v1
    env_key: CEREBRAS_API_KEY
    free_tier:
      available: true
      daily_tokens: 1000000
      rpm: 30
      notes: "8K context limit on free tier. Dual-bucket rate limit."
    models:
      - id: llama-3.1-8b
        name: Llama 3.1 8B
        context: 8192
        recommended: true
      - id: llama-3.1-70b
        name: Llama 3.1 70B
        context: 8192
        recommended: false
    tags: [free, throughput]
    privacy_note: "Data processed on Cerebras Cloud."

  - id: mistral
    name: Mistral AI
    category: llm
    website: https://mistral.ai
    docs_url: https://console.mistral.ai/api-keys
    description: Open-weights leader. Experiment tier with ~1B tokens/month.
    openai_compatible: true
    base_url: https://api.mistral.ai/v1
    env_key: MISTRAL_API_KEY
    free_tier:
      available: true
      monthly_tokens: 1000000000
      notes: "Requires opting into data training for free quota."
    models:
      - id: mistral-small-latest
        name: Mistral Small
        context: 32000
        recommended: true
      - id: open-mistral-nemo
        name: Mistral Nemo
        context: 128000
        recommended: false
    tags: [free, open-weights, high-volume]
    privacy_note: "Free tier may use inputs/outputs for model training unless opted out."

  - id: google_ai_studio
    name: Google AI Studio / Gemini
    category: llm
    website: https://aistudio.google.com
    docs_url: https://ai.google.dev/gemini-api/docs/api-key
    description: Generous free tier with 1M token context window on Gemini Flash.
    openai_compatible: false
    base_url: https://generativelanguage.googleapis.com/v1beta
    env_key: GEMINI_API_KEY
    free_tier:
      available: true
      rpm: 15
      rpd: 1500
      notes: "1M context on Flash. Free-tier prompts may be used to improve Google products (except EU/UK/EEA)."
    models:
      - id: gemini-2.5-flash
        name: Gemini 2.5 Flash
        context: 1000000
        recommended: true
      - id: gemini-2.5-pro
        name: Gemini 2.5 Pro
        context: 2000000
        recommended: false
    tags: [free, long-context, multimodal]
    privacy_note: "Free-tier prompts may be used to improve Google products outside EU/UK/EEA."

  - id: deepseek
    name: DeepSeek
    category: llm
    website: https://deepseek.com
    docs_url: https://platform.deepseek.com/api_keys
    description: 5M free tokens on signup; pay-as-you-go after 30 days.
    openai_compatible: true
    base_url: https://api.deepseek.com/v1
    env_key: DEEPSEEK_API_KEY
    free_tier:
      available: true
      signup_tokens: 5000000
      notes: "Credits expire 30 days after signup. Prompts may be used for training unless opted out."
    models:
      - id: deepseek-chat
        name: DeepSeek V3
        context: 64000
        recommended: true
      - id: deepseek-reasoner
        name: DeepSeek R1
        context: 64000
        recommended: false
    tags: [free-trial, reasoning]
    privacy_note: "Prompts may be used for training unless opted out."

  - id: nvidia
    name: NVIDIA NIM
    category: llm
    website: https://build.nvidia.com
    docs_url: https://build.nvidia.com/explore/discover
    description: Free with NVIDIA Developer Program membership. 100+ models.
    openai_compatible: true
    base_url: https://integrate.api.nvidia.com/v1
    env_key: NVIDIA_API_KEY
    free_tier:
      available: true
      notes: "Rate-limited; no daily token cap. Requires NVIDIA Developer Program."
    models:
      - id: meta/llama3-8b-instruct
        name: Llama 3 8B Instruct
        context: 8192
        recommended: true
    tags: [free, nvidia, gpu]
    privacy_note: "Subject to NVIDIA AI Foundation Terms."

  # ── Paid Frontier (fallback only) ──
  - id: openai
    name: OpenAI
    category: llm
    website: https://openai.com
    docs_url: https://platform.openai.com/api-keys
    description: Frontier models. Paid-only for production usage.
    openai_compatible: true
    base_url: https://api.openai.com/v1
    env_key: OPENAI_API_KEY
    free_tier:
      available: false
      notes: "No permanent free tier; pay-as-you-go."
    models:
      - id: gpt-5.5
        name: GPT-5.5
        context: 128000
        recommended: false
      - id: gpt-4o
        name: GPT-4o
        context: 128000
        recommended: false
    tags: [paid, frontier]
    privacy_note: "Enterprise privacy options available with BAA."

  - id: anthropic
    name: Anthropic
    category: llm
    website: https://anthropic.com
    docs_url: https://console.anthropic.com/settings/keys
    description: Claude family. Paid-only for production usage.
    openai_compatible: false
    base_url: https://api.anthropic.com/v1
    env_key: ANTHROPIC_API_KEY
    free_tier:
      available: false
      notes: "No permanent free tier; paid API only."
    models:
      - id: claude-opus-4
        name: Claude Opus 4
        context: 200000
        recommended: false
      - id: claude-sonnet-4
        name: Claude Sonnet 4
        context: 200000
        recommended: false
    tags: [paid, frontier, reasoning]
    privacy_note: "Enterprise privacy options available."

  - id: xai
    name: xAI
    category: llm
    website: https://x.ai
    docs_url: https://console.x.ai
    description: Grok models. Paid-only for production usage.
    openai_compatible: true
    base_url: https://api.x.ai/v1
    env_key: XAI_API_KEY
    free_tier:
      available: false
      notes: "No permanent free tier."
    models:
      - id: grok-4.1-fast-non-reasoning
        name: Grok 4.1 Fast
        context: 128000
        recommended: false
    tags: [paid, frontier]
    privacy_note: "xAI processes data on their infrastructure."

  # ── Image Generation ──
  - id: stability
    name: Stability AI
    category: image
    website: https://stability.ai
    docs_url: https://platform.stability.ai
    description: Image generation via Stable Diffusion. Free trial credits on signup.
    openai_compatible: false
    base_url: https://api.stability.ai/v2beta
    env_key: STABILITY_API_KEY
    free_tier:
      available: true
      signup_tokens: 25
      notes: "25 image credits on signup; pay-as-you-go after."
    models:
      - id: stable-image-ultra
        name: Stable Image Ultra
        recommended: true
      - id: stable-image-core
        name: Stable Image Core
        recommended: false
    tags: [image, free-trial]
    privacy_note: "Images processed on Stability AI infrastructure."

  - id: fal
    name: Fal.ai
    category: image
    website: https://fal.ai
    docs_url: https://fal.ai/dashboard/keys
    description: Fast image and video generation with Flux and other models. Pay-as-you-go with free credits on signup.
    openai_compatible: true
    base_url: https://fal.ai/api/v1
    env_key: FAL_KEY
    free_tier:
      available: true
      signup_tokens: 1000
      notes: "$1-2 free credits on signup; OpenAI-compatible image generations endpoint."
    models:
      - id: fal-ai/flux/schnell
        name: Flux Schnell
        recommended: true
      - id: fal-ai/flux/dev
        name: Flux Dev
        recommended: false
    tags: [image, fast, openai-compatible]
    privacy_note: "Images processed on Fal.ai infrastructure."

  - id: openrouter_image
    name: OpenRouter Image
    category: image
    website: https://openrouter.ai
    docs_url: https://openrouter.ai/keys
    description: Image generation through OpenRouter's unified gateway.
    openai_compatible: true
    base_url: https://openrouter.ai/api/v1
    env_key: OPENROUTER_API_KEY
    free_tier:
      available: true
      notes: "Aggregates many image models; free availability varies by model."
    models:
      - id: openrouter/flux/schnell
        name: Flux Schnell via OpenRouter
        recommended: true
    tags: [image, aggregator, openai-compatible]
    privacy_note: "Inputs may be used for provider routing/telemetry."

  # ── Speech / Audio ──
  - id: groq_whisper
    name: Groq Whisper
    category: speech
    website: https://groq.com
    docs_url: https://console.groq.com/keys
    description: Extremely fast OpenAI-compatible Whisper speech-to-text.
    openai_compatible: true
    base_url: https://api.groq.com/openai/v1
    env_key: GROQ_API_KEY
    free_tier:
      available: true
      rpm: 30
      rpd: 1440
      notes: "Audio files limited to 25MB on free tier."
    models:
      - id: whisper-large-v3
        name: Whisper Large v3
        recommended: true
      - id: whisper-large-v3-turbo
        name: Whisper Large v3 Turbo
        recommended: false
    tags: [speech, stt, fast, openai-compatible]
    privacy_note: "Audio processed on Groq infrastructure."

  - id: openai_whisper
    name: OpenAI Whisper
    category: speech
    website: https://openai.com
    docs_url: https://platform.openai.com/api-keys
    description: OpenAI's Whisper STT and TTS. Paid-only but common fallback.
    openai_compatible: true
    base_url: https://api.openai.com/v1
    env_key: OPENAI_API_KEY
    free_tier:
      available: false
      notes: "Pay-as-you-go; no permanent free tier."
    models:
      - id: whisper-1
        name: Whisper
        recommended: true
      - id: tts-1
        name: TTS
        recommended: false
    tags: [speech, stt, tts, paid]
    privacy_note: "Audio processed on OpenAI infrastructure."

  - id: elevenlabs
    name: ElevenLabs
    category: speech
    website: https://elevenlabs.io
    docs_url: https://elevenlabs.io/app/settings/api
    description: High-quality text-to-speech and voice cloning.
    openai_compatible: false
    base_url: https://api.elevenlabs.io/v1
    env_key: ELEVENLABS_API_KEY
    free_tier:
      available: true
      monthly_credits_usd: 5.0
      notes: "10K characters/month free tier."
    models:
      - id: eleven_multilingual_v2
        name: Eleven Multilingual v2
        recommended: true
    tags: [speech, tts, free]
    privacy_note: "Voice data processed on ElevenLabs infrastructure."

  # ── Embeddings / RAG ──
  - id: ollama_embed
    name: Ollama Embeddings
    category: embeddings
    website: https://ollama.com
    docs_url: https://ollama.com/settings/keys
    description: Fully local embedding models via Ollama.
    openai_compatible: true
    base_url: http://localhost:11434/v1
    env_key: OLLAMA_API_KEY
    free_tier:
      available: true
      unlimited: true
      notes: "Requires local Ollama server."
    models:
      - id: nomic-embed-text
        name: Nomic Embed Text
        context: 2048
        recommended: true
      - id: mxbai-embed-large
        name: Mixedbread Embed Large
        context: 512
        recommended: false
    tags: [embeddings, local, privacy, free]
    privacy_note: "100% local; no data leaves the machine."

  - id: voyage
    name: Voyage AI
    category: embeddings
    website: https://voyageai.com
    docs_url: https://dash.voyageai.com
    description: High-quality embeddings for retrieval. 50M free tokens on signup.
    openai_compatible: true
    base_url: https://api.voyageai.com/v1
    env_key: VOYAGE_API_KEY
    free_tier:
      available: true
      signup_tokens: 50000000
      notes: "50M tokens free trial; then pay-as-you-go."
    models:
      - id: voyage-3
        name: Voyage 3
        context: 32000
        recommended: true
      - id: voyage-3-lite
        name: Voyage 3 Lite
        context: 32000
        recommended: false
    tags: [embeddings, retrieval, free-trial]
    privacy_note: "Data processed on Voyage AI infrastructure."

  - id: openai_embed
    name: OpenAI Embeddings
    category: embeddings
    website: https://openai.com
    docs_url: https://platform.openai.com/api-keys
    description: OpenAI text embeddings. Paid-only but common fallback.
    openai_compatible: true
    base_url: https://api.openai.com/v1
    env_key: OPENAI_API_KEY
    free_tier:
      available: false
      notes: "Pay-as-you-go; no permanent free tier."
    models:
      - id: text-embedding-3-small
        name: Text Embedding 3 Small
        context: 8192
        recommended: true
    tags: [embeddings, paid]
    privacy_note: "Data processed on OpenAI infrastructure."

  - id: huggingface_embed
    name: Hugging Face Embeddings
    category: embeddings
    website: https://huggingface.co
    docs_url: https://huggingface.co/settings/tokens
    description: Inference API for thousands of embedding models.
    openai_compatible: false
    base_url: https://api-inference.huggingface.co
    env_key: HUGGINGFACE_API_KEY
    free_tier:
      available: true
      rpm: 200
      notes: "Anonymous 500 req/5min; registered 1,000 req/5min."
    models:
      - id: sentence-transformers/all-MiniLM-L6-v2
        name: MiniLM L6 v2
        context: 512
        recommended: true
    tags: [embeddings, open-models, free]
    privacy_note: "Check individual model/provider terms."

  - id: mistral_embed
    name: Mistral Embeddings
    category: embeddings
    website: https://mistral.ai
    docs_url: https://console.mistral.ai/api-keys
    description: OpenAI-compatible embedding models.
    openai_compatible: true
    base_url: https://api.mistral.ai/v1
    env_key: MISTRAL_API_KEY
    free_tier:
      available: true
      monthly_tokens: 1000000000
      notes: "Experiment tier with rate limits."
    models:
      - id: mistral-embed
        name: Mistral Embed
        context: 8192
        recommended: true
    tags: [embeddings, openai-compatible, free]
    privacy_note: "Free tier may use inputs/outputs for training unless opted out."

  - id: cohere
    name: Cohere
    category: embeddings
    website: https://cohere.com
    docs_url: https://dashboard.cohere.com/api-keys
    description: Embeddings and rerank models with a trial tier.
    openai_compatible: false
    base_url: https://api.cohere.com/v1
    env_key: COHERE_API_KEY
    free_tier:
      available: true
      rpm: 5
      notes: "Trial tier with usage caps."
    models:
      - id: embed-english-v3
        name: Embed English v3
        context: 512
        recommended: true
    tags: [free, embeddings, rerank]
    privacy_note: "Trial tier data handling; review terms."

  # ── Auth / Identity ──
  - id: supabase_auth
    name: Supabase Auth
    category: auth
    website: https://supabase.com
    docs_url: https://supabase.com/docs/guides/auth
    description: PostgreSQL-backed auth. 50,000 MAU free.
    env_key: SUPABASE_URL
    free_tier:
      available: true
      mau: 50000
      notes: "500MB DB + 1GB storage. Projects pause after 1 week inactivity."
    tags: [free, postgres, full-stack]
    privacy_note: "Self-host or use managed service per Supabase DPA."

  - id: firebase_auth
    name: Firebase Authentication
    category: auth
    website: https://firebase.google.com
    docs_url: https://firebase.google.com/docs/auth
    description: Google-backed auth. Standard auth is effectively unlimited MAU.
    env_key: FIREBASE_API_KEY
    free_tier:
      available: true
      mau: 50000
      notes: "50K MAU for Identity Platform features; standard auth is free at scale."
    tags: [free, google, mobile]
    privacy_note: "Google Terms of Service apply."

  - id: clerk
    name: Clerk
    category: auth
    website: https://clerk.com
    docs_url: https://dashboard.clerk.com
    description: Developer-first auth for React/Next.js. 10,000 MAU free.
    env_key: CLERK_SECRET_KEY
    free_tier:
      available: true
      mau: 10000
      notes: "Includes social logins and multi-session."
    tags: [free, react, nextjs]
    privacy_note: "Clerk processes auth data; SOC2 compliant."

  - id: auth0
    name: Auth0
    category: auth
    website: https://auth0.com
    docs_url: https://manage.auth0.com
    description: Enterprise identity platform. 7,500 active users free.
    env_key: AUTH0_DOMAIN
    free_tier:
      available: true
      mau: 7500
      notes: "Standard social/database connections included."
    tags: [free, enterprise, sso]
    privacy_note: "Auth0 processes identity data; enterprise BAA available."

  - id: keycloak
    name: Keycloak
    category: auth
    website: https://www.keycloak.org
    docs_url: https://www.keycloak.org/documentation
    description: Open-source identity and access management. Self-hosted.
    env_key: KEYCLOAK_URL
    free_tier:
      available: true
      unlimited: true
      notes: "Unlimited users if self-hosted. Requires infrastructure management."
    tags: [open-source, self-hosted, unlimited]
    privacy_note: "100% self-hosted; full data control."

  # ── Database / Hosting ──
  - id: supabase_db
    name: Supabase Database
    category: database
    website: https://supabase.com
    docs_url: https://supabase.com/docs/guides/database
    description: Managed PostgreSQL with auth, storage, and realtime.
    env_key: SUPABASE_URL
    free_tier:
      available: true
      storage_mb: 500
      notes: "500MB DB + 1GB storage + 50K MAU auth."
    tags: [free, postgres, baas]
    privacy_note: "Managed service; self-host option available."

  - id: cloudflare_d1
    name: Cloudflare D1
    category: database
    website: https://developers.cloudflare.com/d1
    docs_url: https://developers.cloudflare.com/d1
    description: Edge SQLite database. 500MB per DB, 5GB total per account.
    env_key: CLOUDFLARE_ACCOUNT_ID
    free_tier:
      available: true
      storage_mb: 512
      notes: "Best for Worker-native apps. 1,000 queries per invocation limit."
    tags: [free, edge, sqlite]
    privacy_note: "Cloudflare edge processing; DPA available."

  - id: neon
    name: Neon
    category: database
    website: https://neon.tech
    docs_url: https://neon.tech/docs
    description: Serverless Postgres with branching.
    env_key: NEON_DATABASE_URL
    free_tier:
      available: true
      storage_mb: 512
      notes: "100 projects free; 100 CU-hours/project/month; 5GB outbound."
    tags: [free, postgres, serverless]
    privacy_note: "Neon processes data; SOC2 compliant."

  - id: turso
    name: Turso
    category: database
    website: https://turso.tech
    docs_url: https://docs.turso.tech
    description: LibSQL edge database. 9GB total storage.
    env_key: TURSO_DATABASE_URL
    free_tier:
      available: true
      storage_gb: 9
      notes: "Unlimited databases; throughput-limited."
    tags: [free, sqlite, edge]
    privacy_note: "Turso edge processing; SOC2 compliant."

  - id: mongodb_atlas
    name: MongoDB Atlas
    category: database
    website: https://mongodb.com
    docs_url: https://www.mongodb.com/docs/atlas
    description: Managed MongoDB. M0 cluster free.
    env_key: MONGODB_URI
    free_tier:
      available: true
      notes: "M0 shared cluster with storage limits."
    tags: [free, nosql, document]
    privacy_note: "MongoDB Atlas terms apply."

  - id: vercel
    name: Vercel
    category: hosting
    website: https://vercel.com
    docs_url: https://vercel.com/docs
    description: Frontend/edge hosting. Hobby plan free for non-commercial.
    env_key: VERCEL_TOKEN
    free_tier:
      available: true
      notes: "Unlimited hobby projects; build/deployment limits apply."
    tags: [free, nextjs, edge]
    privacy_note: "Vercel processes deployment data."

  - id: render
    name: Render
    category: hosting
    website: https://render.com
    docs_url: https://render.com/docs
    description: Web services, static sites, and Postgres. 750 free hours/month.
    env_key: RENDER_API_KEY
    free_tier:
      available: true
      hours_monthly: 750
      notes: "Free DBs expire after 30 days. Web services spin down after inactivity."
    tags: [free, hobby, prototyping]
    privacy_note: "Render processes deployment data."
---
Generated from Frank config/providers.yaml
<!---
WARNING: DO NOT EDIT THIS FILE DIRECTLY. IT IS GENERATED BY src/pull_available_models.py
--->
# Free LLM API resources

This lists various services that provide free access or credits towards API-based LLM usage.

> [!NOTE]  
> Please don't abuse these services, else we might lose them.

> [!WARNING]  
> This list explicitly excludes any services that are not legitimate (eg reverse engineers an existing chatbot)

- [Free Providers](#free-providers)
  - [OpenRouter](#openrouter)
  - [Google AI Studio](#google-ai-studio)
  - [NVIDIA NIM](#nvidia-nim)
  - [Mistral (La Plateforme)](#mistral-la-plateforme)
  - [Mistral (Codestral)](#mistral-codestral)
  - [HuggingFace Inference Providers](#huggingface-inference-providers)
  - [Vercel AI Gateway](#vercel-ai-gateway)
  - [OpenCode Zen](#opencode-zen)
  - [Cerebras](#cerebras)
  - [Groq](#groq)
  - [Cohere](#cohere)
  - [GitHub Models](#github-models)
  - [Cloudflare Workers AI](#cloudflare-workers-ai)
- [Providers with trial credits](#providers-with-trial-credits)
  - [Fireworks](#fireworks)
  - [Baseten](#baseten)
  - [Nebius](#nebius)
  - [Novita](#novita)
  - [AI21](#ai21)
  - [Upstage](#upstage)
  - [NLP Cloud](#nlp-cloud)
  - [Alibaba Cloud (International) Model Studio](#alibaba-cloud-international-model-studio)
  - [Modal](#modal)
  - [Inference.net](#inferencenet)
  - [Hyperbolic](#hyperbolic)
  - [SambaNova Cloud](#sambanova-cloud)
  - [Scaleway Generative APIs](#scaleway-generative-apis)

## Free Providers

### [OpenRouter](https://openrouter.ai)

**Limits:**

[20 requests/minute<br>50 requests/day<br>Up to 1000 requests/day with $10 lifetime topup](https://openrouter.ai/docs/api/reference/limits)

Models share a common quota.

- [Hermes 3 Llama 3.1 405B](https://openrouter.ai/nousresearch/hermes-3-llama-3.1-405b:free)
- [Llama 3.2 3B Instruct](https://openrouter.ai/meta-llama/llama-3.2-3b-instruct:free)
- [Llama 3.3 70B Instruct](https://openrouter.ai/meta-llama/llama-3.3-70b-instruct:free)
- [arcee-ai/trinity-large-thinking:free](https://openrouter.ai/arcee-ai/trinity-large-thinking:free)
- [baidu/cobuddy:free](https://openrouter.ai/baidu/cobuddy:free)
- [cognitivecomputations/dolphin-mistral-24b-venice-edition:free](https://openrouter.ai/cognitivecomputations/dolphin-mistral-24b-venice-edition:free)
- [deepseek/deepseek-v4-flash:free](https://openrouter.ai/deepseek/deepseek-v4-flash:free)
- [google/gemma-4-26b-a4b-it:free](https://openrouter.ai/google/gemma-4-26b-a4b-it:free)
- [google/gemma-4-31b-it:free](https://openrouter.ai/google/gemma-4-31b-it:free)
- [liquid/lfm-2.5-1.2b-instruct:free](https://openrouter.ai/liquid/lfm-2.5-1.2b-instruct:free)
- [liquid/lfm-2.5-1.2b-thinking:free](https://openrouter.ai/liquid/lfm-2.5-1.2b-thinking:free)
- [minimax/minimax-m2.5:free](https://openrouter.ai/minimax/minimax-m2.5:free)
- [nvidia/nemotron-3-nano-30b-a3b:free](https://openrouter.ai/nvidia/nemotron-3-nano-30b-a3b:free)
- [nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free](https://openrouter.ai/nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free)
- [nvidia/nemotron-3-super-120b-a12b:free](https://openrouter.ai/nvidia/nemotron-3-super-120b-a12b:free)
- [nvidia/nemotron-nano-12b-v2-vl:free](https://openrouter.ai/nvidia/nemotron-nano-12b-v2-vl:free)
- [nvidia/nemotron-nano-9b-v2:free](https://openrouter.ai/nvidia/nemotron-nano-9b-v2:free)
- [openai/gpt-oss-120b:free](https://openrouter.ai/openai/gpt-oss-120b:free)
- [openai/gpt-oss-20b:free](https://openrouter.ai/openai/gpt-oss-20b:free)
- [poolside/laguna-m.1:free](https://openrouter.ai/poolside/laguna-m.1:free)
- [poolside/laguna-xs.2:free](https://openrouter.ai/poolside/laguna-xs.2:free)
- [qwen/qwen3-coder:free](https://openrouter.ai/qwen/qwen3-coder:free)
- [qwen/qwen3-next-80b-a3b-instruct:free](https://openrouter.ai/qwen/qwen3-next-80b-a3b-instruct:free)
- [z-ai/glm-4.5-air:free](https://openrouter.ai/z-ai/glm-4.5-air:free)

### [Google AI Studio](https://aistudio.google.com)

Data is used for training when used outside of the UK/CH/EEA/EU.

<table><thead><tr><th>Model Name</th><th>Model Limits</th></tr></thead><tbody>
<tr><td>Gemini 3 Flash</td><td>250,000 tokens/minute<br>20 requests/day<br>5 requests/minute</td></tr>
<tr><td>Gemini 3.1 Flash-Lite</td><td>250,000 tokens/minute<br>500 requests/day<br>15 requests/minute</td></tr>
<tr><td>Gemini 2.5 Flash</td><td>250,000 tokens/minute<br>20 requests/day<br>5 requests/minute</td></tr>
<tr><td>Gemini 2.5 Flash-Lite</td><td>250,000 tokens/minute<br>20 requests/day<br>10 requests/minute</td></tr>
<tr><td>Gemini 3.1 Flash TTS</td><td>10,000 tokens/minute<br>10 requests/day<br>3 requests/minute</td></tr>
<tr><td>Gemini 2.5 Flash TTS</td><td>10,000 tokens/minute<br>10 requests/day<br>3 requests/minute</td></tr>
<tr><td>Gemini Robotics-ER 1.6</td><td>250,000 tokens/minute<br>20 requests/day<br>5 requests/minute</td></tr>
<tr><td>Gemini Robotics-ER 1.5</td><td>250,000 tokens/minute<br>20 requests/day<br>10 requests/minute</td></tr>
<tr><td>Gemma 3 27B Instruct</td><td>15,000 tokens/minute<br>14,400 requests/day<br>30 requests/minute</td></tr>
<tr><td>Gemma 3 12B Instruct</td><td>15,000 tokens/minute<br>14,400 requests/day<br>30 requests/minute</td></tr>
<tr><td>Gemma 3 4B Instruct</td><td>15,000 tokens/minute<br>14,400 requests/day<br>30 requests/minute</td></tr>
<tr><td>Gemma 3 1B Instruct</td><td>15,000 tokens/minute<br>14,400 requests/day<br>30 requests/minute</td></tr>
</tbody></table>

### [NVIDIA NIM](https://build.nvidia.com/explore/discover)

Phone number verification required.
Models tend to be context window limited.

**Limits:** 40 requests/minute

- [Various open models](https://build.nvidia.com/models)

### [Mistral (La Plateforme)](https://console.mistral.ai/)

* Free tier (Experiment plan) requires opting into data training
* Requires phone number verification.

**Limits (per-model):** 1 request/second, 500,000 tokens/minute, 1,000,000,000 tokens/month

- [Open and Proprietary Mistral models](https://docs.mistral.ai/getting-started/models/models_overview/)

### [Mistral (Codestral)](https://codestral.mistral.ai/)

* Currently free to use
* Monthly subscription based
* Requires phone number verification

**Limits:** 30 requests/minute, 2,000 requests/day

- Codestral

### [HuggingFace Inference Providers](https://huggingface.co/docs/inference-providers/en/index)

HuggingFace Serverless Inference limited to models smaller than 10GB. Some popular models are supported even if they exceed 10GB.

**Limits:** [$0.10/month in credits](https://huggingface.co/docs/inference-providers/en/pricing)

- Various open models across supported providers

### [Vercel AI Gateway](https://vercel.com/docs/ai-gateway)

Routes to various supported providers.

**Limits:** [$5/month](https://vercel.com/docs/ai-gateway/pricing)


### [OpenCode Zen](https://opencode.ai/docs/zen/)

AI gateway with curated models.

Free models may use data for improvement.

- Big Pickle Stealth
- MiniMax M2.5 Free
- Arcee Large Preview Free

### [Cerebras](https://cloud.cerebras.ai/)

<table><thead><tr><th>Model Name</th><th>Model Limits</th></tr></thead><tbody>
<tr><td>gpt-oss-120b</td><td>30 requests/minute<br>60,000 tokens/minute<br>900 requests/hour<br>1,000,000 tokens/hour<br>14,400 requests/day<br>1,000,000 tokens/day</td></tr>
<tr><td>Llama 3.1 8B</td><td>30 requests/minute<br>60,000 tokens/minute<br>900 requests/hour<br>1,000,000 tokens/hour<br>14,400 requests/day<br>1,000,000 tokens/day</td></tr>
</tbody></table>

### [Groq](https://console.groq.com)

<table><thead><tr><th>Model Name</th><th>Model Limits</th></tr></thead><tbody>
<tr><td>Allam 2 7B</td><td>7,000 requests/day<br>6,000 tokens/minute</td></tr>
<tr><td>Llama 3.1 8B</td><td>14,400 requests/day<br>6,000 tokens/minute</td></tr>
<tr><td>Llama 3.3 70B</td><td>1,000 requests/day<br>12,000 tokens/minute</td></tr>
<tr><td>Llama 4 Scout Instruct</td><td>1,000 requests/day<br>30,000 tokens/minute</td></tr>
<tr><td>Whisper Large v3</td><td>7,200 audio-seconds/minute<br>2,000 requests/day</td></tr>
<tr><td>Whisper Large v3 Turbo</td><td>7,200 audio-seconds/minute<br>2,000 requests/day</td></tr>
<tr><td>canopylabs/orpheus-arabic-saudi</td><td></td></tr>
<tr><td>canopylabs/orpheus-v1-english</td><td></td></tr>
<tr><td>groq/compound</td><td>250 requests/day<br>70,000 tokens/minute</td></tr>
<tr><td>groq/compound-mini</td><td>250 requests/day<br>70,000 tokens/minute</td></tr>
<tr><td>meta-llama/llama-prompt-guard-2-22m</td><td></td></tr>
<tr><td>meta-llama/llama-prompt-guard-2-86m</td><td></td></tr>
<tr><td>openai/gpt-oss-120b</td><td>1,000 requests/day<br>8,000 tokens/minute</td></tr>
<tr><td>openai/gpt-oss-20b</td><td>1,000 requests/day<br>8,000 tokens/minute</td></tr>
<tr><td>openai/gpt-oss-safeguard-20b</td><td>1,000 requests/day<br>8,000 tokens/minute</td></tr>
<tr><td>qwen/qwen3-32b</td><td>1,000 requests/day<br>6,000 tokens/minute</td></tr>
</tbody></table>

### [Cohere](https://cohere.com)

**Limits:**

[20 requests/minute<br>1,000 requests/month](https://docs.cohere.com/docs/rate-limits)

Models share a common monthly quota.

- c4ai-aya-expanse-32b
- c4ai-aya-vision-32b
- command-a-03-2025
- command-a-reasoning-08-2025
- command-a-translate-08-2025
- command-a-vision-07-2025
- command-r-08-2024
- command-r-plus-08-2024
- command-r7b-12-2024
- command-r7b-arabic-02-2025

### [GitHub Models](https://github.com/marketplace/models)

Extremely restrictive input/output token limits.

**Limits:** [Dependent on Copilot subscription tier (Free/Pro/Pro+/Business/Enterprise)](https://docs.github.com/en/github-models/prototyping-with-ai-models#rate-limits)

- AI21 Jamba 1.5 Large
- Codestral 25.01
- Cohere Command A
- Cohere Command R 08-2024
- Cohere Command R+ 08-2024
- DeepSeek-R1
- DeepSeek-R1-0528
- DeepSeek-V3-0324
- Grok 3
- Grok 3 Mini
- Llama 4 Maverick 17B 128E Instruct FP8
- Llama 4 Scout 17B 16E Instruct
- Llama-3.2-11B-Vision-Instruct
- Llama-3.2-90B-Vision-Instruct
- Llama-3.3-70B-Instruct
- MAI-DS-R1
- Meta-Llama-3.1-405B-Instruct
- Meta-Llama-3.1-8B-Instruct
- Ministral 3B
- Mistral Medium 3 (25.05)
- Mistral Small 3.1
- OpenAI GPT-4.1
- OpenAI GPT-4.1-mini
- OpenAI GPT-4.1-nano
- OpenAI GPT-4o
- OpenAI GPT-4o mini
- OpenAI Text Embedding 3 (large)
- OpenAI Text Embedding 3 (small)
- OpenAI gpt-5
- OpenAI gpt-5-chat (preview)
- OpenAI gpt-5-mini
- OpenAI gpt-5-nano
- OpenAI o1
- OpenAI o1-mini
- OpenAI o1-preview
- OpenAI o3
- OpenAI o3-mini
- OpenAI o4-mini
- Phi-4
- Phi-4-mini-instruct
- Phi-4-mini-reasoning
- Phi-4-multimodal-instruct
- Phi-4-reasoning

### [Cloudflare Workers AI](https://developers.cloudflare.com/workers-ai)

**Limits:** [10,000 neurons/day](https://developers.cloudflare.com/workers-ai/platform/pricing/#free-allocation)

- @cf/aisingapore/gemma-sea-lion-v4-27b-it
- @cf/google/gemma-4-26b-a4b-it
- @cf/ibm-granite/granite-4.0-h-micro
- @cf/moonshotai/kimi-k2.5
- @cf/moonshotai/kimi-k2.6
- @cf/nvidia/nemotron-3-120b-a12b
- @cf/openai/gpt-oss-120b
- @cf/openai/gpt-oss-20b
- @cf/qwen/qwen3-30b-a3b-fp8
- @cf/zai-org/glm-4.7-flash
- DeepSeek R1 Distill Qwen 32B
- Gemma 2B Instruct (LoRA)
- Gemma 3 12B Instruct
- Gemma 7B Instruct
- Gemma 7B Instruct (LoRA)
- Hermes 2 Pro Mistral 7B
- Llama 2 7B Chat (FP16)
- Llama 2 7B Chat (INT8)
- Llama 2 7B Chat (LoRA)
- Llama 3 8B Instruct
- Llama 3 8B Instruct (AWQ)
- Llama 3.1 8B Instruct (AWQ)
- Llama 3.1 8B Instruct (FP8)
- Llama 3.2 11B Vision Instruct
- Llama 3.2 1B Instruct
- Llama 3.2 3B Instruct
- Llama 3.3 70B Instruct (FP8)
- Llama 4 Scout Instruct
- Llama Guard 3 8B
- Mistral 7B Instruct v0.1
- Mistral 7B Instruct v0.2
- Mistral 7B Instruct v0.2 (LoRA)
- Mistral Small 3.1 24B Instruct
- Phi-2
- Qwen 2.5 Coder 32B Instruct
- Qwen QwQ 32B
- SQLCoder 7B 2

</tbody></table>



## Providers with trial credits

### [Fireworks](https://fireworks.ai/)

**Credits:** $1

**Models:** [Various open models](https://fireworks.ai/models)

### [Baseten](https://app.baseten.co/)

**Credits:** $30

**Models:** [Any supported model - pay by compute time](https://www.baseten.co/library/)

### [Nebius](https://tokenfactory.nebius.com/)

**Credits:** $1

**Models:** [Various open models](https://tokenfactory.nebius.com/models)

### [Novita](https://novita.ai/?ref=ytblmjc&utm_source=affiliate)

**Credits:** $0.5 for 1 year

**Models:** [Various open models](https://novita.ai/models)

### [AI21](https://studio.ai21.com/)

**Credits:** $10 for 3 months

**Models:** Jamba family of models

### [Upstage](https://console.upstage.ai/)

**Credits:** $10 for 3 months

**Models:** Solar Pro/Mini

### [NLP Cloud](https://nlpcloud.com/home)

**Credits:** $15

**Requirements:** Phone number verification

**Models:** Various open models

### [Alibaba Cloud (International) Model Studio](https://bailian.console.alibabacloud.com/)

**Credits:** 1 million tokens/model

**Models:** [Various open and proprietary Qwen models](https://www.alibabacloud.com/en/product/modelstudio)

### [Modal](https://modal.com)

**Credits:** $5/month upon sign up, $30/month with payment method added

**Models:** Any supported model - pay by compute time

### [Inference.net](https://inference.net)

**Credits:** $1, $25 on responding to email survey

**Models:** Various open models

### [Hyperbolic](https://app.hyperbolic.ai/)

**Credits:** $1

**Models:**
- DeepSeek V3 0324
- Llama 3.3 70B Instruct
- deepseek-ai/deepseek-r1-0528
- qwen/qwen3-coder-480b-a35b-instruct

### [SambaNova Cloud](https://cloud.sambanova.ai/)

**Credits:** $5 for 3 months

**Models:**
- Llama 3.3 70B
- Llama-4-Maverick-17B-128E-Instruct
- deepseek-ai/DeepSeek-V3.1
- deepseek-ai/DeepSeek-V3.2
- google/gemma-3-12b-it
- minimaxai/minimax-m2.7
- openai/gpt-oss-120b

### [Scaleway Generative APIs](https://console.scaleway.com/generative-api/models)

**Credits:** 1,000,000 free tokens

**Models:**
- BGE-Multilingual-Gemma2
- Gemma 3 27B Instruct
- Llama 3.3 70B Instruct
- Pixtral 12B (2409)
- Whisper Large v3
- devstral-2-123b-instruct-2512
- gemma-4-26b-a4b-it
- gpt-oss-120b
- holo2-30b-a3b
- mistral-small-3.2-24b-instruct-2506
- qwen3-235b-a22b-instruct-2507
- qwen3-coder-30b-a3b-instruct
- qwen3-embedding-8b
- qwen3.5-397b-a17b
- qwen3.6-35b-a3b
- voxtral-small-24b-2507



---

## Additional Trial-Credit Providers

The following providers offer trial credits (not permanent free tiers):

### Fireworks AI
- **Free tier:** Trial credits on signup
- **Offers:** Mixtral, Llama, Qwen, DeepSeek hosted inference
- **Website:** https://fireworks.ai

### Baseten
- **Free tier:** Trial credits on signup
- **Offers:** Serverless GPU inference for open models
- **Website:** https://baseten.co

### Nebius AI
- **Free tier:** Trial credits on signup
- **Offers:** GPU cloud for AI training and inference
- **Website:** https://nebius.com

### Novita AI
- **Free tier:** Trial credits on signup
- **Offers:** Affordable GPU inference for open-source LLMs
- **Website:** https://novita.ai

### AI21 Labs
- **Free tier:** Trial credits on signup
- **Offers:** Jamba, Jurassic-2 models
- **Website:** https://ai21.com

### Upstage
- **Free tier:** Trial credits on signup
- **Offers:** Solar LLM, document AI
- **Website:** https://upstage.ai

### NLP Cloud
- **Free tier:** Trial credits on signup
- **Offers:** Hosted open-source NLP models (GPT-J, GPT-NeoX, etc.)
- **Website:** https://nlpcloud.com

### Alibaba Cloud Model Studio
- **Free tier:** Trial credits on signup
- **Offers:** Qwen family models via international API
- **Website:** https://alibabacloud.com

### Modal
- **Free tier:** Trial credits on signup
- **Offers:** Serverless GPU compute for AI workloads
- **Website:** https://modal.com

### Inference.net
- **Free tier:** Trial credits on signup
- **Offers:** Distributed GPU inference for open models
- **Website:** https://inference.net

### Hyperbolic
- **Free tier:** Free inference credits on signup
- **Offers:** Open-source model inference, GPU rental
- **Website:** https://hyperbolic.xyz

### SambaNova Cloud
- **Free tier:** Free tier available
- **Offers:** Llama 3.1 405B, high-throughput inference
- **Website:** https://sambanova.ai

### Scaleway Generative APIs
- **Free tier:** Free tier available (EU-hosted)
- **Offers:** EU-hosted LLM inference, data sovereignty
- **Website:** https://scaleway.com

---
*Generated from free-llm-api-resources project (external drive)*

