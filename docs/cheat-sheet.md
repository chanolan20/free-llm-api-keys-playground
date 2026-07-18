# Provider Cheat Sheet

Quick-reference for free LLM API providers. Generated from provider-registry.md

## Free Tiers (No Credit Card Required)

| Provider | Base URL | Key Env | Free Limit | RPM | Notes |
|---|---|---|---|---|---|
| Groq | api.groq.com/openai/v1 | GROQ_API_KEY | 6K-12K TPM | 30 | Ultra-fast LPU |
| Ollama | localhost:11434/v1 | OLLAMA_API_KEY | Unlimited | None | 100% local |
| OpenRouter | openrouter.ai/api/v1 | OPENROUTER_API_KEY | 20 RPM/200 RPD | 20 | ~28 free models, 230+ total |
| Google AI Studio | generativelanguage.googleapis.com | GEMINI_API_KEY | 15 RPD/1500 RPD | 15 | 1M context|
| Mistral | api.mistral.ai/v1 | MISTRAL_API_KEY | ~1B tokens/mo | Varies | May train on data |
| DeepSeek | api.deepseek.com/v1 | DEEPSEEK_API_KEY | 5M signup tokens | Varies | Expires 30 days |
| NVIDIA NIM | integrate.api.nvidia.com/v1 | NVIDIA_API_KEY | Rate-limited | Varies | 100+ models |
| GitHub Models | models.github.ai/inference | GITHUB_TOKEN | 60 RPM/1440 RPD | 60 | 45+ models protoyping |
| HuggingFace | router.huggingface.co/v1 | HF_TOKEN | $0.10/mo credits | 200 | Routes to 6 backends |
| Cerebras | api.cerebras.ai/v1 | CEREBRAS_API_KEY | $5 credit, 5 RPM | 5 | Requires payment method |
| Cloudflare | workers-ai | CLOUDFLARE_API_TOKEN | 10K Neurons/day | N/A | 30+ models, edge |

## TTS Providers

| Provider | Free Tier | Key Env |
|---|---|---|
| ElevenLabs | 10K chars/month free | ELEVENLABS_API_KEY |
| Groq Whisper | 30 RPM/1440 RPD free | GROQ_API_KEY |

## Image Generation

| Provider | Free Tier | Key Env |
|---|---|---|
| Stability AI | 25 image credits on signup | STABILITY_API_KEY |
| Fal.ai | $1-2 credits on signup | FAL_KEY |
| DALL-E 3 (via pekpik) | $20-100 per shared key | sk-xxx token |

## Embeddings

| Provider | Free Tier | Key Env |
|---|---|---|
| Ollama Embed | Unlimited (local) | OLLAMA_API_KEY |
| Voyage AI | 50M tokens on signup | VOYAGE_API_KEY |
| Mistral Embed | ~1B tokens/month | MISTRAL_API_KEY |
| Cohere | Trial with caps | COHERE_API_KEY |

---
*See [provider-registry.md](./provider-registry.md) for full details*
