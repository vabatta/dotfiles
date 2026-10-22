// https://github.com/anomalyco/opencode/issues/46527#issuecomment-5537060564
import type { Plugin } from "@opencode-ai/plugin";

const plugin: Plugin = async () => {
  return {
    provider: {
      id: "openai",
      async models(provider, ctx) {
        if (ctx.auth?.type !== "oauth") {
          return provider.models;
        }

        const models = { ...provider.models };
        for (const [modelId, model] of Object.entries(provider.models)) {
          if (!modelId.startsWith("gpt-5.6-")) {
            continue;
          }

          models[`${modelId}-1m`] = {
            ...model,
            name: `${model.name} (1M context)`,
            limit: {
              context: 1_000_000,
              input: 872_000,
              output: 128_000,
            },
          };
        }

        return models;
      },
    },
  };
};

export default plugin;
